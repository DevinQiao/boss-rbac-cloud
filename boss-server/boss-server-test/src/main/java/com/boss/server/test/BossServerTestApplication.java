package com.boss.server.test;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.oauth2.config.annotation.web.configuration.EnableResourceServer;

/**
 * @author bin16
 */
@EnableResourceServer
@SpringBootApplication
@EnableGlobalMethodSecurity(prePostEnabled = true)
public class BossServerTestApplication {

    public static void main(String[] args) {
        SpringApplication.run(BossServerTestApplication.class, args);
    }

}
