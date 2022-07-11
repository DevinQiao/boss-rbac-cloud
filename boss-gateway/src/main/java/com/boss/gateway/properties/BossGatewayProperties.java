package com.boss.gateway.properties;

import lombok.Data;
import org.springframework.boot.SpringBootConfiguration;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.PropertySource;

/**
 * @author DevinJoe
 * @since 2022/7/11
 */
@Data
@SpringBootConfiguration
@PropertySource(value = {"classpath:boss-gateway.properties"})
@ConfigurationProperties(prefix = "boss.gateway")
public class BossGatewayProperties {

    private String forbidRequestUri;
}
