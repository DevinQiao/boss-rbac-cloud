package com.boss.gateway.filter;

import com.boss.common.entity.constant.BossMediaTypeConstant;
import com.boss.common.entity.BossResponse;
import com.boss.common.utils.BossUtil;
import com.netflix.zuul.context.RequestContext;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang.StringUtils;
import org.springframework.cloud.netflix.zuul.filters.post.SendErrorFilter;
import org.springframework.cloud.netflix.zuul.filters.support.FilterConstants;
import org.springframework.stereotype.Component;
import org.springframework.util.ReflectionUtils;

import javax.servlet.http.HttpServletResponse;

/**
 * @author DevinJoe
 * @since 2022/7/8
 */
@Slf4j
@Component
public class BossGatewayErrorFilter extends SendErrorFilter {

    @Override
    public Object run() {
        try {
            BossResponse response = new BossResponse();
            RequestContext currentContext = RequestContext.getCurrentContext();
            String serviceId = (String) currentContext.get(FilterConstants.SERVICE_ID_KEY);

            ExceptionHolder exception = findZuulException(currentContext.getThrowable());
            String errorCause = exception.getErrorCause();
            Throwable throwable = exception.getThrowable();
            String message = throwable.getMessage();
            message = StringUtils.isBlank(message) ? errorCause : message;
            response = resolveExceptionMessage(message, serviceId, response);
            HttpServletResponse httpServletResponse = currentContext.getResponse();
            BossUtil.makeResponse(httpServletResponse, BossMediaTypeConstant.APPLICATION_JSON_UTF8_VALUE,
                    HttpServletResponse.SC_INTERNAL_SERVER_ERROR, response);
            log.error("Zuul sendError : {}", response.getMessage());
        } catch (Exception e) {
            log.error("Zuul sendError", e);
            ReflectionUtils.rethrowRuntimeException(e);
        }
        return null;
    }

    private BossResponse resolveExceptionMessage(String message, String serviceId, BossResponse bossResponse) {
        if (StringUtils.containsIgnoreCase(message, "time out")) {
            return bossResponse.message("请求" + serviceId + "服务超时");
        }
        if (StringUtils.containsIgnoreCase(message, "forwarding error")) {
            return bossResponse.message(serviceId + "服务不可用");
        }
        return bossResponse.message("Zuul请求" + serviceId + "服务异常");
    }
}
