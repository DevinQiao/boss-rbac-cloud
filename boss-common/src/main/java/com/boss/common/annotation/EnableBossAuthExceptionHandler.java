package com.boss.common.annotation;

import com.boss.common.config.BossAuthExceptionConfigure;
import org.springframework.context.annotation.Import;

import java.lang.annotation.*;

/**
 * @author DevinJoe
 * @since 2022/7/8
 */
@Target({ElementType.TYPE})
@Retention(RetentionPolicy.RUNTIME)
@Documented
@Import(BossAuthExceptionConfigure.class)
public @interface EnableBossAuthExceptionHandler {

}
