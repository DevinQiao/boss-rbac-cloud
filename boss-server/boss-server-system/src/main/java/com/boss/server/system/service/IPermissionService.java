package com.boss.server.system.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.IService;
import com.boss.common.entity.dto.PermissionDTO;
import com.boss.common.entity.dto.RolePermissionDTO;
import com.boss.common.entity.po.PermissionPO;

import java.util.List;

/**
 * <p>
 * 服务类
 * </p>
 *
 * @author DevinJoe
 * @since 2022-06-12
 */
public interface IPermissionService extends IService<PermissionPO> {

    /**
     * 通过角色ID集合获得权限集合
     *
     * @param rolesId
     * @return
     */
    List<PermissionDTO> findPermissionListByRolesId(List<Long> rolesId);

    /**
     * 生成角色对应的已选权限树
     *
     * @param roleId
     * @return
     */
    RolePermissionDTO makePermissionTree(Long roleId);

    /**
     * 分页查询权限信息
     *
     * @param permissionPage
     * @return
     */
    Object findPermissionByPage(IPage<PermissionPO> permissionPage);

    /**
     * 通过权限编码查询权限
     *
     * @param code
     * @return
     */
    PermissionDTO findPermissionByCode(String code);

    /**
     * 传入DTO对象，封装通用的save方法
     *
     * @param permissionDTO
     * @return
     */
    boolean save(PermissionDTO permissionDTO);

    /**
     * 传入DTO对象，封装框架提供的updateById方法
     *
     * @param permissionDTO
     * @return
     */
    boolean updateById(PermissionDTO permissionDTO);

    /**
     * 判断权限是否有子权限
     *
     * @param id
     * @return
     */
    boolean hasChildren(Long id);

    /**
     * 判断权限是否有被分配给角色
     *
     * @param id
     * @return
     */
    boolean hasRole(Long id);

    /**
     * 删除权限
     *
     * @param id
     * @return
     */
    boolean removePermission(Long id);

}
