package com.boss.common.entity.vo;

import com.boss.common.entity.dto.PermissionDTO;
import lombok.Data;

/**
 * @author DevinJoe
 * @since 2022/6/22
 */
@Data
public class PermissionVO extends PermissionDTO {

    private static final long serialVersionUID = 1686399644332657055L;

    /**
     * 当前页数
     */
    private Long pageNo;

    /**
     * 每页条数
     */
    private Long pageSize;

    public PermissionVO() {
        this.pageNo = 1L;
        this.pageSize = 5L;
    }

}
