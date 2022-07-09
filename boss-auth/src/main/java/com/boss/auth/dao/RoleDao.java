package com.boss.auth.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.boss.common.entity.po.RolePO;

import java.util.List;

/**
 * @author DevinJoe
 * @since 2022/7/9
 */
public interface RoleDao extends BaseMapper<RolePO> {

    /**
     * 通过用户ID获得用户的角色信息
     * @param userId
     * @return
     */
    List<RolePO> findRolesByUserId(Long userId);
}
