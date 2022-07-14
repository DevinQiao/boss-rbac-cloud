package com.boss.auth.config;

import com.boss.auth.properties.BossAuthProperties;
import com.boss.common.handler.BossAccessDeniedHandler;
import com.boss.common.handler.BossAuthExceptionEntryPoint;
import org.apache.commons.lang3.StringUtils;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.oauth2.config.annotation.web.configuration.EnableResourceServer;
import org.springframework.security.oauth2.config.annotation.web.configuration.ResourceServerConfigurerAdapter;
import org.springframework.security.oauth2.config.annotation.web.configurers.ResourceServerSecurityConfigurer;

import javax.annotation.Resource;

/**
 * @author DevinJoe
 * @since 2022/7/7
 */
@Configuration
@EnableResourceServer
public class BossResourceServerConfigure extends ResourceServerConfigurerAdapter {

    @Resource
    private BossAuthExceptionEntryPoint exceptionEntryPoint;

    @Resource
    private BossAccessDeniedHandler accessDeniedHandler;

    @Resource
    private BossAuthProperties properties;

    @Override
    public void configure(HttpSecurity http) throws Exception {
        String[] anonUrls = StringUtils.splitByWholeSeparatorPreserveAllTokens(properties.getAnonUrl(), ",");
        http.csrf().disable()
                .requestMatchers()
                .antMatchers("/**")
                .and()
                .authorizeRequests()
                .antMatchers(anonUrls).permitAll()
                .antMatchers("/**").authenticated();
    }

    @Override
    public void configure(ResourceServerSecurityConfigurer resources) throws Exception {
        resources.authenticationEntryPoint(exceptionEntryPoint)
                .accessDeniedHandler(accessDeniedHandler);
    }

}
