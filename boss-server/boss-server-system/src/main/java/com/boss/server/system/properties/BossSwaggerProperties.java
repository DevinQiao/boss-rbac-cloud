package com.boss.server.system.properties;

import lombok.Data;

/**
 * @author DevinJoe
 * @since 2022/7/10
 */
@Data
public class BossSwaggerProperties {

    private String basePackage;

    private String title;

    private String description;

    private String version;

    private String author;

    private String url;

    private String email;

    private String license;

    private String licenseUrl;

    private String grantUrl;

    private String name;

    private String scope;
}
