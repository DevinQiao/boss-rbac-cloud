package com.boss.common.entity.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

/**
 * @author DevinJoe
 * @since 2022/7/14
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class DeptDTO implements Serializable {

    private static final long serialVersionUID = 5165402091352394336L;

    /**
     * 部门ID
     */
    private Long id;

    /**
     * 部门名称
     */
    private String name;

    /**
     * 排序
     */
    private Double orderNum;

}
