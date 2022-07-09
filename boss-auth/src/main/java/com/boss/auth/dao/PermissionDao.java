package com.boss.auth.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.boss.common.entity.po.PermissionPO;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @author DevinJoe
 * @since 2022/7/9
 */
public interface PermissionDao extends BaseMapper<PermissionPO> {

    /**
     * 通过角色ID集合获得权限集合
     * @param rolesId
     * @return
     */
    List<PermissionPO> findPermissionListByRolesId(@Param("rolesId") List<Long> rolesId);
}
