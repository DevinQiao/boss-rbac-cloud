package com.boss.common.entity.vo;

import com.boss.common.entity.dto.PermissionDTO;
import lombok.Data;

import java.util.List;

/**
 * @author DevinJoe
 * @since 2022/6/22
 */
@Data
public class RolePermissionVO {

    /**
     * 角色ID
     */
    private Long roleId;

    /**
     * 权限列表
     */
    private List<PermissionDTO> permissionList;

    /**
     * 已有权限列表
     */
    private Object[] checkedList;
}
