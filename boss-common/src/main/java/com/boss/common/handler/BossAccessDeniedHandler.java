package com.boss.common.handler;

import com.boss.common.entity.BossResponse;
import com.boss.common.utils.BossUtil;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.web.access.AccessDeniedHandler;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * @author DevinJoe
 * @since 2022/7/8
 */
public class BossAccessDeniedHandler implements AccessDeniedHandler {

    @Override
    public void handle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, AccessDeniedException e) throws IOException, ServletException {
        BossResponse response = new BossResponse();
        BossUtil.makeResponse(httpServletResponse, "application/json;charset=UTF-8",
                HttpServletResponse.SC_FORBIDDEN, response.message("没有权限访问该资源"));
    }
}
