package com.boss.common.entity.dto;

import com.boss.common.entity.vo.RouterVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Pattern;
import java.io.Serializable;
import java.util.List;

/**
 * <p>
 *
 * </p>
 *
 * @author DevinJoe
 * @since 2022-06-12
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class RoleDTO implements Serializable {

    private static final long serialVersionUID = 1084235642576215269L;
    /**
     * 角色编号
     */
    private Long id;

    /**
     * 角色编码
     */
    @NotBlank(message = "角色编码不能为空")
    @Pattern(regexp = "^\\w+$", message = "编码只能包含英文字母、数字和下划线")
    private String roleCode;

    /**
     * 角色名称
     */
    @NotBlank(message = "角色名称不能为空")
    private String roleName;

    /**
     * 描述
     */
    private String introduction;

    /**
     * 启用状态(1-启用，0-禁用)
     */
    private Integer status;

    /**
     * 角色拥有的权限
     */
    private List<RouterVO> routerVOList;

}
