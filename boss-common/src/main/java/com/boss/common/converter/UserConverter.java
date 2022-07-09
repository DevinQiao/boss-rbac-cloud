package com.boss.common.converter;

import com.boss.common.entity.dto.UserDTO;
import com.boss.common.entity.po.UserPO;
import com.boss.common.entity.vo.UserVO;
import org.apache.commons.lang3.BooleanUtils;
import org.apache.commons.lang3.StringUtils;
import org.mapstruct.*;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import java.util.List;

/**
 * @author DevinJoe
 * @since 2022/6/19
 */
@Mapper(componentModel = "spring")
public interface UserConverter {

    /**
     * 将UserPO转换为UserDTO
     * @param userPo
     * @return
     */
    @Mappings({
            @Mapping(source = "accountNonExpired", target = "accountNonExpired", qualifiedByName = "int2Boolean"),
            @Mapping(source = "accountNonLocked", target = "accountNonLocked", qualifiedByName = "int2Boolean"),
            @Mapping(source = "credentialsNonExpired", target = "credentialsNonExpired", qualifiedByName = "int2Boolean"),
            @Mapping(source = "enabled", target = "enabled", qualifiedByName = "int2Boolean"),
            @Mapping(target = "roleDTOList", ignore = true),
            @Mapping(target = "authorities", ignore = true),
            @Mapping(target = "permissionDTOList", ignore = true)
    })
    UserDTO poToDto(UserPO userPo);

    /**
     * 将UserPO的List集合转换为UserDTO的List集合
     * @param userPoList
     * @return
     */
    List<UserDTO> poToDtoForList(List<UserPO> userPoList);

    /**
     * 将UserDTO转换为UserPO
     * @param userDTO
     * @return
     */
    @InheritInverseConfiguration(name = "poToDto")
    @Mappings({
            @Mapping(target = "accountNonExpired", source = "accountNonExpired", qualifiedByName = "boolean2int"),
            @Mapping(target = "accountNonLocked", source = "accountNonLocked", qualifiedByName = "boolean2int"),
            @Mapping(target = "credentialsNonExpired", source = "credentialsNonExpired", qualifiedByName = "boolean2int"),
            @Mapping(target = "enabled", source = "enabled", qualifiedByName = "boolean2int"),
            @Mapping(target = "version", ignore = true),
            @Mapping(target = "deleted", ignore = true),
            @Mapping(target = "createUserId", ignore = true),
            @Mapping(target = "createTime", ignore = true),
            @Mapping(target = "updateUserId", ignore = true),
            @Mapping(target = "updateTime", ignore = true),
    })
    UserPO dtoToPo(UserDTO userDTO);

    /**
     * 将UserVO转换为UserDTO
     * @param userVO
     * @return
     */
    @Mapping(target = "password", source = "password", qualifiedByName = "passwordEncoder")
    UserDTO voToDto(UserVO userVO);

    /**
     * 将UserVO的List集合转为UserDTO的List集合
     * @param userVOList
     * @return
     */
    List<UserDTO> voToDtoForList(List<UserVO> userVOList);

    /**
     * 将UserDTO转换为UserVO
     * @param userDto
     * @return
     */
    @InheritInverseConfiguration(name = "voToDto")
    @Mappings({
            @Mapping(target = "pageNo", ignore = true),
            @Mapping(target = "pageSize", ignore = true),
            @Mapping(target = "password", source = "password")
    })
    UserVO dtoToVo(UserDTO userDto);

    /**
     * 把整型转换为布尔型
     * @param integer
     * @return
     */
    @Named("int2Boolean")
    default boolean int2Boolean(Integer integer) {
        return BooleanUtils.toBoolean(integer);
    }

    /**
     * 把布尔型转换为整形
     * @param flag
     * @return
     */
    @Named("boolean2int")
    default Integer boolean2int(boolean flag) {
        return BooleanUtils.toInteger(flag);
    }

    /**
     * 对密码进行加密
     * @param password
     * @return
     */
    @Named("passwordEncoder")
    default String passwordEncoder(String password) {
        if (StringUtils.isNotBlank(password)) {
            return new BCryptPasswordEncoder().encode(password);
        } else {
            return null;
        }
    }
}
