package com.boss.server.test.service.impl;

import cn.hutool.core.convert.Convert;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.boss.common.entity.dto.UserDTO;
import com.boss.common.entity.po.UserPO;
import com.boss.server.test.dao.UserDao;
import com.boss.server.test.service.IUserService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

/**
 * <p>
 * 服务实现类
 * </p>
 *
 * @author DevinJoe
 * @since 2022-06-12
 */
@Slf4j
@Service
public class UserServiceImpl extends ServiceImpl<UserDao, UserPO> implements IUserService {

    @Override
    public UserDTO findUserByUserName(String username) {
        QueryWrapper<UserPO> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("username", username);
        UserPO userPo = baseMapper.selectOne(queryWrapper);
        return Convert.convert(UserDTO.class, userPo);
    }

}
