package com.boss.common.entity.vo;

import com.boss.common.entity.dto.UserDTO;
import lombok.Data;

/**
 * @author DevinJoe
 * @since 2022/6/13
 */
@Data
public class UserVO extends UserDTO {

    private static final long serialVersionUID = -6955708283037131203L;
    /**
     * 当前页数
     */
    private Long pageNo;

    /**
     * 每页条数
     */
    private Long pageSize;

    public UserVO() {
        this.pageNo = 1L;
        this.pageSize = 5L;
    }

}
