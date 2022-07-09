package com.boss.server.system.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.IService;
import com.boss.common.entity.dto.UserDTO;
import com.boss.common.entity.dto.UserRoleDTO;
import com.boss.common.entity.po.UserPO;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author DevinJoe
 * @since 2022-06-12
 */
public interface IUserService extends IService<UserPO> {

    /**
     * 通过用户名获得用户信息
     * @param username 用户名
     * @return UserDTO
     */
    UserDTO findUserByUserName(String username);

    /**
     * 分页查询用户信息
     * @param userPage 分页泛型
     * @param userDto 用户DTO对象
     * @return Object
     */
    Object findUserListByPage(IPage<UserPO> userPage, UserDTO userDto);

    /**
     * 传入DTO对象，封装通用的save方法
     * @param userDTO 用户DTO对象
     * @return boolean
     */
    boolean save(UserDTO userDTO);

    /**
     * 传入DTO对象，封装通用的updateById方法
     * @param userDTO 用户DTO对象
     * @return boolean
     */
    boolean updateById(UserDTO userDTO);

    /**
     * 为用户分配角色
     * @param userRoleDTO 用户角色关系DTO对象
     * @return boolean
     */
    boolean assignUserRole(UserRoleDTO userRoleDTO);
}
