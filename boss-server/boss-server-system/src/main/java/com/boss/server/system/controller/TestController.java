package com.boss.server.system.controller;

import com.boss.server.system.feign.IHelloService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.security.Principal;

/**
 * @author DevinJoe
 * @since 2022/7/7
 */
@Slf4j
@RestController
public class TestController {

    @Resource
    private IHelloService helloService;

    @GetMapping("hello")
    public String hello(String name) {
        log.info("Feign调用boss-server-test的/hello服务");
        return this.helloService.hello(name);
    }

}
