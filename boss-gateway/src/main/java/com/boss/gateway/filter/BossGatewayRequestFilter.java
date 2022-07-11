package com.boss.gateway.filter;

import com.boss.common.entity.BossResponse;
import com.boss.common.entity.constant.BossMediaTypeConstant;
import com.boss.common.entity.constant.BossStatusCodeConstant;
import com.boss.common.entity.constant.BossZuulConstant;
import com.boss.common.utils.BossUtil;
import com.boss.gateway.properties.BossGatewayProperties;
import com.netflix.zuul.ZuulFilter;
import com.netflix.zuul.context.RequestContext;
import com.netflix.zuul.exception.ZuulException;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.ArrayUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.cloud.netflix.zuul.filters.support.FilterConstants;
import org.springframework.stereotype.Component;
import org.springframework.util.AntPathMatcher;
import org.springframework.util.Base64Utils;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * @author DevinJoe
 * @since 2022/7/9
 */
@Slf4j
@Component
public class BossGatewayRequestFilter extends ZuulFilter {

    @Resource
    private BossGatewayProperties properties;

    private AntPathMatcher pathMatcher = new AntPathMatcher();

    @Override
    public String filterType() {
        return FilterConstants.PRE_TYPE;
    }

    @Override
    public int filterOrder() {
        return 6;
    }

    @Override
    public boolean shouldFilter() {
        return true;
    }

    @Override
    public Object run() throws ZuulException {
        RequestContext currentContext = RequestContext.getCurrentContext();
        String serviceId = (String) currentContext.get(FilterConstants.SERVICE_ID_KEY);
        HttpServletRequest request = currentContext.getRequest();
        String host = request.getRemoteHost();
        String method = request.getMethod();
        String uri = request.getRequestURI();

        log.info("请求URI: {}, HTTP Method: {}, 请求IP: {}, ServiceId: {]", uri, method, host, serviceId);

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
            HttpServletResponse response = currentContext.getResponse();
            BossResponse bossResponse =
                    new BossResponse().statusCode(BossStatusCodeConstant.NO_AUTH).message("该URI不允许外部访问");
            try {
                BossUtil.makeResponse(
                        response, BossMediaTypeConstant.APPLICATION_JSON_UTF8_VALUE,
                        HttpServletResponse.SC_FORBIDDEN, bossResponse
                );
                currentContext.setSendZuulResponse(false);
                currentContext.setResponse(response);
            } catch (IOException e) {
                log.error(e.getMessage());
            }
            return null;
        }

        byte[] token = Base64Utils.encode((BossZuulConstant.ZUUL_TOKEN_VALUE).getBytes());
        currentContext.addZuulRequestHeader(BossZuulConstant.ZUUL_TOKEN_HEADER, new String(token));
        return null;
    }
}
