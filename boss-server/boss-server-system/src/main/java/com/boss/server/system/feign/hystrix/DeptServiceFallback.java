package com.boss.server.system.feign.hystrix;

import com.boss.common.entity.BossResponse;
import com.boss.common.entity.constant.BossStatusCodeConstant;
import com.boss.common.entity.vo.DeptVO;
import com.boss.server.system.feign.IDeptService;
import feign.hystrix.FallbackFactory;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

/**
 * @author DevinJoe
 * @since 2022/7/14
 */
@Slf4j
@Component
public class DeptServiceFallback implements FallbackFactory<IDeptService> {

    public static final String FEIGN_MESSAGE = "Feign服务调用出错";

    @Override
    public IDeptService create(Throwable throwable) {
        return new IDeptService() {
            @Override
            public BossResponse deptList(DeptVO deptVO) {
                log.error("调用Boss-Server-Test的分页查询部门列表服务出错", throwable);
                return new BossResponse().statusCode(BossStatusCodeConstant.ERROR).message(FEIGN_MESSAGE);
            }

            @Override
            public BossResponse add(DeptVO deptVO) {
                log.error("调用Boss-Server-Test的新增部门服务出错", throwable);
                return new BossResponse().statusCode(BossStatusCodeConstant.ERROR).message(FEIGN_MESSAGE);
            }

            @Override
            public BossResponse update(DeptVO deptVO) {
                log.error("调用Boss-Server-Test的修改部门服务出错", throwable);
                return new BossResponse().statusCode(BossStatusCodeConstant.ERROR).message(FEIGN_MESSAGE);
            }

            @Override
            public BossResponse delete(Long id) {
                log.error("调用Boss-Server-Test的删除部门服务出错", throwable);
                return new BossResponse().statusCode(BossStatusCodeConstant.ERROR).message(FEIGN_MESSAGE);
            }
        };
    }

}
