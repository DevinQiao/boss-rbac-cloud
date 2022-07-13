package com.boss.server.system;

import com.boss.common.annotation.BossCloudApplication;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;
import org.springframework.cloud.openfeign.EnableFeignClients;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;

/**
 * @author bin16
 */
@EnableFeignClients
@SpringBootApplication
@EnableGlobalMethodSecurity(prePostEnabled = true)
@BossCloudApplication
@MapperScan("com.boss.server.system.dao")
public class BossServerSystemApplication {

    public static void main(String[] args) {
        System.setProperty("nacos.logging.default.config.enabled","false");

        SpringApplication.run(BossServerSystemApplication.class, args);
    }

}
