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
@TableName("t_role")
public class RolePO implements Serializable {

    private static final long serialVersionUID = 598561203359498033L;
    /**
     * 角色编号
     */
    @TableId(value = "id", type = IdType.AUTO)
    private Long id;

    /**
     * 角色编码
     */
    private String roleCode;

    /**
     * 角色名称
     */
    private String roleName;

    /**
     * 描述
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
