package com.boss.auth.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.boss.common.entity.dto.PermissionDTO;
import com.boss.common.entity.po.PermissionPO;

import java.util.List;

/**
 * @author DevinJoe
 * @since 2022/7/9
 */
public interface PermissionService extends IService<PermissionPO> {

    /**
     * 通过角色ID集合获得权限集合
     * @param rolesId
     * @return
     */
    List<PermissionDTO> findPermissionListByRolesId(List<Long> rolesId);
}
