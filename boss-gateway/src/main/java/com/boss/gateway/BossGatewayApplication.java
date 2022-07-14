package com.boss.gateway;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

/**
 * @author DevinJoe
 * @since 2022/7/12
 */
@SpringBootApplication
public class BossGatewayApplication {

    public static void main(String[] args) {
        System.setProperty("nacos.logging.default.config.enabled", "false");

        SpringApplication.run(BossGatewayApplication.class, args);
    }

}
