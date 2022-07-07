package com.boss.gateway;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;
import org.springframework.cloud.netflix.zuul.EnableZuulProxy;

/**
 * @author bin16
 */
@EnableDiscoveryClient
@EnableZuulProxy
@SpringBootApplication
public class BossGatewayApplication {

    public static void main(String[] args) {
        SpringApplication.run(BossGatewayApplication.class, args);
    }

}
