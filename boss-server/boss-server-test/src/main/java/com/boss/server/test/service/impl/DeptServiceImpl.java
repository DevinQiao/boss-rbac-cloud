package com.boss.server.test.service.impl;

import cn.hutool.core.convert.Convert;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.boss.common.entity.dto.DeptDTO;
import com.boss.common.entity.po.DeptPO;
import com.boss.server.test.dao.DeptDao;
import com.boss.server.test.service.IDeptService;
import org.springframework.stereotype.Service;

/**
 * <p>
 * 部门表 服务实现类
 * </p>
 *
 * @author DevinJoe
 * @since 2022-07-14
 */
@Service
public class DeptServiceImpl extends ServiceImpl<DeptDao, DeptPO> implements IDeptService {

    @Override
    public Object findDeptListByPage(IPage<DeptPO> deptPage, DeptDTO deptDto) {
        QueryWrapper<DeptPO> queryWrapper = new QueryWrapper<>();
        return baseMapper.selectPage(deptPage, queryWrapper);
    }

    @Override
    public boolean save(DeptDTO deptDto) {
        DeptPO deptPo = Convert.convert(DeptPO.class, deptDto);
        return this.save(deptPo);
    }

    @Override
    public boolean updateById(DeptDTO deptDto) {
        DeptPO deptPo = Convert.convert(DeptPO.class, deptDto);
        return this.updateById(deptPo);
    }
}
