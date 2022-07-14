package com.boss.auth;

import com.boss.common.annotation.BossCloudApplication;
import com.boss.common.annotation.EnableBossLettuceRedis;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

/**
 * @author bin16
 */
@SpringBootApplication
@BossCloudApplication
@EnableBossLettuceRedis
@MapperScan("com.boss.auth.dao")
public class BossAuthApplication {

    public static void main(String[] args) {
        System.setProperty("nacos.logging.default.config.enabled","false");

        SpringApplication.run(BossAuthApplication.class, args);
    }

}
