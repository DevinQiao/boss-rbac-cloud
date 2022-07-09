package com.boss.auth.service.impl;

import cn.hutool.core.convert.Convert;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.boss.auth.dao.RoleDao;
import com.boss.auth.service.RoleService;
import com.boss.common.entity.dto.RoleDTO;
import com.boss.common.entity.po.RolePO;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

/**
 * @author DevinJoe
 * @since 2022/7/9
 */
@Service
public class RoleServiceImpl extends ServiceImpl<RoleDao, RolePO> implements RoleService {

    @Override
    public List<RoleDTO> findRolesByUserId(Long userId) {
        List<RolePO> rolesByUserId = baseMapper.findRolesByUserId(userId);
        List<RoleDTO> roleDTOList = new ArrayList<>();
        rolesByUserId.forEach(rolePO -> roleDTOList.add(Convert.convert(RoleDTO.class, rolePO)));
        return roleDTOList;
    }
}
