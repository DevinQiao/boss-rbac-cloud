package com.boss.server.system.feign;

import com.boss.common.entity.BossResponse;
import com.boss.common.entity.constant.BossServerConstant;
import com.boss.common.entity.vo.DeptVO;
import com.boss.server.system.feign.hystrix.DeptServiceFallback;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.*;

/**
 * @author DevinJoe
 * @since 2022/7/14
 */
@FeignClient(value = BossServerConstant.BOSS_SERVER_TEST, contextId = "deptServiceClient",
        path = "/dept", fallbackFactory = DeptServiceFallback.class)
public interface IDeptService {

    /**
     * 分页查询部门信息Feign接口
     * @param deptVO
     * @return
     */
    @PostMapping("list")
    BossResponse deptList(@RequestBody DeptVO deptVO);

    /**
     * 添加部门Feign接口
     * @param deptVO
     * @return
     */
    @PostMapping("add")
    BossResponse add(@RequestBody DeptVO deptVO);

    /**
     * 修改部门Feign接口
     * @param deptVO
     * @return
     */
    @PutMapping("update")
    BossResponse update(@RequestBody DeptVO deptVO);

    /**
     * 删除部门Feign接口
     * @param id
     * @return
     */
    @DeleteMapping("delete/{id}")
    BossResponse delete(@PathVariable(value = "id") Long id);
}
