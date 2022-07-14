package com.boss.common.exception;

/**
 * @author DevinJoe
 * @since 2022/7/9
 */
public class BossValidateCodeException extends Exception {

    private static final long serialVersionUID = 8433053412032287117L;

    public BossValidateCodeException(String message) {
        super(message);
    }

}
