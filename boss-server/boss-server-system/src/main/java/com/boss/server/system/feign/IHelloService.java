package com.boss.server.system.feign;

import com.boss.common.entity.constant.BossServerConstant;
import com.boss.server.system.fallback.HelloServiceFallback;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

/**
 * @author DevinJoe
 * @since 2022/7/9
 */
@FeignClient(value = BossServerConstant.BOSS_SERVER_TEST, contextId = "helloServiceClient", fallbackFactory = HelloServiceFallback.class)
public interface IHelloService {

    /**
     * hello feign
     * @param name
     * @return
     */
    @GetMapping("hello")
    String hello(@RequestParam("name") String name);
}
