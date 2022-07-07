package com.boss.common.entity;

import lombok.Data;

import java.io.Serializable;

/**
 * @author DevinJoe
 * @since 2022/7/7
 */
@Data
public class BossAuthUser implements Serializable {

    private static final long serialVersionUID = -295648635590234333L;

    private String username;

    private String password;

    private boolean accountNonExpired = true;

    private boolean accountNonLocked = true;

    private boolean credentialNonExpired = true;

    private boolean enabled = true;
}
