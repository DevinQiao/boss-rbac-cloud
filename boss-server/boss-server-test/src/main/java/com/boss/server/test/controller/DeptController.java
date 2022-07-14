package com.boss.server.test.controller;

import cn.hutool.core.convert.Convert;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.boss.common.entity.BossResponse;
import com.boss.common.entity.constant.BossStatusCodeConstant;
import com.boss.common.entity.dto.DeptDTO;
import com.boss.common.entity.po.DeptPO;
import com.boss.common.entity.vo.DeptVO;
import com.boss.server.test.service.IDeptService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;

/**
 * <p>
 * 部门表 前端控制器
 * </p>
 *
 * @author DevinJoe
 * @since 2022-07-14
 */
@Slf4j
@RestController
@RequestMapping("/dept")
public class DeptController {

    @Resource
    private IDeptService deptService;

    @PostMapping("list")
    public BossResponse deptList(@RequestBody DeptVO deptVO) {
        IPage<DeptPO> deptPage = new Page<>(deptVO.getPageNo(), deptVO.getPageSize());
        DeptDTO deptDTO = Convert.convert(DeptDTO.class, deptVO);
        return new BossResponse().statusCode(BossStatusCodeConstant.SUCCESS)
                .data(deptService.findDeptListByPage(deptPage, deptDTO))
                .message("分页查询部门信息成功");
    }

    @PostMapping("add")
    public BossResponse add(@RequestBody DeptVO deptVO) {
        DeptDTO deptDTO = Convert.convert(DeptDTO.class, deptVO);
        if (deptService.save(deptDTO)) {
            return new BossResponse().statusCode(BossStatusCodeConstant.SUCCESS).message("部门添加成功");
        }
        return new BossResponse().statusCode(BossStatusCodeConstant.ERROR).message("部门添加失败");
    }

    @PutMapping("update")
    public BossResponse update(@RequestBody DeptVO deptVO) {
        DeptDTO deptDTO = Convert.convert(DeptDTO.class, deptVO);
        if (deptService.updateById(deptDTO)) {
            return new BossResponse().statusCode(BossStatusCodeConstant.SUCCESS).message("部门修改成功");
        }
        return new BossResponse().statusCode(BossStatusCodeConstant.ERROR).message("部门修改失败");
    }

    @DeleteMapping("delete/{id}")
    public BossResponse delete(@PathVariable Long id) {
        if (deptService.removeById(id)) {
            return new BossResponse().statusCode(BossStatusCodeConstant.SUCCESS).message("部门删除成功");
        }
        return new BossResponse().statusCode(BossStatusCodeConstant.ERROR).message("部门删除失败");
    }

}

