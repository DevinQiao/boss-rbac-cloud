package com.boss.common.entity;

/**
 * @author DevinJoe
 * @since 2022/7/9
 */
public class BossZuulConstant {

    private BossZuulConstant() {}

    /**
     * Zuul请求头token名称
     */
    public static final String ZUUL_TOKEN_HEADER = "ZuulToken";

    /**
     * Zuul请求头TOKEN值
     */
    public static final String ZUUL_TOKEN_VALUE = "boss:zuul:16250";
}
