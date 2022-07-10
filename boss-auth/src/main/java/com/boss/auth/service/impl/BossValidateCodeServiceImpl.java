package com.boss.auth.service.impl;

import com.boss.auth.properties.BossAuthProperties;
import com.boss.auth.properties.BossValidateCodeProperties;
import com.boss.auth.service.ValidateCodeService;
import com.boss.common.entity.constant.BossValidateCodeConstant;
import com.boss.common.exception.BossValidateCodeException;
import com.boss.common.service.RedisService;
import com.wf.captcha.GifCaptcha;
import com.wf.captcha.SpecCaptcha;
import com.wf.captcha.base.Captcha;
import org.apache.commons.lang3.ObjectUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * @author DevinJoe
 * @since 2022/7/9
 */
@Service
public class BossValidateCodeServiceImpl implements ValidateCodeService {

    @Resource
    private RedisService redisService;

    @Resource
    private BossAuthProperties properties;

    @Override
    public void create(HttpServletRequest request, HttpServletResponse response) throws IOException, BossValidateCodeException {
        String key = request.getParameter("key");
        if (StringUtils.isBlank(key)) {
            throw new BossValidateCodeException("验证码key不能为空");
        }
        BossValidateCodeProperties code = properties.getCode();
        setHeader(response, code.getType());

        Captcha captcha = createCaptcha(code);
        redisService.set(BossValidateCodeConstant.CODE_PREFIX + key, StringUtils.lowerCase(captcha.text()),code.getTime());
        captcha.out(response.getOutputStream());
    }

    @Override
    public void check(String key, String value) throws BossValidateCodeException {
        Object codeInRedis = redisService.get(BossValidateCodeConstant.CODE_PREFIX + key);
        if (StringUtils.isBlank(value)) {
            throw new BossValidateCodeException("请输入验证码");
        }
        if (ObjectUtils.isEmpty(codeInRedis)) {
            throw new BossValidateCodeException("验证码已过期");
        }
        if (!StringUtils.equalsIgnoreCase(value, String.valueOf(codeInRedis))) {
            throw new BossValidateCodeException("验证码不正确");
        }
    }

    private Captcha createCaptcha(BossValidateCodeProperties code) {
        Captcha captcha = null;
        if (StringUtils.equalsIgnoreCase(code.getType(), BossValidateCodeConstant.GIF)) {
            captcha = new GifCaptcha(code.getWidth(), code.getHeight(), code.getLength());
        } else {
            captcha = new SpecCaptcha(code.getWidth(), code.getHeight(), code.getLength());
        }
        captcha.setCharType(code.getCharType());
        return captcha;
    }

    private void setHeader(HttpServletResponse response, String type) {
        if (StringUtils.equalsIgnoreCase(type, BossValidateCodeConstant.GIF)) {
            response.setContentType(MediaType.IMAGE_GIF_VALUE);
        } else {
            response.setContentType(MediaType.IMAGE_PNG_VALUE);
        }
        response.setHeader(HttpHeaders.PRAGMA, "No-cache");
        response.setHeader(HttpHeaders.CACHE_CONTROL, "no-cache");
        response.setDateHeader(HttpHeaders.EXPIRES, 0L);
    }
}
