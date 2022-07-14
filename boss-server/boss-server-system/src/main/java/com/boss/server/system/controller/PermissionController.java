package com.boss.server.system.controller;

import cn.hutool.core.convert.Convert;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.boss.common.entity.BossResponse;
import com.boss.common.entity.constant.BossStatusCodeConstant;
import com.boss.common.entity.dto.PermissionDTO;
import com.boss.common.entity.po.PermissionPO;
import com.boss.common.entity.vo.PermissionVO;
import com.boss.server.system.annotation.BossLog;
import com.boss.server.system.service.IPermissionService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.validation.Valid;

/**
 * <p>
 * 前端控制器
 * </p>
 *
 * @author DevinJoe
 * @since 2022-06-12
 */
@Slf4j
@RestController
@RequestMapping("permission")
public class PermissionController {

    @Resource
    private IPermissionService permissionService;

    /**
     * 分页查询权限信息
     *
     * @param permissionVO
     * @return
     */
    @GetMapping("/list")
    @BossLog(action = " 分页查询权限信息 ")
    public BossResponse findPermissionByPage(PermissionVO permissionVO) {
        IPage<PermissionPO> permissionPage = new Page<>(permissionVO.getPageNo(), permissionVO.getPageSize());
        return new BossResponse().statusCode(BossStatusCodeConstant.SUCCESS)
                .data(permissionService.findPermissionByPage(permissionPage))
                .message("查询权限列表成功");
    }

    /**
     * 添加权限
     *
     * @param permissionVO
     * @return
     */
    @PostMapping("/add")
    @BossLog(action = " 添加权限信息 ")
    public BossResponse add(@RequestBody @Valid PermissionVO permissionVO) {
        PermissionDTO permissionDTO = Convert.convert(PermissionDTO.class, permissionVO);
        if (!ObjectUtils.isEmpty(permissionService.findPermissionByCode(permissionDTO.getCode()))) {
            return new BossResponse().statusCode(BossStatusCodeConstant.ERROR)
                    .message("权限代码重复");
        }
        if (permissionService.save(permissionDTO)) {
            return new BossResponse().statusCode(BossStatusCodeConstant.SUCCESS)
                    .message("权限添加成功");
        } else {
            return new BossResponse().statusCode(BossStatusCodeConstant.ERROR)
                    .message("权限添加失败");
        }
    }

    /**
     * 修改权限
     *
     * @param permissionVO
     * @return
     */
    @PutMapping("/update")
    @BossLog(action = " 修改权限信息 ")
    public BossResponse update(@RequestBody @Valid PermissionVO permissionVO) {
        PermissionDTO permissionDTO = Convert.convert(PermissionDTO.class, permissionVO);
        if (!ObjectUtils.isEmpty(permissionService.findPermissionByCode(permissionDTO.getCode()))) {
            return new BossResponse().statusCode(BossStatusCodeConstant.ERROR)
                    .message("权限代码重复");
        }
        if (permissionService.updateById(permissionDTO)) {
            return new BossResponse().statusCode(BossStatusCodeConstant.SUCCESS)
                    .message("权限修改成功");
        } else {
            return new BossResponse().statusCode(BossStatusCodeConstant.ERROR)
                    .message("权限修改失败");
        }
    }

    /**
     * 查询权限是否有子权限或者被分配给角色
     *
     * @param id
     * @return
     */
    @GetMapping("/hasChildrenOrRole/{id}")
    @BossLog(action = " 查询权限是否有子权限或者被分配给角色 ")
    public BossResponse hasChildrenOrRole(@PathVariable Long id) {
        if (permissionService.hasChildren(id)) {
            return new BossResponse().statusCode(BossStatusCodeConstant.SUCCESS)
                    .message("该权限下有子权限，不可被删除");
        }
        if (permissionService.hasRole(id)) {
            return new BossResponse().statusCode(BossStatusCodeConstant.SUCCESS)
                    .message("有角色正在占有当前权限，不可删除");
        }
        return new BossResponse().statusCode(BossStatusCodeConstant.SUCCESS);
    }

    /**
     * 删除权限信息
     *
     * @param id
     * @return
     */
    @DeleteMapping("/delete/{id}")
    @BossLog(action = " 删除权限信息 ")
    public BossResponse delete(@PathVariable Long id) {
        if (permissionService.removePermission(id)) {
            return new BossResponse().statusCode(BossStatusCodeConstant.SUCCESS)
                    .message("权限删除成功");
        } else {
            return new BossResponse().statusCode(BossStatusCodeConstant.SUCCESS)
                    .message("权限删除失败");
        }
    }

}

