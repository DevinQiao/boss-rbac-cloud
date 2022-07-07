package com.boss.server.system.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.security.Principal;

/**
 * @author DevinJoe
 * @since 2022/7/7
 */
@RestController
public class TestController {

    @GetMapping("info")
    public String test() {
        return "Boss-Server-System";
    }

    @GetMapping("user")
    public Principal currentUser(Principal principal) {
        return principal;
    }
}
