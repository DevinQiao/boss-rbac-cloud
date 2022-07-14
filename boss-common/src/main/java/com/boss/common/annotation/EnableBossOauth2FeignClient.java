package com.boss.common.annotation;

import com.boss.common.config.BossOAuth2FeignConfigure;
import org.springframework.context.annotation.Import;

import java.lang.annotation.*;

/**
 * @author DevinJoe
 * @since 2022/7/9
 */
@Target({ElementType.TYPE})
@Retention(RetentionPolicy.RUNTIME)
@Documented
@Import(BossOAuth2FeignConfigure.class)
public @interface EnableBossOauth2FeignClient {

}
