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
@TableName("t_user")
public class UserPO implements Serializable {

    private static final long serialVersionUID = 8894580194330947663L;
    /**
     * 用户编号
     */
    @TableId(value = "id", type = IdType.AUTO)
    private Long id;

    /**
     * 用户名
     */
    private String username;

    /**
     * 登录密码
     */
    private String password;

    /**
     * 帐户是否过期(1-未过期，0-已过期)
     */
    @TableField("is_account_non_expired")
    private Integer accountNonExpired;

    /**
     * 帐户是否被锁定(1-未过期，0-已过期)
     */
    @TableField("is_account_non_locked")
    private Integer accountNonLocked;

    /**
     * 密码是否过期(1-未过期，0-已过期)
     */
    @TableField("is_credentials_non_expired")
    private Integer credentialsNonExpired;

    /**
     * 帐户是否可用(1-可用，0-禁用)
     */
    @TableField("is_enabled")
    private Integer enabled;

    /**
     * 真实姓名
     */
    private String realName;

    /**
     * 昵称
     */
    private String nickName;

    /**
     * 年龄
     */
    private Integer age;

    /**
     * 性别(0-男，1-女)
     */
    private Integer gender;

    /**
     * 电话
     */
    private String phone;

    /**
     * 邮箱
     */
    private String email;

    /**
     * 地址
     */
    private String address;

    /**
     * 用户头像
     */
    private String avatar;

    /**
     * 账号启用状态(1-启用，0-禁用)
     */
    private Integer status;

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
