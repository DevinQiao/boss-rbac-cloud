package com.boss.common.entity.constant;

/**
 * @author DevinJoe
 * @since 2022/7/10
 */
public class BossStatusCodeConstant {

    private BossStatusCodeConstant() {

    }

    /**
     * 成功状态码
     */
    public static final Integer SUCCESS = 200;

    /**
     * 失败状态码
     */
    public static final Integer ERROR = 500;

    /**
     * 未登录状态码
     */
    public static final int NO_LOGIN = 600;

    /**
     * 没有权限状态码
     */
    public static final int NO_AUTH = 700;

}
