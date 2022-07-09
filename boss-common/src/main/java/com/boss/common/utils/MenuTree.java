package com.boss.common.utils;

import com.boss.common.entity.dto.PermissionDTO;
import com.boss.common.entity.vo.RouterVO;
import org.apache.commons.lang3.BooleanUtils;
import org.springframework.beans.BeanUtils;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

/**
 * @author DevinJoe
 * @since 2022/6/12
 */
public class MenuTree {

    private MenuTree() {

    }

    /**
     * 生成路由
     * @param menuList  菜单列表
     * @param pid   父菜单ID
     * @return
     */
    public static List<RouterVO> makeRouter(List<PermissionDTO> menuList, Long pid) {
        List<RouterVO> routerVOList = new ArrayList<>();
        Optional.ofNullable(menuList).orElse(new ArrayList<>())
                .stream().filter(item -> item!=null && item.getParentId().equals(pid))
                .forEach(item -> {
                    RouterVO routerVo = new RouterVO();
                    routerVo.setId(item.getId());
                    routerVo.setName(item.getName());
                    routerVo.setPath(item.getPath());
                    routerVo.setRedirect(item.getRedirect());
                    routerVo.setAlwaysShow(BooleanUtils.toBoolean(item.getAlwaysShow()));
                    if (item.getParentId() == 0) {
                        routerVo.setComponent("Layout");
                    } else {
                        routerVo.setComponent(item.getUrl());
                    }
                    routerVo.setMeta(new RouterVO.Meta(item.getTitle(), item.getIcon(), item.getCode().split(",")));
                    List<RouterVO> children = makeRouter(menuList, item.getId());
                    routerVo.setChildren(children);
                    routerVOList.add(routerVo);
                });
        return routerVOList;
    }

    /**
     * 生成菜单树
     * @param menuList
     * @param pid
     * @return
     */
    public static List<PermissionDTO> makeMenuTree(List<PermissionDTO> menuList, Long pid) {
        List<PermissionDTO> permissionDTOList = new ArrayList<>();
        Optional.ofNullable(menuList).orElse(new ArrayList<>())
                .stream().filter(item -> item!=null && item.getParentId().equals(pid))
                .forEach(item -> {
                    PermissionDTO permissionDto = new PermissionDTO();
                    BeanUtils.copyProperties(item, permissionDto);
                    List<PermissionDTO> children = makeMenuTree(menuList, item.getId());
                    permissionDto.setChildren(children);
                    permissionDTOList.add(permissionDto);
                });
        return permissionDTOList;
    }
}
