package com.boss.common.entity.vo;

import com.fasterxml.jackson.annotation.JsonInclude;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.util.List;

/**
 * @author DevinJoe
 * @since 2022/6/12
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@JsonInclude(JsonInclude.Include.NON_NULL)
public class RouterVO implements Serializable {

    private static final long serialVersionUID = 2107680233163392660L;
    /**
     * 路由id
     */
    private Long id;

    /**
     * 路由地址
     */
    private String path;

    /**
     * 路由对应的组件
     */

    private String component;

    /**
     * 路由重定向地址
     */
    private String redirect;

    /**
     * 是否显示
     */
    private Boolean alwaysShow;

    /**
     * 路由名称
     */
    private String name;

    /**
     * 路由meta信息
     */
    private Meta meta;

    @Data
    @NoArgsConstructor
    @AllArgsConstructor
    public static class Meta implements Serializable {

        private static final long serialVersionUID = 2323195590119154148L;
        private String title;
        private String icon;
        private transient Object[] permissionCodes;

    }

    /**
     * 子路由
     */
    private List<RouterVO> children;

}
