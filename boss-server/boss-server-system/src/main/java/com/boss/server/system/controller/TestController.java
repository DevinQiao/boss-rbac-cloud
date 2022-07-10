package com.boss.server.system.controller;

import com.boss.server.system.feign.IHelloService;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.security.Principal;

/**
 * @author DevinJoe
 * @since 2022/7/7
 */
@RestController
public class TestController {

    @Resource
    private IHelloService helloService;

    @GetMapping("info")
    public String test() {
        return "Boss-Server-System";
    }

    @GetMapping("test2")
    @PreAuthorize("hasAnyAuthority('user:update')")
    public String test2() {
        return "拥有'user:update'权限";
    }

    @GetMapping("currentUser")
    public Principal currentUser(Principal principal) {
        return principal;
    }

    @GetMapping("hello")
    public String hello(String name) {
        return this.helloService.hello(name);
    }
}
