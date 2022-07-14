package com.boss.server.test.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.boss.common.entity.dto.UserDTO;
import com.boss.common.entity.po.UserPO;

/**
 * <p>
 * 服务类
 * </p>
 *
 * @author DevinJoe
 * @since 2022-06-12
 */
public interface IUserService extends IService<UserPO> {

    /**
     * 通过用户名获得用户信息
     *
     * @param username 用户名
     * @return UserDTO
     */
    UserDTO findUserByUserName(String username);

}
