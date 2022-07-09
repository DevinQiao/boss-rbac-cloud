package com.boss.server.system.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.boss.common.entity.po.RolePO;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

/**
 * <p>
 *  Mapper 接口
 * </p>
 *
 * @author DevinJoe
 * @since 2022-06-12
 */
public interface RoleDao extends BaseMapper<RolePO> {

    /**
     * 通过用户ID获得用户的角色信息
     * @param userId
     * @return
     */
    List<RolePO> findRolesByUserId(Long userId);

    /**
     * 通过角色ID查询用户角色关系表中该角色是否被分配给用户
     * @param roleId
     * @return
     */
    @Select("select count(1) from t_user_role where role_id = #{roleId}")
    int selectUserOfRoleCount(Long roleId);

    /**
     * 删除角色权限关系
     * @param roleId
     */
    @Delete("delete from t_role_permission where role_id = #{roleId}")
    void deleteRolePermission(Long roleId);

    /**
     * 为角色分配权限
     * @param roleId
     * @param permissionIds
     * @return
     */
    int assignRolePermission(@Param("roleId") Long roleId, @Param("permissionIds") List<Long> permissionIds);
}
