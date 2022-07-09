package com.boss.common.interceptor;

import com.boss.common.entity.BossZuulConstant;
import com.boss.common.entity.BossMediaTypeConstant;
import com.boss.common.entity.BossResponse;
import com.boss.common.utils.BossUtil;
import org.apache.commons.lang3.StringUtils;
import org.springframework.util.Base64Utils;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * @author DevinJoe
 * @since 2022/7/9
 */
public class BossServerProtectInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        String token = request.getHeader(BossZuulConstant.ZUUL_TOKEN_HEADER);
        String zuulToken = new String(Base64Utils.encode(BossZuulConstant.ZUUL_TOKEN_VALUE.getBytes()));
        if (StringUtils.equals(zuulToken, token)) {
            return true;
        } else {
            BossResponse bossResponse = new BossResponse();
            BossUtil.makeResponse(response, BossMediaTypeConstant.APPLICATION_JSON_UTF8_VALUE,
                    HttpServletResponse.SC_FORBIDDEN, bossResponse.message("请通过网关获取资源"));
            return false;
        }
    }
}
