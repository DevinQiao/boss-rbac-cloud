package com.boss.common.handler;

import com.boss.common.entity.constant.BossMediaTypeConstant;
import com.boss.common.entity.BossResponse;
import com.boss.common.utils.BossUtil;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.AuthenticationEntryPoint;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * @author DevinJoe
 * @since 2022/7/8
 */
public class BossAuthExceptionEntryPoint implements AuthenticationEntryPoint {

    @Override
    public void commence(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, AuthenticationException e) throws IOException, ServletException {
        BossResponse response = new BossResponse();
        BossUtil.makeResponse(httpServletResponse, BossMediaTypeConstant.APPLICATION_JSON_UTF8_VALUE,
                HttpServletResponse.SC_UNAUTHORIZED, response.message("token无效"));
    }
}
