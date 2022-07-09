package com.boss.common.entity.vo;

import com.boss.common.entity.dto.UserRoleDTO;
import lombok.Data;

/**
 * @author DevinJoe
 * @since 2022/6/21
 */
@Data
public class UserRoleVO extends UserRoleDTO {

    /**
     * 用户名称
     */
    private String username;
}
