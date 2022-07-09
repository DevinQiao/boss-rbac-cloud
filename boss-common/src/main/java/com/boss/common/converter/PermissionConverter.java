package com.boss.common.converter;

import com.boss.common.entity.dto.PermissionDTO;
import com.boss.common.entity.po.PermissionPO;
import com.boss.common.entity.vo.PermissionVO;
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
public interface PermissionConverter {

    /**
     * 将PermissionPO转换为PermissionDTO
     * @param permissionPo
     * @return
     */
    PermissionDTO poToDto(PermissionPO permissionPo);

    /**
     * 将PermissionPO的List集合转换为PermissionDTO的List集合
     * @param permissionPoList
     * @return
     */
    List<PermissionDTO> poToDtoForList(List<PermissionPO> permissionPoList);

    /**
     * 将PermissionDTO转换为PermissionPO
     * @param permissionDTO
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
    PermissionPO dtoToPo(PermissionDTO permissionDTO);

    /**
     * 将PermissionDTO转换为PermissionVO
     * @param permissionDTO
     * @return
     */
    @Mappings({
            @Mapping(target = "pageNo", ignore = true),
            @Mapping(target = "pageSize", ignore = true)
    })
    PermissionVO dtoToVo(PermissionDTO permissionDTO);

    /**
     * 将PermissionVO转换为PermissionDTO
     * @param permissionVO
     * @return
     */
    PermissionDTO voToDto(PermissionVO permissionVO);

    /**
     * 将PermissionVO的List集合转换为PermissionDTO的List集合
     * @param permissionVOList
     * @return
     */
    List<PermissionDTO> voToDtoForList(List<PermissionVO> permissionVOList);
}
