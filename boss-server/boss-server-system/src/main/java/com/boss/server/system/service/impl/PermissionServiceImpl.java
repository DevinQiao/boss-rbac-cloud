package com.boss.server.system.service.impl;

import cn.hutool.core.convert.Convert;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.boss.common.entity.dto.PermissionDTO;
import com.boss.common.entity.dto.RolePermissionDTO;
import com.boss.common.entity.po.PermissionPO;
import com.boss.common.utils.MenuTree;
import com.boss.server.system.dao.PermissionDao;
import com.boss.server.system.service.IPermissionService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.ObjectUtils;

import java.util.ArrayList;
import java.util.List;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author DevinJoe
 * @since 2022-06-12
 */
@Service
public class PermissionServiceImpl extends ServiceImpl<PermissionDao, PermissionPO> implements IPermissionService {

    /**
     * 通过角色ID集合获得权限集合
     * @param rolesId
     * @return
     */
    @Override
    public List<PermissionDTO> findPermissionListByRolesId(List<Long> rolesId) {
        List<PermissionPO> permissionPoListByRolesId = baseMapper.findPermissionListByRolesId(rolesId);
        List<PermissionDTO> permissionDTOList = new ArrayList<>();
        permissionPoListByRolesId.forEach(permissionPO ->
                permissionDTOList.add(Convert.convert(PermissionDTO.class, permissionPO)));
        return permissionDTOList;
    }

    @Override
    public RolePermissionDTO makePermissionTree(Long roleId) {
        QueryWrapper<PermissionPO> queryWrapper = new QueryWrapper<>();
        List<PermissionPO> permissionPoList = baseMapper.selectList(queryWrapper);
        List<PermissionDTO> permissionDtos = new ArrayList<>();
        permissionPoList.forEach(permissionPO ->
                permissionDtos.add(Convert.convert(PermissionDTO.class, permissionPO)));
        RolePermissionDTO rolePermissionDTO = new RolePermissionDTO();
        rolePermissionDTO.setPermissionList(MenuTree.makeMenuTree(permissionDtos, 0L));
        List<Long> rolesId = new ArrayList<>();
        rolesId.add(roleId);
        List<PermissionDTO> permissionDTOList = this.findPermissionListByRolesId(rolesId);
        rolePermissionDTO.setCheckedList(permissionDTOList.toArray());
        return rolePermissionDTO;
    }

    @Override
    public Object findPermissionByPage(IPage<PermissionPO> permissionPage) {
        QueryWrapper<PermissionPO> queryWrapper = new QueryWrapper<>();
        return baseMapper.selectPage(permissionPage, queryWrapper);
    }

    @Override
    public PermissionDTO findPermissionByCode(String code) {
        QueryWrapper<PermissionPO> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq(!ObjectUtils.isEmpty(code), "code", code);
        PermissionPO permissionPo = baseMapper.selectOne(queryWrapper);
        return Convert.convert(PermissionDTO.class, permissionPo);
    }

    @Override
    public boolean save(PermissionDTO permissionDTO) {
        PermissionPO permissionPo = Convert.convert(PermissionPO.class, permissionDTO);
        return this.save(permissionPo);
    }

    @Override
    public boolean updateById(PermissionDTO permissionDTO) {
        PermissionPO permissionPo = Convert.convert(PermissionPO.class, permissionDTO);
        return this.updateById(permissionPo);
    }

    @Override
    public boolean hasChildren(Long id) {
        QueryWrapper<PermissionPO> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("parent_id", id);
        return baseMapper.selectCount(queryWrapper) > 0;
    }

    @Override
    public boolean hasRole(Long id) {
        return baseMapper.hasRole(id) > 0;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean removePermission(Long id) {
        return this.removeById(id);
    }
}
