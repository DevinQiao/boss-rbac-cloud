package com.boss.server.system.controller;

import com.boss.common.entity.BossResponse;
import com.boss.common.entity.vo.DeptVO;
import com.boss.server.system.feign.IDeptService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;

/**
 * @author DevinJoe
 * @since 2022/7/14
 */
@Slf4j
@RequestMapping("/dept")
@RestController
public class DeptController {

    @Resource
    private IDeptService deptService;

    @PostMapping("list")
    public BossResponse deptList(@RequestBody DeptVO deptVO) {
        log.info("Feign调用boss-server-test的/dept/list服务");
        return this.deptService.deptList(deptVO);
    }

    @PostMapping("add")
    public BossResponse add(@RequestBody DeptVO deptVO) {
        log.info("Feign调用boss-server-test的/dept/add服务");
        return this.deptService.add(deptVO);
    }

    @PutMapping("update")
    public BossResponse update(@RequestBody DeptVO deptVO) {
        log.info("Feign调用boss-server-test的/dept/update服务");
        return this.deptService.update(deptVO);
    }

    @DeleteMapping("delete/{id}")
    public BossResponse delete(@PathVariable Long id) {
        log.info("Feign调用boss-server-test的/dept/delete服务");
        return this.deptService.delete(id);
    }

}
