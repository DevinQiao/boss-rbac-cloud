package com.boss.server.system.properties;

import lombok.Data;
import org.springframework.boot.SpringBootConfiguration;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.PropertySource;

/**
 * @author DevinJoe
 * @since 2022/7/10
 */
@Data
@SpringBootConfiguration
@PropertySource(value = "classpath:boss-server-system.properties")
@ConfigurationProperties(prefix = "boss.server.system")
public class BossServerSystemProperties {

    private String anonUrl;

    private BossSwaggerProperties swagger = new BossSwaggerProperties();
}
