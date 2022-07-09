package com.boss.server.system;

import com.boss.common.annotation.BossCloudApplication;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;
import org.springframework.cloud.openfeign.EnableFeignClients;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;

/**
 * @author bin16
 */
@EnableFeignClients
@EnableDiscoveryClient
@SpringBootApplication
@EnableGlobalMethodSecurity(prePostEnabled = true)
@BossCloudApplication
public class BossServerSystemApplication {

    public static void main(String[] args) {
        SpringApplication.run(BossServerSystemApplication.class, args);
    }

}
