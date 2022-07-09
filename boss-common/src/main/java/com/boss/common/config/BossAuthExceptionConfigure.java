package com.boss.common.config;

import com.boss.common.handler.BossAccessDeniedHandler;
import com.boss.common.handler.BossAuthExceptionEntryPoint;
import org.springframework.boot.autoconfigure.condition.ConditionalOnMissingBean;
import org.springframework.context.annotation.Bean;

/**
 * @author DevinJoe
 * @since 2022/7/8
 */
public class BossAuthExceptionConfigure {

    @Bean
    @ConditionalOnMissingBean(name = "accessDeniedHandler")
    public BossAccessDeniedHandler accessDeniedHandler() {
        return new BossAccessDeniedHandler();
    }

    @Bean
    @ConditionalOnMissingBean(name = "authExceptionEntryPoint")
    public BossAuthExceptionEntryPoint authExceptionEntryPoint() {
        return new BossAuthExceptionEntryPoint();
    }
}
