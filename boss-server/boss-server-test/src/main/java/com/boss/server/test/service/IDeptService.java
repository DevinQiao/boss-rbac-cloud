package com.boss.server.test.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.IService;
import com.boss.common.entity.dto.DeptDTO;
import com.boss.common.entity.po.DeptPO;

/**
 * <p>
 * 部门表 服务类
 * </p>
 *
 * @author DevinJoe
 * @since 2022-07-14
 */
public interface IDeptService extends IService<DeptPO> {

    /**
     * 分页查询部门信息
     *
     * @param deptPage
     * @param deptDto
     * @return
     */
    Object findDeptListByPage(IPage<DeptPO> deptPage, DeptDTO deptDto);

    /**
     * 传入DTO对象，封装通用的save方法
     *
     * @param deptDto
     * @return
     */
    boolean save(DeptDTO deptDto);

    /**
     * 传入DTO对象，封装通用的updateById方法
     *
     * @param deptDto
     * @return
     */
    boolean updateById(DeptDTO deptDto);

}
