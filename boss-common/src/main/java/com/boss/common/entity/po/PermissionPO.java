package com.boss.common.entity.po;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.io.Serializable;
import java.util.Date;

/**
 * <p>
 * 
 * </p>
 *
 * @author DevinJoe
 * @since 2022-06-17
 */
@Data
@EqualsAndHashCode(callSuper = false)
@TableName("t_permission")
public class PermissionPO implements Serializable {

    private static final long serialVersionUID = -4347529323682981868L;
    /**
     * 权限编号
     */
    @TableId(value = "id", type = IdType.AUTO)
    private Long id;

    /**
     * 权限名称
     */
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
     * 父级菜单是否默认显示
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
     * 乐观锁
     */
    @Version
    private Integer version;

    /**
     * 是否被删除(1-已被删除，0-未被删除)
     */
    @TableLogic(value = "0", delval = "1")
    @TableField("is_deleted")
    private Integer deleted;

    /**
     * 启用状态(1-启用，0-禁用)
     */
    private Integer status;

    /**
     * 创建人id
     */
    @TableField(fill = FieldFill.INSERT)
    private Long createUserId;

    /**
     * 创建时间
     */
    @TableField(fill = FieldFill.INSERT)
    private Date createTime;

    /**
     * 更新人id
     */
    @TableField(fill = FieldFill.UPDATE)
    private Long updateUserId;

    /**
     * 更新时间
     */
    @TableField(fill = FieldFill.UPDATE)
    private Date updateTime;


}
