package com.boss.common.entity.vo;

import com.boss.common.entity.dto.RoleDTO;
import lombok.Data;

/**
 * @author DevinJoe
 * @since 2022/6/21
 */
@Data
public class RoleVO extends RoleDTO {

    private static final long serialVersionUID = -6730460483067393584L;
    /**
     * 当前页数
     */
    private Long pageNo;

    /**
     * 每页条数
     */
    private Long pageSize;

    public RoleVO() {
        this.pageNo = 1L;
        this.pageSize = 5L;
    }

}
