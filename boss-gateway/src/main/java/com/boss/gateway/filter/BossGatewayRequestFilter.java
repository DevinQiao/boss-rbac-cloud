package com.boss.gateway.filter;

import com.alibaba.fastjson.JSON;
import com.boss.common.entity.BossResponse;
import com.boss.common.entity.constant.BossGatewayConstant;
import com.boss.common.entity.constant.BossMediaTypeConstant;
import com.boss.common.entity.constant.BossStatusCodeConstant;
import com.boss.gateway.properties.BossGatewayProperties;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.ArrayUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.cloud.gateway.filter.GatewayFilterChain;
import org.springframework.cloud.gateway.filter.GlobalFilter;
import org.springframework.cloud.gateway.route.Route;
import org.springframework.core.io.buffer.DataBuffer;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.server.reactive.ServerHttpRequest;
import org.springframework.http.server.reactive.ServerHttpResponse;
import org.springframework.stereotype.Component;
import org.springframework.util.AntPathMatcher;
import org.springframework.util.Base64Utils;
import org.springframework.web.server.ServerWebExchange;
import reactor.core.publisher.Mono;

import javax.annotation.Resource;
import java.net.URI;
import java.time.LocalDateTime;
import java.util.LinkedHashSet;

import static org.springframework.cloud.gateway.support.ServerWebExchangeUtils.*;

/**
 * @author DevinJoe
 * @since 2022/7/12
 */
@Slf4j
@Component
public class BossGatewayRequestFilter implements GlobalFilter {

    @Resource
    private BossGatewayProperties properties;

    private AntPathMatcher pathMatcher = new AntPathMatcher();

    @Override
    public Mono<Void> filter(ServerWebExchange exchange, GatewayFilterChain chain) {
        ServerHttpRequest request = exchange.getRequest();
        ServerHttpResponse response = exchange.getResponse();

        Mono<Void> checkForbidUri = checkForbidUri(request, response);
        if (checkForbidUri != null) {
            return checkForbidUri;
        }

        printLog(exchange);

        byte[] token = Base64Utils.encode(BossGatewayConstant.GATEWAY_TOKEN_VALUE.getBytes());
        ServerHttpRequest build =
                request.mutate().header(BossGatewayConstant.GATEWAY_TOKEN_HEADER, new String(token)).build();
        ServerWebExchange newExchange = exchange.mutate().request(build).build();
        return chain.filter(newExchange);
    }

    private Mono<Void> checkForbidUri(ServerHttpRequest request, ServerHttpResponse response) {
        String uri = request.getPath().toString();
        boolean shouldForward = true;
        String forbidRequestUri = properties.getForbidRequestUri();
        String[] forbidRequestUris = StringUtils.splitByWholeSeparatorPreserveAllTokens(forbidRequestUri, ",");
        if (forbidRequestUris != null && ArrayUtils.isNotEmpty(forbidRequestUris)) {
            for (String u : forbidRequestUris) {
                if (pathMatcher.match(u, uri)) {
                    shouldForward = false;
                }
            }
        }
        if (!shouldForward) {
            BossResponse bossResponse =
                    new BossResponse().statusCode(BossStatusCodeConstant.NO_AUTH).message("该URI不允许外部访问");
            return makeResponse(response, bossResponse);
        }
        return null;
    }

    private Mono<Void> makeResponse(ServerHttpResponse response, BossResponse bossResponse) {
        response.setStatusCode(HttpStatus.FORBIDDEN);
        response.getHeaders().add(HttpHeaders.CONTENT_TYPE, BossMediaTypeConstant.APPLICATION_JSON_UTF8_VALUE);
        DataBuffer dataBuffer = response.bufferFactory().wrap(JSON.toJSONString(bossResponse).getBytes());
        return response.writeWith(Mono.just(dataBuffer));
    }

    private void printLog(ServerWebExchange exchange) {
        URI url = exchange.getAttribute(GATEWAY_REQUEST_URL_ATTR);
        Route route = exchange.getAttribute(GATEWAY_ROUTE_ATTR);
        LinkedHashSet<URI> uris = exchange.getAttribute(GATEWAY_ORIGINAL_REQUEST_URL_ATTR);
        URI originUri = null;
        if (uris != null) {
            originUri = uris.stream().findFirst().orElse(null);
        }
        if (url != null && route != null && originUri != null) {
            log.info("转发请求:{}//{}{} --> 目标服务:{}, 目标地址:{}//{}{}, 转发时间:{}",
                    originUri.getScheme(), originUri.getAuthority(), originUri.getPath(), route.getId(),
                    url.getScheme(), url.getAuthority(), url.getPath(), LocalDateTime.now());
        }
    }
}
