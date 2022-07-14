package com.boss.server.system.service.impl;

import cn.hutool.core.convert.Convert;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.boss.common.entity.dto.RoleDTO;
import com.boss.common.entity.po.RolePO;
import com.boss.common.entity.vo.RouterVO;
import com.boss.server.system.dao.RoleDao;
import com.boss.server.system.service.IRoleService;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.ObjectUtils;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;

/**
 * <p>
 * 服务实现类
 * </p>
 *
 * @author DevinJoe
 * @since 2022-06-12
 */
@Service
public class RoleServiceImpl extends ServiceImpl<RoleDao, RolePO> implements IRoleService {

    @Override
    public List<RoleDTO> findRolesByUserId(Long userId) {
        List<RolePO> rolesByUserId = baseMapper.findRolesByUserId(userId);
        List<RoleDTO> roleDTOList = new ArrayList<>();
        rolesByUserId.forEach(rolePo -> roleDTOList.add(Convert.convert(RoleDTO.class, rolePo)));
        return roleDTOList;
    }

    @Override
    public Object findRoleListByPage(IPage<RolePO> rolePage, RoleDTO roleDTO) {
        QueryWrapper<RolePO> queryWrapper = new QueryWrapper<>();
        return baseMapper.selectPage(rolePage, queryWrapper);
    }

    @Override
    public RoleDTO findRoleByRoleName(String roleName) {
        QueryWrapper<RolePO> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq(!ObjectUtils.isEmpty(roleName), "role_name", roleName);
        RolePO rolePo = baseMapper.selectOne(queryWrapper);
        return Convert.convert(RoleDTO.class, rolePo);
    }

    @Override
    public RoleDTO findRoleByRoleCode(String roleCode) {
        QueryWrapper<RolePO> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq(!ObjectUtils.isEmpty(roleCode), "role_code", roleCode);
        RolePO rolePo = baseMapper.selectOne(queryWrapper);
        return Convert.convert(RoleDTO.class, rolePo);
    }

    @Override
    public boolean save(RoleDTO roleDTO) {
        RolePO rolePo = Convert.convert(RolePO.class, roleDTO);
        return this.save(rolePo);
    }

    @Override
    public boolean updateById(RoleDTO roleDTO) {
        RolePO rolePo = Convert.convert(RolePO.class, roleDTO);
        return this.updateById(rolePo);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean removeRole(Long id) {
        if (baseMapper.selectUserOfRoleCount(id) > 0) {
            return false;
        }
        return this.removeById(id);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean assignRolePermission(RoleDTO roleDTO) {
        Long roleId = roleDTO.getId();
        baseMapper.deleteRolePermission(roleId);
        List<Long> permissionIdList = roleDTO.getRouterVOList().stream()
                .filter(Objects::nonNull)
                .map(RouterVO::getId)
                .collect(Collectors.toList());
        try {
            return baseMapper.assignRolePermission(roleId, permissionIdList) > 0;
        } catch (DataAccessException e) {
            log.error("SQL外键约束错误");
        }
        return false;
    }

}
