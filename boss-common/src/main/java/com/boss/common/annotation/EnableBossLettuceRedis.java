package com.boss.common.annotation;

import com.boss.common.config.BossLettuceRedisConfigure;
import org.springframework.context.annotation.Import;

import java.lang.annotation.*;

/**
 * @author DevinJoe
 * @since 2022/7/9
 */
@Target({ElementType.TYPE})
@Retention(RetentionPolicy.RUNTIME)
@Documented
@Import(BossLettuceRedisConfigure.class)
public @interface EnableBossLettuceRedis {
}
