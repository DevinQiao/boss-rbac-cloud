package com.boss.auth.controller;

import com.boss.common.entity.BossResponse;
import com.boss.common.exception.BossAuthException;
import org.apache.commons.lang3.StringUtils;
import org.springframework.security.oauth2.provider.token.ConsumerTokenServices;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.security.Principal;

/**
 * @author DevinJoe
 * @since 2022/7/7
 */
@RestController
public class SecurityController {

    @Resource
    private ConsumerTokenServices consumerTokenServices;

    @GetMapping("oauth/test")
    public String testOauth() {
        return "oauth";
    }

    @GetMapping("user")
    public Principal currentUser(Principal principal) {
        return principal;
    }

    @DeleteMapping("signout")
    public BossResponse logout(HttpServletRequest request) throws BossAuthException {
        String authorization = request.getHeader("Authorization");
        String token = StringUtils.replace(authorization, "bearer ", "");
        BossResponse bossResponse = new BossResponse();
        if (!consumerTokenServices.revokeToken(token)) {
            throw new BossAuthException("退出登录失败");
        }
        return bossResponse.message("退出登录成功");
    }
}
