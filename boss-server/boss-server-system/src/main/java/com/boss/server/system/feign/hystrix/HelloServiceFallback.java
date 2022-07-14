package com.boss.server.system.feign.hystrix;

import com.boss.server.system.feign.IHelloService;
import feign.hystrix.FallbackFactory;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

/**
 * @author DevinJoe
 * @since 2022/7/9
 */
@Slf4j
@Component
public class HelloServiceFallback implements FallbackFactory<IHelloService> {

    @Override
    public IHelloService create(Throwable throwable) {
        return name -> {
            log.error("调用Boss-Server-Test服务出错", throwable);
            return "调用出错";
        };
    }
}
