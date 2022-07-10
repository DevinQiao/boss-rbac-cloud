package com.boss.auth.properties;

import lombok.Data;

/**
 * @author DevinJoe
 * @since 2022/7/9
 */
@Data
public class BossValidateCodeProperties {

    /**
     * 验证码有效时间，单位秒
     */
    private Long time = 120L;

    /**
     * 验证码类型，可选值png和gif
     */
    private String type = "png";

    /**
     * 图片宽度，px
     */
    private Integer width = 130;

    /**
     * 图片高度，px
     */
    private Integer height = 48;

    /**
     * 验证码位数
     */
    private Integer length = 5;

    /**
     * 验证码值的类型
     * 1. 数字加字母
     * 2. 纯数字
     * 3. 纯字母
     */
    private Integer charType = 1;
}
