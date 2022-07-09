package com.boss.server.test;

import com.boss.common.annotation.BossCloudApplication;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.openfeign.EnableFeignClients;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.oauth2.config.annotation.web.configuration.EnableResourceServer;

/**
 * @author bin16
 */
@EnableFeignClients
@EnableResourceServer
@SpringBootApplication
@EnableGlobalMethodSecurity(prePostEnabled = true)
@BossCloudApplication
public class BossServerTestApplication {

    public static void main(String[] args) {
        SpringApplication.run(BossServerTestApplication.class, args);
    }

}
