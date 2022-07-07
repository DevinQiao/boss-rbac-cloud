package com.boss.common.entity;

import java.util.HashMap;

/**
 * @author DevinJoe
 * @since 2022/7/7
 */
public class BossResponse extends HashMap<String, Object> {

    private static final long serialVersionUID = -8653959262134534226L;

    public BossResponse message(String message) {
        this.put("message", message);
        return this;
    }

    public BossResponse data(Object data) {
        this.put("data", data);
        return this;
    }

    @Override
    public BossResponse put(String key, Object value) {
        super.put(key, value);
        return this;
    }

    public String getMessage() {
        return String.valueOf(get("message"));
    }

    public Object getData() {
        return get("data");
    }
}
