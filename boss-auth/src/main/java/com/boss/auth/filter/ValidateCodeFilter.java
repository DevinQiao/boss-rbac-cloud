package com.boss.auth.filter;

import com.boss.auth.service.impl.BossValidateCodeServiceImpl;
import com.boss.common.entity.BossResponse;
import com.boss.common.entity.constant.BossMediaTypeConstant;
import com.boss.common.exception.BossValidateCodeException;
import com.boss.common.utils.BossUtil;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.http.HttpMethod;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;
import org.springframework.security.web.util.matcher.RequestMatcher;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import javax.annotation.Resource;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * @author DevinJoe
 * @since 2022/7/10
 */
@Slf4j
@Component
public class ValidateCodeFilter extends OncePerRequestFilter {

    @Resource
    private BossValidateCodeServiceImpl bossValidateCodeService;

    @Override
    protected void doFilterInternal(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, FilterChain filterChain) throws ServletException, IOException {
        RequestMatcher matcher = new AntPathRequestMatcher("/oauth/token", HttpMethod.POST.toString());
        if (matcher.matches(httpServletRequest)
                && StringUtils.equalsIgnoreCase(httpServletRequest.getParameter("grant_type"), "password")) {
            try {
                validateCode(httpServletRequest);
                filterChain.doFilter(httpServletRequest, httpServletResponse);
            } catch (BossValidateCodeException e) {
                BossResponse response = new BossResponse();
                BossUtil.makeResponse(httpServletResponse, BossMediaTypeConstant.APPLICATION_JSON_UTF8_VALUE,
                        HttpServletResponse.SC_INTERNAL_SERVER_ERROR, response.message(e.getMessage()));
                log.error(e.getMessage(), e);
            }
        } else {
            filterChain.doFilter(httpServletRequest, httpServletResponse);
        }
    }

    private void validateCode(HttpServletRequest request) throws BossValidateCodeException {
        String code = request.getParameter("code");
        String key = request.getParameter("key");
        bossValidateCodeService.check(key, code);
    }
}
