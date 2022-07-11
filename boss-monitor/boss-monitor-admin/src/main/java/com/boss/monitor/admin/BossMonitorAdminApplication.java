package com.boss.monitor.admin;

import de.codecentric.boot.admin.server.config.EnableAdminServer;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

/**
 * @author bin16
 */
@EnableAdminServer
@SpringBootApplication
public class BossMonitorAdminApplication {

    public static void main(String[] args) {
        SpringApplication.run(BossMonitorAdminApplication.class, args);
    }

}
