package com.boss.auth.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.boss.common.entity.dto.RoleDTO;
import com.boss.common.entity.po.RolePO;

import java.util.List;

/**
 * @author DevinJoe
 * @since 2022/7/9
 */
public interface RoleService extends IService<RolePO> {

    /**
     * 通过用户ID获得用户的角色信息
     *
     * @param userId
     * @return
     */
    List<RoleDTO> findRolesByUserId(Long userId);

}
