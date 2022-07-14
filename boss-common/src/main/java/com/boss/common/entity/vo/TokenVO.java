package com.boss.common.entity.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @author DevinJoe
 * @since 2022/6/12
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class TokenVO {

    /**
     * 过期时间
     */
    private Long expireTime;

    /**
     * token
     */
    private String token;

}
