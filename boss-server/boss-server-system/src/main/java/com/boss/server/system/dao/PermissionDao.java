package com.boss.server.system.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.boss.common.entity.po.PermissionPO;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

/**
 * <p>
 * Mapper 接口
 * </p>
 *
 * @author DevinJoe
 * @since 2022-06-12
 */
public interface PermissionDao extends BaseMapper<PermissionPO> {

    /**
     * 通过角色ID集合获得权限集合
     *
     * @param rolesId
     * @return
     */
    List<PermissionPO> findPermissionListByRolesId(@Param("rolesId") List<Long> rolesId);

    /**
     * 查询权限是否有分配的角色
     *
     * @param id
     * @return
     */
    @Select("select count(1) from t_role_permission where permission_id = #{id}")
    int hasRole(Long id);

}
