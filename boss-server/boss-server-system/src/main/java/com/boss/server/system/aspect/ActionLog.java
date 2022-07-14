package com.boss.server.system.aspect;

import com.alibaba.fastjson.JSON;
import com.boss.server.system.annotation.BossLog;
import lombok.extern.slf4j.Slf4j;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.springframework.stereotype.Component;
import org.springframework.validation.BindingResult;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;

/**
 * @author DevinJoe
 * @since 2022/6/16
 */
@Aspect
@Component
@Slf4j
public class ActionLog {

    /**
     * 服务请求参数
     *
     * @param point
     * @param bossLog
     */
    @Before(value = "@annotation(bossLog)")
    public void before(JoinPoint point, BossLog bossLog) {
        Object[] args = point.getArgs();
        List<Object> argsList = new ArrayList<>();
        for (int i = 0; i < args.length; i++) {
            if (args[i] instanceof HttpServletRequest || args[i] instanceof HttpServletResponse || args[i] instanceof BindingResult) {
                continue;
            }
            argsList.add(args[i]);
        }
        log.info("服务{}调用开始,请求参数:{}", bossLog.action(), JSON.toJSONString(argsList));
    }

    /**
     * 服务运行时间
     *
     * @param point
     * @param bossLog
     * @return
     */
    @Around(value = "@annotation(bossLog)")
    public Object around(ProceedingJoinPoint point, BossLog bossLog) {
        Object result = null;
        String name = bossLog.action();
        long start = System.currentTimeMillis();
        try {
            result = point.proceed();
        } catch (Throwable throwable) {
            throwable.printStackTrace();
        } finally {
            long end = System.currentTimeMillis();
            log.info(String.format("服务%s,耗时:%dms", name, (end - start)));
        }
        return result;
    }

    /**
     * 服务返回结果
     *
     * @param point
     * @param bossLog
     * @param rvt
     */
    @AfterReturning(value = "@annotation(bossLog)", returning = "rvt")
    public void afterReturning(JoinPoint point, BossLog bossLog, Object rvt) {
        log.info("服务{}调用结束，response:{}", bossLog.action(), JSON.toJSONString(rvt));
    }

}

