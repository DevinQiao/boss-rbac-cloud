package com.boss.auth.properties;

import lombok.Data;
import org.springframework.boot.SpringBootConfiguration;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.PropertySource;

/**
 * @author DevinJoe
 * @since 2022/7/7
 */
@Data
@SpringBootConfiguration
@PropertySource(value = {"classpath:boss-auth.properties"})
@ConfigurationProperties(prefix = "boss.auth")
public class BossAuthProperties {

    private BossClientsProperties[] clients = {};

    private int accessTokenValiditySeconds = 60 * 60 * 24;

    private int refreshTokenValiditySeconds = 60 * 60 * 24 * 7;

    private String anonUrl;

    private BossValidateCodeProperties code = new BossValidateCodeProperties();

}
