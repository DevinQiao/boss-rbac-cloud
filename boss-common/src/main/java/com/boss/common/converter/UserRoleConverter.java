package com.boss.common.converter;

import com.boss.common.entity.dto.UserRoleDTO;
import com.boss.common.entity.vo.UserRoleVO;
import org.mapstruct.InheritInverseConfiguration;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

import java.util.List;

/**
 * @author DevinJoe
 * @since 2022/6/21
 */
@Mapper(componentModel = "spring")
public interface UserRoleConverter {

    /**
     * 将UserRoleVO转换为UserRoleDTO
     * @param userRoleVO
     * @return
     */
    UserRoleDTO voToDto(UserRoleVO userRoleVO);

    /**
     * 将UserRoleVO的List集合转换为UserRoleDTO的List集合
     * @param userRoleVOList
     * @return
     */
    List<UserRoleDTO> voToDtoForList(List<UserRoleVO> userRoleVOList);

    /**
     * 将UserRoleDTO转换为UserRoleVO
     * @param userRoleDTO
     * @return
     */
    @InheritInverseConfiguration(name = "voToDto")
    @Mapping(target = "username", ignore = true)
    UserRoleVO dtoToVo(UserRoleDTO userRoleDTO);
}
