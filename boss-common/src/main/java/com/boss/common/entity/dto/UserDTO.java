package com.boss.common.entity.dto;

import com.baomidou.mybatisplus.annotation.TableField;
import lombok.Data;
import lombok.EqualsAndHashCode;
import org.hibernate.validator.constraints.Range;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;
import java.io.Serializable;
import java.util.Collection;
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
public class UserDTO implements Serializable, UserDetails {

    private static final long serialVersionUID = 685948025854451943L;
    /**
     * 用户编号
     */
    private Long id;

    /**
     * 用户名
     */
    @NotBlank(message = "用户名不能为空")
    @Pattern(regexp = "^[A-Za-z0-9]+$", message = "用户名只能包含英文字母和数字")
    @Size(min = 3, max = 18, message = "用户名长度在 3 到 18 个字符之间")
    private String username;

    /**
     * 登录密码
     */
    @Pattern(regexp = "^\\w+$", message = "密码只能包含英文字母、数字和下划线")
    @Size(min = 6, max = 15, message = "密码长度在 6 到 15 个字符之间")
    private String password;

    /**
     * 帐户是否过期(1-未过期，0-已过期)
     */
    private Boolean accountNonExpired;

    /**
     * 帐户是否被锁定(1-未过期，0-已过期)
     */
    private Boolean accountNonLocked;

    /**
     * 密码是否过期(1-未过期，0-已过期)
     */
    private Boolean credentialsNonExpired;

    /**
     * 帐户是否可用(1-可用，0-禁用)
     */
    private Boolean enabled;

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
    @Range(min = 1, max = 120, message = "年龄应该在 1 到 120 岁之间")
    private Integer age;

    /**
     * 性别(0-男，1-女)
     */
    private Integer gender;

    /**
     * 电话
     */
    @NotBlank(message = "电话号码不能为空")
    @Pattern(regexp = "^(13[0-9]|14[01456879]|15[0-35-9]|16[2567]|17[0-8]|18[0-9]|19[0-35-9])\\d{8}$", message = "电话号码格式不正确")
    private String phone;

    /**
     * 邮箱
     */
    @Email(message = "邮箱格式不正确")
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
     * 角色信息
     */
    private List<RoleDTO> roleDTOList;

    /**
     * 权限列表
     */
    @TableField(exist = false)
    private Collection<? extends GrantedAuthority> authorities;

    /**
     * 查询用户权限列表
     */
    @TableField(exist = false)
    private List<PermissionDTO> permissionDTOList;

    /**
     * 账号启用状态(1-启用，0-禁用)
     */
    private Integer status;

    @Override
    public boolean isAccountNonExpired() {
        return this.accountNonExpired;
    }

    @Override
    public boolean isAccountNonLocked() {
        return this.accountNonLocked;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return this.credentialsNonExpired;
    }

    @Override
    public boolean isEnabled() {
        return this.enabled;
    }
}
