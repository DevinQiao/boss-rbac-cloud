package com.boss.auth.service.impl;

import com.boss.auth.service.PermissionService;
import com.boss.auth.service.RoleService;
import com.boss.auth.service.UserService;
import com.boss.common.entity.dto.PermissionDTO;
import com.boss.common.entity.dto.RoleDTO;
import com.boss.common.entity.dto.UserDTO;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;

/**
 * @author DevinJoe
 * @since 2022/7/7
 */
@Service
public class BossUserDetailServiceImpl implements UserDetailsService {

    @Resource
    private UserService userService;

    @Resource
    private RoleService roleService;

    @Resource
    private PermissionService permissionService;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        UserDTO userDto = userService.findUserByUserName(username);
        if (userDto == null) {
            throw new UsernameNotFoundException("用户名或密码错误!");
        }
        List<RoleDTO> roleDtoList = roleService.findRolesByUserId(userDto.getId());
        userDto.setRoleDTOList(roleDtoList);
        List<Long> rolesId = roleDtoList.stream().map(RoleDTO::getId).collect(Collectors.toList());
        List<PermissionDTO> permissionDTOList = permissionService.findPermissionListByRolesId(rolesId);
        List<String> codeList = permissionDTOList.stream()
                .filter(Objects::nonNull)
                .map(PermissionDTO::getCode)
                .filter(Objects::nonNull)
                .collect(Collectors.toList());
        String[] strings = codeList.toArray(new String[codeList.size()]);
        List<GrantedAuthority> authorityList = AuthorityUtils.createAuthorityList(strings);
        userDto.setAuthorities(authorityList);
        userDto.setPermissionDTOList(permissionDTOList);
        return userDto;
    }

}
