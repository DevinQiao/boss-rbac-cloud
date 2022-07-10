package com.boss.common.config;

import com.boss.common.entity.constant.BossZuulConstant;
import feign.RequestInterceptor;
import org.springframework.context.annotation.Bean;
import org.springframework.http.HttpHeaders;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.oauth2.provider.authentication.OAuth2AuthenticationDetails;
import org.springframework.util.Base64Utils;

/**
 * @author DevinJoe
 * @since 2022/7/9
 */
public class BossOAuth2FeignConfigure {

    @Bean
    public RequestInterceptor oauth2FeignRequestInterceptor() {
        return requestTemplate -> {
            String zuulToken = new String(Base64Utils.encode(BossZuulConstant.ZUUL_TOKEN_VALUE.getBytes()));
            requestTemplate.header(BossZuulConstant.ZUUL_TOKEN_HEADER, zuulToken);

            Object details = SecurityContextHolder.getContext().getAuthentication().getDetails();
            if (details instanceof OAuth2AuthenticationDetails) {
                String tokenValue = ((OAuth2AuthenticationDetails) details).getTokenValue();
                requestTemplate.header(HttpHeaders.AUTHORIZATION, "bearer" + tokenValue);
            }
        };
    }
}
