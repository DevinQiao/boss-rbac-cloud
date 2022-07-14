package com.boss.common.entity.vo;

import com.boss.common.entity.dto.DeptDTO;
import lombok.Data;

/**
 * @author DevinJoe
 * @since 2022/7/14
 */
@Data
public class DeptVO extends DeptDTO {

    private static final long serialVersionUID = 8908352045285143283L;

    /**
     * 当前页数
     */
    private Long pageNo;

    /**
     * 每页条数
     */
    private Long pageSize;

    public DeptVO() {
        this.pageNo = 1L;
        this.pageSize = 5L;
    }

}
