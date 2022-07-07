package com.boss.register;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.netflix.eureka.server.EnableEurekaServer;

/**
 * @author bin16
 */
@EnableEurekaServer
@SpringBootApplication
public class BossRegisterApplication {

    public static void main(String[] args) {
        SpringApplication.run(BossRegisterApplication.class, args);
    }

}
