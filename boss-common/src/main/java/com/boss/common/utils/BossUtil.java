package com.boss.common.utils;

import com.alibaba.fastjson.JSON;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * @author DevinJoe
 * @since 2022/7/8
 */
public class BossUtil {

    private BossUtil() {}

    /**
     * 设置响应
     * @param response
     * @param contentType
     * @param status
     * @param value
     * @throws IOException
     */
    public static void makeResponse(HttpServletResponse response, String contentType, int status, Object value) throws IOException {
        response.setContentType(contentType);
        response.setStatus(status);
        response.getOutputStream()
                .write((JSON.toJSONString(value)).getBytes());
    }
}
