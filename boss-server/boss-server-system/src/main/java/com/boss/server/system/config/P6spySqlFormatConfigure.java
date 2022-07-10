package com.boss.server.system.config;

import com.boss.common.utils.DateUtil;
import com.p6spy.engine.spy.appender.MessageFormattingStrategy;
import org.apache.commons.lang3.StringUtils;

import java.time.LocalDateTime;

/**
 * @author DevinJoe
 * @since 2022/7/10
 */
public class P6spySqlFormatConfigure implements MessageFormattingStrategy {

    @Override
    public String formatMessage(int connectionId, String now, long elapsed, String category,
                                String prepared, String sql, String url) {
        return StringUtils.isNotBlank(sql) ?
                DateUtil.formatFullTime(LocalDateTime.now(), DateUtil.FULL_TIME_SPLIT_PATTERN) + " | 耗时" + elapsed
                + "ms | SQL语句" + StringUtils.LF + sql.replaceAll("[\\s]+", StringUtils.SPACE) + ";"
                : StringUtils.EMPTY;
    }
}
