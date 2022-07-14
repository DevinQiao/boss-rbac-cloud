package com.boss.common.entity.dto;

import com.baomidou.mybatisplus.annotation.TableField;
import com.fasterxml.jackson.annotation.JsonInclude;
import lombok.Data;
import lombok.EqualsAndHashCode;

import javax.validation.constraints.NotBlank;
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
public class PermissionDTO implements Serializable {

    private static final long serialVersionUID = -7141714464190610936L;
    /**
     * 权限编号
     */
    private Long id;

    /**
     * 权限名称
     */
    @NotBlank(message = "权限标题不能为空")
    private String title;

    /**
     * 父权限ID
     */
    private Long parentId;

    /**
     * 父权限名称
     */
    private String parentName;

    /**
     * 授权标识符
     */
    @NotBlank(message = "权限编码不能为空")
    private String code;

    /**
     * 路由地址
     */
    private String path;

    /**
     * 路由名称
     */
    private String name;

    /**
     * 路由重定向地址
     */
    private String redirect;

    /**
     * 父路由是否总是显示(0-不显示 1-显示)
     */
    private Integer alwaysShow;

    /**
     * 授权路径
     */
    private String url;

    /**
     * 权限类型(0-目录 1-菜单 2-按钮)
     */
    private Integer type;

    /**
     * 图标
     */
    private String icon;

    /**
     * 介绍
     */
    private String introduction;

    /**
     * 子菜单列表
     */
    @JsonInclude(JsonInclude.Include.NON_NULL)
    @TableField(exist = false)
    private List<PermissionDTO> children;

    /**
     * 启用状态(1-启用，0-禁用)
     */
    private Integer status;

}
