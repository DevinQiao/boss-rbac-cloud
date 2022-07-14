package com.boss.server.test.controller;

import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * @author DevinJoe
 * @since 2022/7/7
 */
@Slf4j
@RestController
public class TestController {

    @GetMapping("hello")
    public String hello(String name) {
        log.info("/hello服务被调用");
        return "Hello " + name + "!";
    }
}
