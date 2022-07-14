package com.boss.server.system.controller;

import cn.hutool.core.convert.Convert;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.boss.common.entity.BossResponse;
import com.boss.common.entity.constant.BossStatusCodeConstant;
import com.boss.common.entity.dto.RoleDTO;
import com.boss.common.entity.po.RolePO;
import com.boss.common.entity.vo.RolePermissionVO;
import com.boss.common.entity.vo.RoleVO;
import com.boss.server.system.annotation.BossLog;
import com.boss.server.system.service.IPermissionService;
import com.boss.server.system.service.IRoleService;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;

/**
 * <p>
 * 前端控制器
 * </p>
 *
 * @author DevinJoe
 * @since 2022-06-12
 */
@RestController
@RequestMapping("role")
public class RoleController {

    @Resource
    private IRoleService roleService;

    @Resource
    private IPermissionService permissionService;

    /**
     * 分页查询角色信息
     *
     * @param roleVO
     * @return
     */
    @GetMapping("/list")
    @BossLog(action = " 分页查询角色信息 ")
    public BossResponse findRoleListByPage(RoleVO roleVO) {
        IPage<RolePO> rolePage = new Page<>(roleVO.getPageNo(), roleVO.getPageSize());
        RoleDTO roleDTO = Convert.convert(RoleDTO.class, roleVO);
        return new BossResponse().statusCode(BossStatusCodeConstant.SUCCESS)
                .data(roleService.findRoleListByPage(rolePage, roleDTO))
                .message("分页查询角色信息成功");
    }

    /**
     * 添加角色
     *
     * @param roleVO
     * @return
     */
    @PostMapping("/add")
    @BossLog(action = " 添加角色信息 ")
    public BossResponse add(@RequestBody RoleVO roleVO) {
        RoleDTO roleDTO = Convert.convert(RoleDTO.class, roleVO);
        if (!ObjectUtils.isEmpty(roleService.findRoleByRoleName(roleDTO.getRoleName()))) {
            return new BossResponse().statusCode(BossStatusCodeConstant.ERROR).message("角色名称重复");
        }
        if (!ObjectUtils.isEmpty(roleService.findRoleByRoleCode(roleDTO.getRoleCode()))) {
            return new BossResponse().statusCode(BossStatusCodeConstant.ERROR).message("角色编码重复");
        }
        if (roleService.save(roleDTO)) {
            return new BossResponse().statusCode(BossStatusCodeConstant.SUCCESS).message("角色添加成功");
        } else {
            return new BossResponse().statusCode(BossStatusCodeConstant.ERROR).message("角色添加失败");
        }
    }

    /**
     * 修改角色
     *
     * @param roleVO
     * @return
     */
    @PutMapping("/update")
    @BossLog(action = " 修改角色信息 ")
    public BossResponse update(@RequestBody RoleVO roleVO) {
        RoleDTO roleDTO = Convert.convert(RoleDTO.class, roleVO);
        if (!ObjectUtils.isEmpty(roleService.findRoleByRoleName(roleDTO.getRoleName()))) {
            return new BossResponse().statusCode(BossStatusCodeConstant.ERROR).message("角色名称重复");
        }
        if (!ObjectUtils.isEmpty(roleService.findRoleByRoleCode(roleDTO.getRoleCode()))) {
            return new BossResponse().statusCode(BossStatusCodeConstant.ERROR).message("角色编码重复");
        }
        if (roleService.updateById(roleDTO)) {
            return new BossResponse().statusCode(BossStatusCodeConstant.SUCCESS).message("角色修改成功");
        } else {
            return new BossResponse().statusCode(BossStatusCodeConstant.ERROR).message("角色修改失败");
        }
    }

    /**
     * 删除角色
     *
     * @param id
     * @return
     */
    @DeleteMapping("/delete/{id}")
    @BossLog(action = " 删除角色信息 ")
    public BossResponse delete(@PathVariable Long id) {
        if (roleService.removeRole(id)) {
            return new BossResponse().statusCode(BossStatusCodeConstant.SUCCESS).message("角色删除成功");
        } else {
            return new BossResponse().statusCode(BossStatusCodeConstant.ERROR).message("角色删除失败");
        }
    }

    /**
     * 获取角色对应的权限树
     *
     * @param roleId
     * @return
     */
    @GetMapping("/assign/permission/tree/{roleId}")
    @BossLog(action = " 获取角色对应的权限树 ")
    public BossResponse getPermissionListOfRole(@PathVariable Long roleId) {
        RolePermissionVO rolePermissionVO = permissionService.makePermissionTree(roleId);
        return new BossResponse().statusCode(BossStatusCodeConstant.SUCCESS).data(rolePermissionVO);
    }

    /**
     * 为角色分配权限
     *
     * @param roleVO
     * @return
     */
    @PostMapping("/assign/permission/save")
    @BossLog(action = " 为角色分配权限 ")
    public BossResponse assignPermission(@RequestBody RoleVO roleVO) {
        RoleDTO roleDTO = Convert.convert(RoleDTO.class, roleVO);
        if (roleService.assignRolePermission(roleDTO)) {
            return new BossResponse().statusCode(BossStatusCodeConstant.SUCCESS).message("权限分配成功");
        } else {
            return new BossResponse().statusCode(BossStatusCodeConstant.ERROR)
                    .message("权限分配失败");
        }
    }

}

