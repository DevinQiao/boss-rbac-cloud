package com.boss.server.system.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.boss.common.entity.po.UserPO;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * <p>
 *  Mapper 接口
 * </p>
 *
 * @author DevinJoe
 * @since 2022-06-12
 */
public interface UserDao extends BaseMapper<UserPO> {

    /**
     * 删除用户角色关系
     * @param userId
     */
    @Delete("delete from t_user_role where user_id = #{userId}")
    void deleteUserRole(Long userId);

    /**
     * 为用户分配角色
     * @param userId
     * @param roleIds
     * @return
     */
    int assignUserRole(@Param("userId") Long userId, @Param("roleIds") List<Long> roleIds);
}
