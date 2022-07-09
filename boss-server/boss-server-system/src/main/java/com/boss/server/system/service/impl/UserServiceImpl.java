package com.boss.server.system.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.boss.common.converter.UserConverter;
import com.boss.common.entity.dto.UserDTO;
import com.boss.common.entity.dto.UserRoleDTO;
import com.boss.common.entity.po.UserPO;
import com.boss.server.system.dao.UserDao;
import com.boss.server.system.service.IUserService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author DevinJoe
 * @since 2022-06-12
 */
@Slf4j
@Service
public class UserServiceImpl extends ServiceImpl<UserDao, UserPO> implements IUserService {

    @Resource
    private UserConverter userConverter;

    @Override
    public UserDTO findUserByUserName(String username) {
        QueryWrapper<UserPO> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("username", username);
        UserPO userPo = baseMapper.selectOne(queryWrapper);
        return userConverter.poToDto(userPo);
    }

    @Override
    public Object findUserListByPage(IPage<UserPO> userPage, UserDTO userDto) {
        QueryWrapper<UserPO> queryWrapper = new QueryWrapper<>();
        return baseMapper.selectPage(userPage,queryWrapper);
    }

    @Override
    public boolean save(UserDTO userDTO) {
        UserPO userPo = userConverter.dtoToPo(userDTO);
        return this.save(userPo);
    }

    @Override
    public boolean updateById(UserDTO userDTO) {
        UserPO userPo = userConverter.dtoToPo(userDTO);
        return this.updateById(userPo);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean assignUserRole(UserRoleDTO userRoleDTO) {
        baseMapper.deleteUserRole(userRoleDTO.getUserId());
        try {
            return baseMapper.assignUserRole(userRoleDTO.getUserId(), userRoleDTO.getRoleIds()) > 0;
        } catch (DataAccessException e) {
            log.error("SQL外键约束错误");
        }
        return false;
    }
}
