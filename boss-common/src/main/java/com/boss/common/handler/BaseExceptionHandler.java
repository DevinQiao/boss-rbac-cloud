package com.boss.common.handler;

import com.boss.common.entity.BossResponse;
import com.boss.common.exception.BossAuthException;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.web.access.AccessDeniedHandler;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;

/**
 * @author DevinJoe
 * @since 2022/7/9
 */
@Slf4j
public class BaseExceptionHandler {

    @ExceptionHandler(value = Exception.class)
    @ResponseStatus(HttpStatus.INTERNAL_SERVER_ERROR)
    public BossResponse handleException(Exception e) {
        log.error("系统内部异常，异常信息", e);
        return new BossResponse().message("系统内部异常");
    }

    @ExceptionHandler(value = BossAuthException.class)
    @ResponseStatus(HttpStatus.INTERNAL_SERVER_ERROR)
    public BossResponse handleBossAuthException(BossAuthException e) {
        log.error("系统错误", e);
        return new BossResponse().message(e.getMessage());
    }

    @ExceptionHandler(value = AccessDeniedException.class)
    @ResponseStatus(HttpStatus.FORBIDDEN)
    public BossResponse handleAccessDeniedException() {
        return new BossResponse().message("没有权限访问该资源");
    }
}
