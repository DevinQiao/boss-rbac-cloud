package com.boss.auth.service.impl;

import cn.hutool.core.convert.Convert;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.boss.auth.dao.UserDao;
import com.boss.auth.service.UserService;
import com.boss.common.entity.dto.UserDTO;
import com.boss.common.entity.po.UserPO;
import org.springframework.stereotype.Service;

/**
 * @author DevinJoe
 * @since 2022/7/9
 */
@Service
public class UserServiceImpl extends ServiceImpl<UserDao, UserPO> implements UserService {

    @Override
    public UserDTO findUserByUserName(String username) {
        QueryWrapper<UserPO> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("username", username);
        UserPO userPo = baseMapper.selectOne(queryWrapper);
        return Convert.convert(UserDTO.class, userPo);
    }
}
