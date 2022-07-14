package com.boss.server.system.controller;

import cn.hutool.core.convert.Convert;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.boss.common.entity.BossResponse;
import com.boss.common.entity.constant.BossStatusCodeConstant;
import com.boss.common.entity.dto.UserDTO;
import com.boss.common.entity.dto.UserRoleDTO;
import com.boss.common.entity.po.UserPO;
import com.boss.common.entity.vo.UserRoleVO;
import com.boss.common.entity.vo.UserVO;
import com.boss.server.system.annotation.BossLog;
import com.boss.server.system.service.IUserService;
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
@RequestMapping("user")
public class UserController {

    @Resource
    private IUserService userService;

    /**
     * 分页查询用户信息
     *
     * @param userVO 用户VO对象
     * @return 自定义泛型
     */
    @GetMapping("/list")
    @BossLog(action = " 分页查询用户信息 ")
    public BossResponse findUserListByPage(UserVO userVO) {
        IPage<UserPO> userPage = new Page<>(userVO.getPageNo(), userVO.getPageSize());
        UserDTO userDTO = Convert.convert(UserDTO.class, userVO);
        return new BossResponse().statusCode(BossStatusCodeConstant.SUCCESS)
                .data(userService.findUserListByPage(userPage, userDTO))
                .message("分页查询用户信息成功");
    }

    /**
     * 添加用户
     *
     * @param userVO 用户VO对象
     * @return 自定义泛型
     */
    @PostMapping("/add")
    @BossLog(action = " 添加用户信息 ")
    public BossResponse add(@RequestBody @Valid UserVO userVO) {
        UserDTO userDTO = Convert.convert(UserDTO.class, userVO);
        if (!ObjectUtils.isEmpty(userService.findUserByUserName(userDTO.getUsername()))) {
            return new BossResponse().statusCode(BossStatusCodeConstant.ERROR).message("用户名重复");
        }
        if (userService.save(userDTO)) {
            return new BossResponse().statusCode(BossStatusCodeConstant.SUCCESS).message("用户添加成功");
        }
        return new BossResponse().statusCode(BossStatusCodeConstant.ERROR).message("用户添加失败");
    }

    /**
     * 修改用户
     *
     * @param userVO 用户VO对象
     * @return 自定义泛型
     */
    @PutMapping("/update")
    @BossLog(action = " 修改用户信息 ")
    public BossResponse update(@RequestBody @Valid UserVO userVO) {
        UserDTO userDTO = Convert.convert(UserDTO.class, userVO);
        if (!ObjectUtils.isEmpty(userService.findUserByUserName(userDTO.getUsername()))) {
            return new BossResponse().statusCode(BossStatusCodeConstant.ERROR).message("用户名重复");
        }
        if (userService.updateById(userDTO)) {
            return new BossResponse().statusCode(BossStatusCodeConstant.SUCCESS).message("用户修改成功");
        }
        return new BossResponse().statusCode(BossStatusCodeConstant.ERROR).message("用户修改失败");
    }

    /**
     * 删除用户
     *
     * @param id 用户ID
     * @return 自定义泛型
     */
    @DeleteMapping("/delete/{id}")
    @BossLog(action = " 删除用户信息 ")
    public BossResponse delete(@PathVariable Long id) {
        if (userService.removeById(id)) {
            return new BossResponse().statusCode(BossStatusCodeConstant.SUCCESS).message("用户删除成功");
        }
        return new BossResponse().statusCode(BossStatusCodeConstant.ERROR).message("用户删除失败");
    }

    /**
     * 为用户分配角色
     *
     * @param userRoleVO 用户角色关系VO对象
     * @return 自定义泛型
     */
    @PostMapping("/assign/role")
    @BossLog(action = " 为用户分配角色 ")
    public BossResponse assignRole(@RequestBody UserRoleVO userRoleVO) {
        UserRoleDTO userRoleDTO = Convert.convert(UserRoleDTO.class, userRoleVO);
        if (userService.assignUserRole(userRoleDTO)) {
            return new BossResponse().statusCode(BossStatusCodeConstant.SUCCESS).message("用户角色分配成功");
        }
        return new BossResponse().statusCode(BossStatusCodeConstant.ERROR).message("用户角色分配失败");
    }

}

