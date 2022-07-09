package com.boss.server.system.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.IService;
import com.boss.common.entity.dto.RoleDTO;
import com.boss.common.entity.po.RolePO;

import java.util.List;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author DevinJoe
 * @since 2022-06-12
 */
public interface IRoleService extends IService<RolePO> {

    /**
     * 通过用户ID获得用户的角色信息
     * @param userId
     * @return
     */
    List<RoleDTO> findRolesByUserId(Long userId);

    /**
     * 分页查询角色信息
     * @param rolePage
     * @param roleDTO
     * @return
     */
    Object findRoleListByPage(IPage<RolePO> rolePage, RoleDTO roleDTO);

    /**
     * 通过角色名称查询角色信息
     * @param roleName
     * @return
     */
    RoleDTO findRoleByRoleName(String roleName);

    /**
     * 通过角色编码查询角色信息
     * @param roleCode
     * @return
     */
    RoleDTO findRoleByRoleCode(String roleCode);

    /**
     * 传入DTO对象，封装通用的save方法
     * @param roleDTO
     * @return
     */
    boolean save(RoleDTO roleDTO);

    /**
     * 传入DTO对象，封装通用的updateById方法
     * @param roleDTO
     * @return
     */
    boolean updateById(RoleDTO roleDTO);

    /**
     * 封装通用的removeById方法，删除前先判断角色是否被分配给用户
     * @param id
     * @return
     */
    boolean removeRole(Long id);

    /**
     * 为角色分配权限
     * @param roleDTO
     * @return
     */
    boolean assignRolePermission(RoleDTO roleDTO);
}
