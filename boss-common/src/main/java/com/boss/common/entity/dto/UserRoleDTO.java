package com.boss.common.entity.dto;

import lombok.Data;

import java.util.List;

/**
 * @author DevinJoe
 * @since 2022/6/21
 */
@Data
public class UserRoleDTO {

    /**
     * 用户ID
     */
    private Long userId;

    /**
     * 角色ID
     */
    private List<Long> roleIds;
}
