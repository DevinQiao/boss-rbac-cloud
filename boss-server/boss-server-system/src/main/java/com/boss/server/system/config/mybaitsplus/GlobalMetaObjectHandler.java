package com.boss.server.system.config.mybaitsplus;

import com.baomidou.mybatisplus.core.handlers.MetaObjectHandler;
import com.boss.common.entity.dto.UserDTO;
import com.boss.server.system.service.IUserService;
import lombok.extern.slf4j.Slf4j;
import org.apache.ibatis.reflection.MetaObject;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;
import org.springframework.util.ObjectUtils;

import javax.annotation.Resource;
import java.util.Date;

/**
 * @author DevinJoe
 * @since 2022/6/26
 */
@Slf4j
@Component
public class GlobalMetaObjectHandler implements MetaObjectHandler {

    @Resource
    private IUserService userService;

    /**
     * 创建信息
     */
    private static final String CREATE_ID = "createUserId";
    private static final String CREATE_TIME = "createTime";

    /**
     * 修改信息
     */
    private static final String UPDATE_ID = "updateUserId";
    private static final String UPDATE_TIME = "updateTime";

    @Override
    public void insertFill(MetaObject metaObject) {
        log.info("填充新增信息");
        this.setFieldValByName(CREATE_ID, getUserId(), metaObject);
        this.setFieldValByName(CREATE_TIME, new Date(), metaObject);
    }

    @Override
    public void updateFill(MetaObject metaObject) {
        log.info("填充修改信息");
        this.setFieldValByName(UPDATE_ID, getUserId(), metaObject);
        this.setFieldValByName(UPDATE_TIME, new Date(), metaObject);
    }

    private Long getUserId() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String username = (String) authentication.getPrincipal();
        UserDTO userDto = userService.findUserByUserName(username);
        if (!ObjectUtils.isEmpty(userDto)) {
            return userDto.getId();
        }
        return null;
    }

}
