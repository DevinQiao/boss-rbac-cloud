package com.boss.auth.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.boss.common.entity.dto.UserDTO;
import com.boss.common.entity.po.UserPO;

/**
 * @author DevinJoe
 * @since 2022/7/9
 */
public interface UserService extends IService<UserPO> {

    /**
     * 通过用户名获得用户信息
     * @param username 用户名
     * @return UserDTO
     */
    UserDTO findUserByUserName(String username);
}
