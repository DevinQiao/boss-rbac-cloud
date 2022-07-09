package com.boss.auth;

import com.boss.common.annotation.BossCloudApplication;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;

/**
 * @author bin16
 */
@EnableDiscoveryClient
@SpringBootApplication
@BossCloudApplication
public class BossAuthApplication {

    public static void main(String[] args) {
        SpringApplication.run(BossAuthApplication.class, args);
    }

}
