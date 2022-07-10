package com.boss.auth.service;

import com.boss.common.exception.BossValidateCodeException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * @author DevinJoe
 * @since 2022/7/9
 */
public interface ValidateCodeService {

    /**
     * 生成验证码
     * @param request
     * @param response
     * @throws IOException
     * @throws BossValidateCodeException
     */
    void create(HttpServletRequest request, HttpServletResponse response) throws IOException, BossValidateCodeException;

    /**
     * 校验验证码
     * @param key
     * @param value
     * @throws BossValidateCodeException
     */
    void check(String key, String value) throws BossValidateCodeException;
}
