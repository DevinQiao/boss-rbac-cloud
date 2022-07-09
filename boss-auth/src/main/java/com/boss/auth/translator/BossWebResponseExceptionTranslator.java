package com.boss.auth.translator;

import com.boss.common.entity.BossResponse;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang.StringUtils;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.oauth2.common.exceptions.InvalidGrantException;
import org.springframework.security.oauth2.common.exceptions.UnsupportedGrantTypeException;
import org.springframework.security.oauth2.provider.error.WebResponseExceptionTranslator;
import org.springframework.stereotype.Component;

/**
 * @author DevinJoe
 * @since 2022/7/8
 */
@Slf4j
@Component
public class BossWebResponseExceptionTranslator implements WebResponseExceptionTranslator {

    @Override
    public ResponseEntity<?> translate(Exception e) throws Exception {
        ResponseEntity.BodyBuilder status = ResponseEntity.status(HttpStatus.INSUFFICIENT_STORAGE);
        BossResponse response = new BossResponse();
        StringBuilder message = new StringBuilder("认证失败");
        log.error(message.toString(), e);
        if (e instanceof UnsupportedGrantTypeException) {
            message.setLength(0);
            message.append("不支持该认证类型");
            return status.body(response.message(message.toString()));
        }
        if (e instanceof InvalidGrantException) {
            if (StringUtils.containsIgnoreCase(e.getMessage(), "Invalid refresh token")) {
                message.setLength(0);
                message.append("refresh token无效");
                return status.body(response.message(message.toString()));
            }
            if (StringUtils.containsIgnoreCase(e.getMessage(), "locked")) {
                message.setLength(0);
                message.append("用户已被锁定，请联系管理员");
                return status.body(response.message(message.toString()));
            }
            message.setLength(0);
            message.append("用户名或密码错误");
            return status.body(response.message(message.toString()));
        }
        return status.body(response.message(message.toString()));
    }
}
