package com.boss.auth.service.impl;

import cn.hutool.core.convert.Convert;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.boss.auth.dao.PermissionDao;
import com.boss.auth.service.PermissionService;
import com.boss.common.entity.dto.PermissionDTO;
import com.boss.common.entity.po.PermissionPO;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

/**
 * @author DevinJoe
 * @since 2022/7/9
 */
@Service
public class PermissionServiceImpl extends ServiceImpl<PermissionDao, PermissionPO> implements PermissionService {

    @Override
    public List<PermissionDTO> findPermissionListByRolesId(List<Long> rolesId) {
        List<PermissionPO> permissionPoListByRolesId = baseMapper.findPermissionListByRolesId(rolesId);
        List<PermissionDTO> permissionDTOList = new ArrayList<>();
        permissionPoListByRolesId.forEach(permissionPO ->
                permissionDTOList.add(Convert.convert(PermissionDTO.class, permissionPO)));
        return permissionDTOList;
    }
}
