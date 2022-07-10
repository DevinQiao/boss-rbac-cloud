package com.boss.common.exception;

/**
 * @author DevinJoe
 * @since 2022/7/10
 */
public class BossException extends Exception {

    private static final long serialVersionUID = -4495324278122953640L;

    public BossException(String message) {
        super(message);
    }
}
