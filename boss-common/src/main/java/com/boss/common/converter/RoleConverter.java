package com.boss.common.converter;

import com.boss.common.entity.dto.RoleDTO;
import com.boss.common.entity.po.RolePO;
import com.boss.common.entity.vo.RoleVO;
import org.mapstruct.InheritInverseConfiguration;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.Mappings;

import java.util.List;

/**
 * @author DevinJoe
 * @since 2022/6/19
 */
@Mapper(componentModel = "spring")
public interface RoleConverter {

    /**
     * 将RolePO转换为RoleDTO
     * @param rolePo
     * @return
     */
    RoleDTO poToDto(RolePO rolePo);

    /**
     * 将RolePO的List集合转换为RoleDTO的List集合
     * @param rolePoList
     * @return
     */
    List<RoleDTO> poToDtoForList(List<RolePO> rolePoList);

    /**
     * 将RoleDTO转换为RolePO
     * @param roleDTO
     * @return
     */
    @InheritInverseConfiguration(name = "poToDto")
    @Mappings({
            @Mapping(target = "version", ignore = true),
            @Mapping(target = "deleted", ignore = true),
            @Mapping(target = "createUserId", ignore = true),
            @Mapping(target = "createTime", ignore = true),
            @Mapping(target = "updateUserId", ignore = true),
            @Mapping(target = "updateTime", ignore = true),
    })
    RolePO dtoToPo(RoleDTO roleDTO);

    /**
     * 将RoleDTO转换为RoleVO
     * @param roleDTO
     * @return
     */
    @Mappings({
            @Mapping(target = "pageNo", ignore = true),
            @Mapping(target = "pageSize", ignore = true)
    })
    RoleVO dtoToVo(RoleDTO roleDTO);

    /**
     * 将RoleDTO的List集合转换为RoleVO的List集合
     * @param roleDTOList
     * @return
     */
    List<RoleVO> dtoToVoForList(List<RoleDTO> roleDTOList);

    /**
     * 将RoleVO转换为RoleDTO
     * @param roleVO
     * @return
     */
    @InheritInverseConfiguration(name = "dtoToVo")
    RoleDTO voToDto(RoleVO roleVO);
}
