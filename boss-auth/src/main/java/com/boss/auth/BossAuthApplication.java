package com.boss.auth;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;

/**
 * @author bin16
 */
@EnableDiscoveryClient
@SpringBootApplication
public class BossAuthApplication {

    public static void main(String[] args) {
        SpringApplication.run(BossAuthApplication.class, args);
    }

}
