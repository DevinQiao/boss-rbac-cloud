package com.boss.common.exception;

/**
 * @author DevinJoe
 * @since 2022/7/7
 */
public class BossAuthException extends Exception {

    private static final long serialVersionUID = 4044457500586653303L;

    public BossAuthException(String message) {
        super(message);
    }
}
