/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 80023
 Source Host           : localhost:3306
 Source Schema         : boss_rbac

 Target Server Type    : MySQL
 Target Server Version : 80023
 File Encoding         : 65001

 Date: 14/07/2022 23:51:54
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for t_dept
-- ----------------------------
DROP TABLE IF EXISTS `t_dept`;
CREATE TABLE `t_dept`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '部门ID',
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '部门名称',
  `order_num` double(20, 0) NULL DEFAULT NULL COMMENT '排序',
  `create_user_id` bigint(0) NULL DEFAULT NULL COMMENT '创建人ID',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_user_id` bigint(0) NULL DEFAULT NULL COMMENT '修改人ID',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '修改时间',
  `version` int(0) NULL DEFAULT 1 COMMENT '乐观锁',
  `is_deleted` tinyint(1) NULL DEFAULT 0 COMMENT '逻辑删除',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `t_dept_dept_name`(`name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '部门表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_dept
-- ----------------------------
INSERT INTO `t_dept` VALUES (1, '开发部', 1, NULL, '2018-01-04 15:42:26', NULL, '2019-01-05 21:08:27', 1, 0);
INSERT INTO `t_dept` VALUES (4, '市场部', 2, NULL, '2018-01-04 15:42:36', NULL, '2019-01-23 06:27:56', 1, 0);
INSERT INTO `t_dept` VALUES (5, '人事部', 3, NULL, '2018-01-04 15:42:32', NULL, '2019-01-23 06:27:59', 1, 0);

-- ----------------------------
-- Table structure for t_permission
-- ----------------------------
DROP TABLE IF EXISTS `t_permission`;
CREATE TABLE `t_permission`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '权限编号',
  `title` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '权限名称',
  `parent_id` bigint(0) NULL DEFAULT NULL COMMENT '父权限ID',
  `parent_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '父权限名称',
  `code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '授权标识符',
  `path` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '路由地址',
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '路由名称',
  `redirect` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '路由重定向地址',
  `always_show` tinyint(0) NULL DEFAULT 0 COMMENT '父级菜单是否默认显示',
  `url` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '授权路径',
  `type` tinyint(0) NULL DEFAULT NULL COMMENT '权限类型(0-目录 1-菜单 2-按钮)',
  `icon` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '图标',
  `introduction` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '介绍',
  `version` int(0) NULL DEFAULT 1 COMMENT '乐观锁',
  `is_deleted` tinyint(0) NULL DEFAULT 0 COMMENT '是否被删除(1-已被删除，0-未被删除)',
  `status` tinyint(0) NULL DEFAULT NULL COMMENT '启用状态(1-启用，0-禁用)',
  `create_user_id` bigint(0) NULL DEFAULT NULL COMMENT '创建人id',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_user_id` bigint(0) NULL DEFAULT NULL COMMENT '更新人id',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `create_user_id`(`create_user_id`) USING BTREE,
  INDEX `update_user_id`(`update_user_id`) USING BTREE,
  CONSTRAINT `t_permission_ibfk_1` FOREIGN KEY (`create_user_id`) REFERENCES `t_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `t_permission_ibfk_2` FOREIGN KEY (`update_user_id`) REFERENCES `t_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 39 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_permission
-- ----------------------------
INSERT INTO `t_permission` VALUES (1, '用户管理', 0, '主菜单', 'sys:user', '/user', 'User', '/user/list', 0, '/user', 0, 'user', '用户管理目录', 1, 0, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `t_permission` VALUES (2, '用户信息管理', 1, '用户管理', 'sys:user:info', 'list', 'UserInfo', NULL, 0, '/user/index', 1, 'peoples', '用户信息管理菜单', 1, 0, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `t_permission` VALUES (3, '新增', 2, '用户信息管理', 'sys:user:add', NULL, NULL, NULL, 0, NULL, 2, 'el-icon-plus', '新增用户信息', 1, 0, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `t_permission` VALUES (4, '修改', 2, '用户信息管理', 'sys:user:update', NULL, NULL, NULL, 0, NULL, 2, 'el-icon-edit', '修改用户信息', 1, 0, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `t_permission` VALUES (5, '删除', 2, '用户信息管理', 'sys:user:delete', NULL, NULL, NULL, 0, NULL, 2, 'el-icon-delete', '删除用户信息', 1, 0, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `t_permission` VALUES (6, '用户角色分配', 1, '用户管理', 'sys:user:role', '/role', 'UserRole', '/user/role/list', 0, '/user/user-role', 1, 'peoples', '为用户分配角色', 1, 0, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `t_permission` VALUES (7, '分配角色', 6, '用户角色分配', 'sys:user:role:assign', NULL, NULL, NULL, 0, NULL, 2, 'el-icon-edit', '分配角色按钮', 1, 0, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `t_permission` VALUES (8, '角色管理', 0, '主菜单', 'sys:role', '/role', 'Role', '/role/list', 0, '/role', 0, 'user', '角色管理目录', 1, 0, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `t_permission` VALUES (9, '新建', 8, '角色管理', 'sys:role:add', NULL, NULL, NULL, 0, NULL, 2, 'el-icon-plus', '新增角色信息', 1, 0, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `t_permission` VALUES (10, '修改', 8, '角色管理', 'sys:role:update', NULL, NULL, NULL, 0, NULL, 2, 'el-icon-update', '修改角色信息', 1, 0, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `t_permission` VALUES (11, '删除', 8, '角色管理', 'sys:role:delete', NULL, NULL, NULL, 0, NULL, 2, 'el-icon-delete', '删除角色信息', 1, 0, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `t_permission` VALUES (12, '分配权限', 8, '角色管理', 'sys:role:permission', NULL, NULL, NULL, 0, NULL, 2, NULL, '为角色分配权限', 1, 0, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `t_permission` VALUES (13, '分配用户', 8, '角色管理', 'sys:role:user', NULL, NULL, NULL, 0, NULL, 2, NULL, '为角色分配用户', 1, 0, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `t_permission` VALUES (14, '权限管理', 0, '主菜单', 'sys:permission', '/permission', 'Permission', '/permission/list', 0, '/permission', 1, 'user', '权限管理', 1, 0, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `t_permission` VALUES (15, '新增', 14, '权限管理', 'sys:permission:add', NULL, NULL, NULL, 0, NULL, 2, 'el-icon-plus', '新增权限', 1, 0, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `t_permission` VALUES (16, '修改', 14, '权限管理', 'sys:permission:update', NULL, NULL, NULL, 0, NULL, 2, 'el-icon-update', '修改权限', 1, 0, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `t_permission` VALUES (17, '删除', 14, '权限管理', 'sys:permission:delete', NULL, NULL, NULL, 0, NULL, 2, 'el-icon-delete', '删除权限', 1, 0, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `t_permission` VALUES (18, '分配角色', 14, '权限管理', 'sys:permission:role', NULL, NULL, NULL, 0, NULL, 2, 'el-icon-user', '为权限分配角色', 1, 0, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `t_permission` VALUES (19, '角色管理', 8, '角色管理', 'sys:role:list', 'list', 'RoleList', '', 0, '/role/index', 1, 'user', '角色管理界面', 1, 0, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `t_permission` VALUES (20, '权限管理', 14, '权限管理', 'sys:permission:list', 'list', 'PermissionList', NULL, 0, '/permission/index', 1, 'user', '权限管理界面', 1, 0, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `t_permission` VALUES (21, '部门管理', 0, '主菜单', 'sys:dept', '/dept', 'Dept', '/dept/list', 0, '/dept/index', 0, 'user', '部门管理主菜单', 1, 0, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `t_permission` VALUES (22, '部门管理', 21, '部门管理', 'sys:dept:list', NULL, NULL, NULL, 0, '/dept/index', 1, 'user', '部门管理界面', 1, 0, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `t_permission` VALUES (23, '新增', 22, '部门管理', 'sys:dept:add', NULL, NULL, NULL, 0, NULL, 2, 'el-icon-plus', '新增部门信息', 1, 0, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `t_permission` VALUES (24, '修改', 22, '部门管理', 'sys:dept:update', NULL, NULL, NULL, 0, NULL, 2, 'el-icon-update', '修改部门信息', 1, 0, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `t_permission` VALUES (25, '删除', 22, '部门管理', 'sys:dept:delete', NULL, NULL, NULL, 0, NULL, 2, 'el-icon-delete', '删除部门信息', 1, 0, NULL, NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for t_role
-- ----------------------------
DROP TABLE IF EXISTS `t_role`;
CREATE TABLE `t_role`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '角色编号',
  `role_code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '角色编码',
  `role_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '角色名称',
  `introduction` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述',
  `version` int(0) NULL DEFAULT 1 COMMENT '乐观锁',
  `is_deleted` tinyint(0) NULL DEFAULT 0 COMMENT '是否被删除(1-已被删除，0-未被删除)',
  `status` tinyint(0) NULL DEFAULT NULL COMMENT '启用状态(1-启用，0-禁用)',
  `create_user_id` bigint(0) NULL DEFAULT NULL COMMENT '创建人id',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_user_id` bigint(0) NULL DEFAULT NULL COMMENT '更新人id',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `create_user_id`(`create_user_id`) USING BTREE,
  INDEX `update_user_id`(`update_user_id`) USING BTREE,
  CONSTRAINT `t_role_ibfk_1` FOREIGN KEY (`create_user_id`) REFERENCES `t_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `t_role_ibfk_2` FOREIGN KEY (`update_user_id`) REFERENCES `t_role` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_role
-- ----------------------------
INSERT INTO `t_role` VALUES (1, 'ROLE_ADMIN', '超级管理员', '拥有所有权限', 1, 0, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `t_role` VALUES (2, 'ROLE_EDITOR', '普通管理员', '没有权限管理功能', 1, 0, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `t_role` VALUES (3, 'ROLE_VISTOR', '普通用户', '只有访问权限', 1, 0, NULL, NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for t_role_permission
-- ----------------------------
DROP TABLE IF EXISTS `t_role_permission`;
CREATE TABLE `t_role_permission`  (
  `role_Id` bigint(0) NOT NULL COMMENT '角色ID',
  `permission_Id` bigint(0) NOT NULL COMMENT '权限ID',
  INDEX `role_Id`(`role_Id`) USING BTREE,
  INDEX `permission_Id`(`permission_Id`) USING BTREE,
  CONSTRAINT `t_role_permission_ibfk_1` FOREIGN KEY (`role_Id`) REFERENCES `t_role` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `t_role_permission_ibfk_2` FOREIGN KEY (`permission_Id`) REFERENCES `t_permission` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_role_permission
-- ----------------------------
INSERT INTO `t_role_permission` VALUES (2, 1);
INSERT INTO `t_role_permission` VALUES (2, 2);
INSERT INTO `t_role_permission` VALUES (2, 3);
INSERT INTO `t_role_permission` VALUES (2, 4);
INSERT INTO `t_role_permission` VALUES (2, 5);
INSERT INTO `t_role_permission` VALUES (2, 6);
INSERT INTO `t_role_permission` VALUES (2, 7);
INSERT INTO `t_role_permission` VALUES (2, 8);
INSERT INTO `t_role_permission` VALUES (2, 9);
INSERT INTO `t_role_permission` VALUES (2, 10);
INSERT INTO `t_role_permission` VALUES (2, 11);
INSERT INTO `t_role_permission` VALUES (2, 12);
INSERT INTO `t_role_permission` VALUES (2, 13);
INSERT INTO `t_role_permission` VALUES (2, 19);
INSERT INTO `t_role_permission` VALUES (1, 1);
INSERT INTO `t_role_permission` VALUES (1, 2);
INSERT INTO `t_role_permission` VALUES (1, 3);
INSERT INTO `t_role_permission` VALUES (1, 4);
INSERT INTO `t_role_permission` VALUES (1, 5);
INSERT INTO `t_role_permission` VALUES (1, 6);
INSERT INTO `t_role_permission` VALUES (1, 7);
INSERT INTO `t_role_permission` VALUES (1, 8);
INSERT INTO `t_role_permission` VALUES (1, 9);
INSERT INTO `t_role_permission` VALUES (1, 10);
INSERT INTO `t_role_permission` VALUES (1, 11);
INSERT INTO `t_role_permission` VALUES (1, 12);
INSERT INTO `t_role_permission` VALUES (1, 13);
INSERT INTO `t_role_permission` VALUES (1, 14);
INSERT INTO `t_role_permission` VALUES (1, 15);
INSERT INTO `t_role_permission` VALUES (1, 16);
INSERT INTO `t_role_permission` VALUES (1, 17);
INSERT INTO `t_role_permission` VALUES (1, 18);
INSERT INTO `t_role_permission` VALUES (1, 19);
INSERT INTO `t_role_permission` VALUES (1, 20);
INSERT INTO `t_role_permission` VALUES (1, 21);
INSERT INTO `t_role_permission` VALUES (1, 22);
INSERT INTO `t_role_permission` VALUES (1, 23);
INSERT INTO `t_role_permission` VALUES (1, 24);
INSERT INTO `t_role_permission` VALUES (1, 25);

-- ----------------------------
-- Table structure for t_user
-- ----------------------------
DROP TABLE IF EXISTS `t_user`;
CREATE TABLE `t_user`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '用户编号',
  `username` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户名',
  `password` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '登录密码',
  `is_account_non_expired` tinyint(0) NULL DEFAULT NULL COMMENT '帐户是否过期(1-未过期，0-已过期)',
  `is_account_non_locked` tinyint(0) NULL DEFAULT NULL COMMENT '帐户是否被锁定(1-未过期，0-已过期)',
  `is_credentials_non_expired` tinyint(0) NULL DEFAULT NULL COMMENT '密码是否过期(1-未过期，0-已过期)',
  `is_enabled` tinyint(0) NULL DEFAULT NULL COMMENT '帐户是否可用(1-可用，0-禁用)',
  `real_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '真实姓名',
  `nick_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '昵称',
  `age` int(0) NULL DEFAULT NULL COMMENT '年龄',
  `gender` tinyint(0) NOT NULL COMMENT '性别(0-男，1-女)',
  `phone` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '电话',
  `email` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `address` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '地址',
  `avatar` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'https://manong-authority.oss-cn-guangzhou.aliyuncs.com/avatar/default-avatar.gif' COMMENT '用户头像',
  `version` int(0) NULL DEFAULT 1 COMMENT '乐观锁',
  `create_user_id` bigint(0) NULL DEFAULT NULL COMMENT '创建人id',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_user_id` bigint(0) NULL DEFAULT NULL COMMENT '更新人id',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `status` tinyint(0) NULL DEFAULT 1 COMMENT '账号启用状态(1-启用，0-禁用)',
  `is_deleted` tinyint(0) NULL DEFAULT 0 COMMENT '是否被删除(1-已被删除，0-未被删除)',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 136 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_user
-- ----------------------------
INSERT INTO `t_user` VALUES (1, 'admin', '$2a$10$B1sPu9mkIjySfTpaLJPuT.fK.v.ajOdBbAEjd0cqA2uF21ggc6TsO', 1, 1, 1, 1, '段洋', '义战情', 35, 0, '13596381262', 'h.evei@rxoc.et', '江西省 上饶市 横峰县', 'https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif', 1, NULL, NULL, NULL, NULL, 1, 0);
INSERT INTO `t_user` VALUES (2, 'editor', '$2a$10$B1sPu9mkIjySfTpaLJPuT.fK.v.ajOdBbAEjd0cqA2uF21ggc6TsO', 1, 1, 1, 1, '郑强', '京火较', 102, 1, '13215377445', 'd.wmawby@nwhfcupe.cf', '甘肃省 白银市 靖远县', 'https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif', 1, NULL, NULL, NULL, NULL, 1, 0);
INSERT INTO `t_user` VALUES (3, 'joe', '$2a$10$B1sPu9mkIjySfTpaLJPuT.fK.v.ajOdBbAEjd0cqA2uF21ggc6TsO', 1, 1, 1, 1, '韩洋', '红要见极', 75, 1, '13554217804', 'g.ikri@spajtbtbrn.net.cn', '云南省 红河哈尼族彝族自治州 开远市', 'https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif', 1, NULL, NULL, NULL, NULL, 1, 0);
INSERT INTO `t_user` VALUES (4, 'lmjt', '$2a$10$B1sPu9mkIjySfTpaLJPuT.fK.v.ajOdBbAEjd0cqA2uF21ggc6TsO', 1, 1, 1, 1, '邓明', '设至都效', 93, 0, '13242022798', 'y.jqyunkg@lymqsyyx.int', '江苏省 无锡市 其它区', 'https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif', 1, NULL, NULL, NULL, NULL, 1, 0);
INSERT INTO `t_user` VALUES (5, 'tgh', '$2a$10$B1sPu9mkIjySfTpaLJPuT.fK.v.ajOdBbAEjd0cqA2uF21ggc6TsO', 1, 1, 1, 1, '傅娟', '果易数则', 92, 1, '18993687411', 'u.rnwjuvpn@fjlqmg.vg', '吉林省 松原市 扶余市', 'https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif', 1, NULL, NULL, NULL, NULL, 1, 0);
INSERT INTO `t_user` VALUES (6, 'lnxp', '$2a$10$B1sPu9mkIjySfTpaLJPuT.fK.v.ajOdBbAEjd0cqA2uF21ggc6TsO', 1, 1, 1, 1, '邱刚', '毛合联从', 108, 1, '18924717679', 'h.lklc@xvbpmr.mn', '内蒙古自治区 乌兰察布市 化德县', 'https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif', 1, NULL, NULL, NULL, NULL, 1, 0);
INSERT INTO `t_user` VALUES (7, 'fjd', '$2a$10$B1sPu9mkIjySfTpaLJPuT.fK.v.ajOdBbAEjd0cqA2uF21ggc6TsO', 1, 1, 1, 1, '夏平', '过治清', 68, 0, '13547110201', 'c.rpevrmhhu@gorhfq.cg', '上海 上海市 虹口区', 'https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif', 1, NULL, NULL, NULL, NULL, 1, 0);
INSERT INTO `t_user` VALUES (8, 'vsy', '$2a$10$B1sPu9mkIjySfTpaLJPuT.fK.v.ajOdBbAEjd0cqA2uF21ggc6TsO', 1, 1, 1, 1, '沈芳', '心运名影', 33, 0, '13575357673', 'c.gfm@wuxaggy.cf', '海南省 三沙市 南沙群岛', 'https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif', 1, NULL, NULL, NULL, NULL, 1, 0);
INSERT INTO `t_user` VALUES (9, 'idrm', '$2a$10$B1sPu9mkIjySfTpaLJPuT.fK.v.ajOdBbAEjd0cqA2uF21ggc6TsO', 1, 1, 1, 1, '刘军', '识儿每大', 76, 1, '13554665759', 'y.fwiuib@ilrzbkqr.cc', '贵州省 黔南布依族苗族自治州 瓮安县', 'https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif', 1, NULL, NULL, NULL, NULL, 1, 0);
INSERT INTO `t_user` VALUES (10, 'luzs', '$2a$10$B1sPu9mkIjySfTpaLJPuT.fK.v.ajOdBbAEjd0cqA2uF21ggc6TsO', 1, 1, 1, 1, '苏杰', '一为分拉', 31, 1, '13571785071', 'v.ffbr@heicojyfpp.中国互联.公司', '河北省 秦皇岛市 北戴河区', 'https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif', 1, NULL, NULL, NULL, NULL, 1, 0);
INSERT INTO `t_user` VALUES (11, 'ihe', '$2a$10$B1sPu9mkIjySfTpaLJPuT.fK.v.ajOdBbAEjd0cqA2uF21ggc6TsO', 1, 1, 1, 1, '程强', '实于下', 53, 1, '13517961181', 't.hrrmxgj@loggofqfjk.hn', '湖南省 湘潭市 湘乡市', 'https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif', 1, NULL, NULL, NULL, NULL, 1, 0);
INSERT INTO `t_user` VALUES (12, 'nmt', '$2a$10$B1sPu9mkIjySfTpaLJPuT.fK.v.ajOdBbAEjd0cqA2uF21ggc6TsO', 1, 1, 1, 1, '黎涛', '律得把目', 33, 1, '13576724685', 'c.wjynpuxoq@jsrlqcb.mh', '河北省 廊坊市 大厂回族自治县', 'https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif', 1, NULL, NULL, NULL, NULL, 1, 0);
INSERT INTO `t_user` VALUES (13, 'qtu', '$2a$10$B1sPu9mkIjySfTpaLJPuT.fK.v.ajOdBbAEjd0cqA2uF21ggc6TsO', 1, 1, 1, 1, '黎秀兰', '最亲于张', 47, 0, '13207595512', 'u.gownhmgmw@ptujysyh.gd', '北京 北京市 海淀区', 'https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif', 1, NULL, NULL, NULL, NULL, 1, 0);
INSERT INTO `t_user` VALUES (14, 'nko', '$2a$10$B1sPu9mkIjySfTpaLJPuT.fK.v.ajOdBbAEjd0cqA2uF21ggc6TsO', 1, 1, 1, 1, '许杰', '油合离', 23, 1, '18953182756', 'h.lihswux@kzvrlyemnd.ph', '河北省 邯郸市 鸡泽县', 'https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif', 1, NULL, NULL, NULL, NULL, 1, 0);
INSERT INTO `t_user` VALUES (15, 'fqzv', '$2a$10$B1sPu9mkIjySfTpaLJPuT.fK.v.ajOdBbAEjd0cqA2uF21ggc6TsO', 1, 1, 1, 1, '毛娟', '天头至没', 16, 0, '18910807735', 'm.ecque@kvuxgms.uk', '甘肃省 临夏回族自治州 广河县', 'https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif', 1, NULL, NULL, NULL, NULL, 1, 0);
INSERT INTO `t_user` VALUES (16, 'enms', '$2a$10$B1sPu9mkIjySfTpaLJPuT.fK.v.ajOdBbAEjd0cqA2uF21ggc6TsO', 1, 1, 1, 1, '贺军', '能目头将', 96, 0, '13587718816', 'g.jrtxt@weytfxglo.la', '山西省 大同市 浑源县', 'https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif', 1, NULL, NULL, NULL, NULL, 1, 0);
INSERT INTO `t_user` VALUES (17, 'cslt', '$2a$10$B1sPu9mkIjySfTpaLJPuT.fK.v.ajOdBbAEjd0cqA2uF21ggc6TsO', 1, 1, 1, 1, '孔芳', '得火酸', 106, 0, '13265224656', 'x.enrjsgxs@rihkmkspj.zr', '上海 上海市 静安区', 'https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif', 1, NULL, NULL, NULL, NULL, 1, 0);
INSERT INTO `t_user` VALUES (18, 'kvq', '$2a$10$B1sPu9mkIjySfTpaLJPuT.fK.v.ajOdBbAEjd0cqA2uF21ggc6TsO', 1, 1, 1, 1, '阎杰', '题己太林', 96, 1, '13591482235', 'f.ifltrac@noi.nc', '西藏自治区 阿里地区 札达县', 'https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif', 1, NULL, NULL, NULL, NULL, 1, 0);
INSERT INTO `t_user` VALUES (19, 'tyh', '$2a$10$B1sPu9mkIjySfTpaLJPuT.fK.v.ajOdBbAEjd0cqA2uF21ggc6TsO', 1, 1, 1, 1, '戴涛', '量太有', 68, 1, '13540347214', 'g.whbcfg@thvj.sm', '山东省 滨州市 沾化县', 'https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif', 1, NULL, NULL, NULL, NULL, 1, 0);
INSERT INTO `t_user` VALUES (20, 'cqhu', '$2a$10$B1sPu9mkIjySfTpaLJPuT.fK.v.ajOdBbAEjd0cqA2uF21ggc6TsO', 1, 1, 1, 1, '钱霞', '根达山业', 7, 1, '13595273457', 'i.vnqcqlcpj@ijmlrotdv.hn', '海外 海外 -', 'https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif', 1, NULL, NULL, NULL, NULL, 1, 0);
INSERT INTO `t_user` VALUES (21, 'prd', '$2a$10$B1sPu9mkIjySfTpaLJPuT.fK.v.ajOdBbAEjd0cqA2uF21ggc6TsO', 1, 1, 1, 1, '田平', '领和上八', 88, 1, '13235613189', 'o.xyty@rtughreuv.bm', '河南省 焦作市 博爱县', 'https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif', 1, NULL, NULL, NULL, NULL, 1, 0);
INSERT INTO `t_user` VALUES (22, 'bjcj', '$2a$10$B1sPu9mkIjySfTpaLJPuT.fK.v.ajOdBbAEjd0cqA2uF21ggc6TsO', 1, 1, 1, 1, '尹秀英', '头社程', 59, 1, '13270709744', 'd.glbjfdsbw@webplzlu.kw', '山东省 滨州市 惠民县', 'https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif', 1, NULL, NULL, NULL, NULL, 1, 0);
INSERT INTO `t_user` VALUES (23, 'dnwk', '$2a$10$B1sPu9mkIjySfTpaLJPuT.fK.v.ajOdBbAEjd0cqA2uF21ggc6TsO', 1, 1, 1, 1, '沈强', '间信格争', 33, 1, '18997751884', 's.rtjaflc@irts.tr', '河南省 洛阳市 西工区', 'https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif', 1, NULL, NULL, NULL, NULL, 1, 0);
INSERT INTO `t_user` VALUES (24, 'hyg', '$2a$10$B1sPu9mkIjySfTpaLJPuT.fK.v.ajOdBbAEjd0cqA2uF21ggc6TsO', 1, 1, 1, 1, '彭敏', '火情便', 39, 1, '13279641372', 'r.tfrpqxppr@rsgx.kg', '河北省 沧州市 东光县', 'https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif', 1, NULL, NULL, NULL, NULL, 1, 0);
INSERT INTO `t_user` VALUES (25, 'jori', '$2a$10$B1sPu9mkIjySfTpaLJPuT.fK.v.ajOdBbAEjd0cqA2uF21ggc6TsO', 1, 1, 1, 1, '赖磊', '响眼办派', 36, 0, '13508638878', 'l.nnnqs@lvjdgjef.org', '江苏省 徐州市 云龙区', 'https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif', 1, NULL, NULL, NULL, NULL, 1, 0);
INSERT INTO `t_user` VALUES (26, 'zxr', '$2a$10$B1sPu9mkIjySfTpaLJPuT.fK.v.ajOdBbAEjd0cqA2uF21ggc6TsO', 1, 1, 1, 1, '孟伟', '共米期证', 11, 0, '13557364524', 'c.chd@yugenqdr.va', '福建省 龙岩市 漳平市', 'https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif', 1, NULL, NULL, NULL, NULL, 1, 0);
INSERT INTO `t_user` VALUES (27, 'xqtw', '$2a$10$B1sPu9mkIjySfTpaLJPuT.fK.v.ajOdBbAEjd0cqA2uF21ggc6TsO', 1, 1, 1, 1, '范丽', '清太全在', 58, 0, '18942848508', 'y.yscdfhm@hxnlelg.sd', '江苏省 淮安市 盱眙县', 'https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif', 1, NULL, NULL, NULL, NULL, 1, 0);
INSERT INTO `t_user` VALUES (28, 'djff', '$2a$10$B1sPu9mkIjySfTpaLJPuT.fK.v.ajOdBbAEjd0cqA2uF21ggc6TsO', 1, 1, 1, 1, '乔平', '面路无', 54, 0, '18976236833', 'e.hjumzruo@ndviqjkusb.cq', '山西省 长治市 城区', 'https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif', 1, NULL, NULL, NULL, NULL, 1, 0);
INSERT INTO `t_user` VALUES (29, 'gifj', '$2a$10$B1sPu9mkIjySfTpaLJPuT.fK.v.ajOdBbAEjd0cqA2uF21ggc6TsO', 1, 1, 1, 1, '沈军', '次称向', 79, 1, '18964253523', 'z.xugfdlifk@sbofktb.eh', '北京 北京市 平谷区', 'https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif', 1, NULL, NULL, NULL, NULL, 1, 0);
INSERT INTO `t_user` VALUES (30, 'eijy', '$2a$10$B1sPu9mkIjySfTpaLJPuT.fK.v.ajOdBbAEjd0cqA2uF21ggc6TsO', 1, 1, 1, 1, '秦磊', '过定化', 110, 0, '13288722581', 'h.bznvkckwh@fpcne.gu', '云南省 文山壮族苗族自治州 马关县', 'https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif', 1, NULL, NULL, NULL, NULL, 1, 0);
INSERT INTO `t_user` VALUES (31, 'korc', '$2a$10$B1sPu9mkIjySfTpaLJPuT.fK.v.ajOdBbAEjd0cqA2uF21ggc6TsO', 1, 1, 1, 1, '徐磊', '花议阶点', 62, 1, '13217462411', 't.jptkq@ybwkxrkrmg.bm', '辽宁省 抚顺市 顺城区', 'https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif', 1, NULL, NULL, NULL, NULL, 1, 0);
INSERT INTO `t_user` VALUES (32, 'hrf', '$2a$10$B1sPu9mkIjySfTpaLJPuT.fK.v.ajOdBbAEjd0cqA2uF21ggc6TsO', 1, 1, 1, 1, '阎娜', '龙取流维', 11, 1, '13575796278', 'j.euwgeb@bivmd.ir', '上海 上海市 闸北区', 'https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif', 1, NULL, NULL, NULL, NULL, 1, 0);
INSERT INTO `t_user` VALUES (33, 'jlnp', '$2a$10$B1sPu9mkIjySfTpaLJPuT.fK.v.ajOdBbAEjd0cqA2uF21ggc6TsO', 1, 1, 1, 1, '丁杰', '很总细', 114, 0, '13547683648', 's.qqnjgrdkr@unhnsz.sb', '江苏省 连云港市 东海县', 'https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif', 1, NULL, NULL, NULL, NULL, 1, 0);
INSERT INTO `t_user` VALUES (34, 'cyx', '$2a$10$B1sPu9mkIjySfTpaLJPuT.fK.v.ajOdBbAEjd0cqA2uF21ggc6TsO', 1, 1, 1, 1, '常勇', '提研人', 14, 0, '13562212652', 'f.wwqrwmv@cvasdi.mil', '湖北省 黄冈市 蕲春县', 'https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif', 1, NULL, NULL, NULL, NULL, 1, 0);
INSERT INTO `t_user` VALUES (35, 'dzii', '$2a$10$B1sPu9mkIjySfTpaLJPuT.fK.v.ajOdBbAEjd0cqA2uF21ggc6TsO', 1, 1, 1, 1, '孔桂英', '王种水', 65, 1, '13273619661', 'i.fblvfhuhcq@rlizeinb.ly', '山东省 滨州市 邹平县', 'https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif', 1, NULL, NULL, NULL, NULL, 1, 0);
INSERT INTO `t_user` VALUES (36, 'ahy', '$2a$10$B1sPu9mkIjySfTpaLJPuT.fK.v.ajOdBbAEjd0cqA2uF21ggc6TsO', 1, 1, 1, 1, '高明', '全六头', 95, 1, '13543982584', 'r.jpjfyqdn@xurcps.az', '湖南省 永州市 零陵区', 'https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif', 1, NULL, NULL, NULL, NULL, 1, 0);
INSERT INTO `t_user` VALUES (37, 'mjpo', '$2a$10$B1sPu9mkIjySfTpaLJPuT.fK.v.ajOdBbAEjd0cqA2uF21ggc6TsO', 1, 1, 1, 1, '郑强', '八我总', 116, 1, '18978825600', 'n.zcyxcmvrsv@slodrpec.pf', '四川省 广元市 青川县', 'https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif', 1, NULL, NULL, NULL, NULL, 1, 0);
INSERT INTO `t_user` VALUES (38, 'wsli', '$2a$10$B1sPu9mkIjySfTpaLJPuT.fK.v.ajOdBbAEjd0cqA2uF21ggc6TsO', 1, 1, 1, 1, '冯芳', '是有其写', 14, 0, '13598680473', 'g.knxnp@infbr.biz', '广西壮族自治区 贺州市 平桂管理区', 'https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif', 1, NULL, NULL, NULL, NULL, 1, 0);
INSERT INTO `t_user` VALUES (39, 'djr', '$2a$10$B1sPu9mkIjySfTpaLJPuT.fK.v.ajOdBbAEjd0cqA2uF21ggc6TsO', 1, 1, 1, 1, '郝秀英', '五号七变', 27, 1, '13511462374', 'k.zjhhr@wzbe.pe', '湖北省 黄冈市 罗田县', 'https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif', 1, NULL, NULL, NULL, NULL, 1, 0);
INSERT INTO `t_user` VALUES (40, 'tot', '$2a$10$B1sPu9mkIjySfTpaLJPuT.fK.v.ajOdBbAEjd0cqA2uF21ggc6TsO', 1, 1, 1, 1, '冯洋', '大三往', 63, 1, '13235814023', 'd.fkffsq@yzvvwsgbex.pt', '福建省 宁德市 寿宁县', 'https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif', 1, NULL, NULL, NULL, NULL, 1, 0);
INSERT INTO `t_user` VALUES (41, 'yhci', '$2a$10$B1sPu9mkIjySfTpaLJPuT.fK.v.ajOdBbAEjd0cqA2uF21ggc6TsO', 1, 1, 1, 1, '马勇', '意研看书', 36, 1, '13284841368', 'o.tnuo@ddgwjgsyji.dm', '陕西省 延安市 子长县', 'https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif', 1, NULL, NULL, NULL, NULL, 1, 0);
INSERT INTO `t_user` VALUES (42, 'frfw', '$2a$10$B1sPu9mkIjySfTpaLJPuT.fK.v.ajOdBbAEjd0cqA2uF21ggc6TsO', 1, 1, 1, 1, '高明', '来里由下', 112, 0, '18944134436', 'v.aihw@obcvejp.mil', '江西省 萍乡市 上栗县', 'https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif', 1, NULL, NULL, NULL, NULL, 1, 0);
INSERT INTO `t_user` VALUES (43, 'qswp', '$2a$10$B1sPu9mkIjySfTpaLJPuT.fK.v.ajOdBbAEjd0cqA2uF21ggc6TsO', 1, 1, 1, 1, '田军', '如住该线', 15, 0, '13285435201', 'i.cwtx@gnmytulk.mv', '青海省 西宁市 城西区', 'https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif', 1, NULL, NULL, NULL, NULL, 1, 0);
INSERT INTO `t_user` VALUES (44, 'rmb', '$2a$10$B1sPu9mkIjySfTpaLJPuT.fK.v.ajOdBbAEjd0cqA2uF21ggc6TsO', 1, 1, 1, 1, '陈芳', '备响将', 51, 1, '13211249337', 'y.ryookc@zbyiowvd.io', '山西省 晋中市 昔阳县', 'https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif', 1, NULL, NULL, NULL, NULL, 1, 0);
INSERT INTO `t_user` VALUES (45, 'lry', '$2a$10$B1sPu9mkIjySfTpaLJPuT.fK.v.ajOdBbAEjd0cqA2uF21ggc6TsO', 1, 1, 1, 1, '秦杰', '资记重', 114, 0, '13266093180', 'o.fddi@nsshltw.jo', '云南省 昭通市 巧家县', 'https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif', 1, NULL, NULL, NULL, NULL, 1, 0);
INSERT INTO `t_user` VALUES (46, 'oap', '$2a$10$B1sPu9mkIjySfTpaLJPuT.fK.v.ajOdBbAEjd0cqA2uF21ggc6TsO', 1, 1, 1, 1, '金娟', '合部段它', 56, 1, '13570054741', 'g.upxbrtexc@creue.nl', '陕西省 宝鸡市 金台区', 'https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif', 1, NULL, NULL, NULL, NULL, 1, 0);
INSERT INTO `t_user` VALUES (47, 'xhei', '$2a$10$B1sPu9mkIjySfTpaLJPuT.fK.v.ajOdBbAEjd0cqA2uF21ggc6TsO', 1, 1, 1, 1, '蒋芳', '手产里我', 17, 1, '13565306895', 'r.gxkjryvvk@btvk.net.cn', '江苏省 宿迁市 沭阳县', 'https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif', 1, NULL, NULL, NULL, NULL, 1, 0);
INSERT INTO `t_user` VALUES (48, 'ltpb', '$2a$10$B1sPu9mkIjySfTpaLJPuT.fK.v.ajOdBbAEjd0cqA2uF21ggc6TsO', 1, 1, 1, 1, '任涛', '保争求', 18, 0, '13517785737', 'x.fvpxfl@vsdnxbivx.lc', '台湾 彰化县 秀水乡', 'https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif', 1, NULL, NULL, NULL, NULL, 1, 0);
INSERT INTO `t_user` VALUES (49, 'dzyi', '$2a$10$B1sPu9mkIjySfTpaLJPuT.fK.v.ajOdBbAEjd0cqA2uF21ggc6TsO', 1, 1, 1, 1, '林杰', '感济为', 46, 0, '13551535866', 'z.rlvchrsnjn@polokliol.aw', '天津 天津市 西青区', 'https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif', 1, NULL, NULL, NULL, NULL, 1, 0);
INSERT INTO `t_user` VALUES (50, 'qmb', '$2a$10$B1sPu9mkIjySfTpaLJPuT.fK.v.ajOdBbAEjd0cqA2uF21ggc6TsO', 1, 1, 1, 1, '尹霞', '可代运', 35, 0, '13277853410', 'j.vexx@punvk.ph', '福建省 龙岩市 连城县', 'https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif', 1, NULL, NULL, NULL, NULL, 1, 0);
INSERT INTO `t_user` VALUES (51, 'pnrk', '$2a$10$B1sPu9mkIjySfTpaLJPuT.fK.v.ajOdBbAEjd0cqA2uF21ggc6TsO', 1, 1, 1, 1, '钱磊', '区族北', 9, 0, '13241886355', 'm.fgmywxzt@urfbcf.us', '浙江省 绍兴市 嵊州市', 'https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif', 1, NULL, NULL, NULL, NULL, 1, 0);
INSERT INTO `t_user` VALUES (52, 'dxl', '$2a$10$B1sPu9mkIjySfTpaLJPuT.fK.v.ajOdBbAEjd0cqA2uF21ggc6TsO', 1, 1, 1, 1, '金超', '技验积', 36, 1, '13562644545', 'v.cgmvt@bnbzcn.re', '贵州省 黔西南布依族苗族自治州 普安县', 'https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif', 1, NULL, NULL, NULL, NULL, 1, 0);
INSERT INTO `t_user` VALUES (53, 'pvjs', '$2a$10$B1sPu9mkIjySfTpaLJPuT.fK.v.ajOdBbAEjd0cqA2uF21ggc6TsO', 1, 1, 1, 1, '杜静', '劳意工生', 13, 1, '13544603508', 'o.urxzbxaa@lwjenhx.lr', '西藏自治区 日喀则地区 仁布县', 'https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif', 1, NULL, NULL, NULL, NULL, 1, 0);
INSERT INTO `t_user` VALUES (54, 'wmel', '$2a$10$B1sPu9mkIjySfTpaLJPuT.fK.v.ajOdBbAEjd0cqA2uF21ggc6TsO', 1, 1, 1, 1, '余娜', '学无路', 54, 0, '13223461174', 'n.ebmlxqmpc@eoufqns.pk', '广东省 汕尾市 陆丰市', 'https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif', 1, NULL, NULL, NULL, NULL, 1, 0);
INSERT INTO `t_user` VALUES (55, 'bdxg', '$2a$10$B1sPu9mkIjySfTpaLJPuT.fK.v.ajOdBbAEjd0cqA2uF21ggc6TsO', 1, 1, 1, 1, '锺明', '育料真', 107, 0, '18927653117', 'n.otez@hvntjqeq.af', '天津 天津市 北辰区', 'https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif', 1, NULL, NULL, NULL, NULL, 1, 0);
INSERT INTO `t_user` VALUES (56, 'kco', '$2a$10$B1sPu9mkIjySfTpaLJPuT.fK.v.ajOdBbAEjd0cqA2uF21ggc6TsO', 1, 1, 1, 1, '蔡丽', '半她有展', 84, 0, '13551333151', 'n.segsvqhw@hqtjpwvdd.tv', '重庆 重庆市 九龙坡区', 'https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif', 1, NULL, NULL, NULL, NULL, 1, 0);
INSERT INTO `t_user` VALUES (57, 'lgvk', '$2a$10$B1sPu9mkIjySfTpaLJPuT.fK.v.ajOdBbAEjd0cqA2uF21ggc6TsO', 1, 1, 1, 1, '吴勇', '三实要', 4, 0, '13561544326', 'w.uvhb@mte.pro', '陕西省 商洛市 柞水县', 'https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif', 1, NULL, NULL, NULL, NULL, 1, 0);
INSERT INTO `t_user` VALUES (58, 'zsss', '$2a$10$B1sPu9mkIjySfTpaLJPuT.fK.v.ajOdBbAEjd0cqA2uF21ggc6TsO', 1, 1, 1, 1, '秦秀兰', '把到声', 60, 1, '13524536628', 'b.pudetibb@ifcnsb.ni', '山西省 临汾市 乡宁县', 'https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif', 1, NULL, NULL, NULL, NULL, 1, 0);
INSERT INTO `t_user` VALUES (59, 'wiy', '$2a$10$B1sPu9mkIjySfTpaLJPuT.fK.v.ajOdBbAEjd0cqA2uF21ggc6TsO', 1, 1, 1, 1, '钱娜', '收置育', 102, 1, '13257364727', 'r.ldda@ihcr.de', '台湾 南投县 草屯镇', 'https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif', 1, NULL, NULL, NULL, NULL, 1, 0);
INSERT INTO `t_user` VALUES (60, 'onbu', '$2a$10$B1sPu9mkIjySfTpaLJPuT.fK.v.ajOdBbAEjd0cqA2uF21ggc6TsO', 1, 1, 1, 1, '冯艳', '各色每', 116, 1, '13511932286', 'i.dyevsoj@ibeylkudh.pe', '广西壮族自治区 北海市 合浦县', 'https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif', 1, NULL, NULL, NULL, NULL, 1, 0);
INSERT INTO `t_user` VALUES (61, 'sdy', '$2a$10$B1sPu9mkIjySfTpaLJPuT.fK.v.ajOdBbAEjd0cqA2uF21ggc6TsO', 1, 1, 1, 1, '唐秀英', '党克圆', 44, 1, '13528612466', 'f.syrlqf@xfpfuxl.kz', '辽宁省 抚顺市 新宾满族自治县', 'https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif', 1, NULL, NULL, NULL, NULL, 1, 0);
INSERT INTO `t_user` VALUES (62, 'bow', '$2a$10$B1sPu9mkIjySfTpaLJPuT.fK.v.ajOdBbAEjd0cqA2uF21ggc6TsO', 1, 1, 1, 1, '孙伟', '新面次', 118, 0, '13591844113', 'g.toyyoc@sbggk.gt', '辽宁省 本溪市 明山区', 'https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif', 1, NULL, NULL, NULL, NULL, 1, 0);
INSERT INTO `t_user` VALUES (63, 'hnf', '$2a$10$B1sPu9mkIjySfTpaLJPuT.fK.v.ajOdBbAEjd0cqA2uF21ggc6TsO', 1, 1, 1, 1, '任军', '毛史千', 115, 1, '13587675831', 'i.ouohuqr@wjgsf.cm', '内蒙古自治区 乌海市 海勃湾区', 'https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif', 1, NULL, NULL, NULL, NULL, 1, 0);
INSERT INTO `t_user` VALUES (64, 'tsr', '$2a$10$B1sPu9mkIjySfTpaLJPuT.fK.v.ajOdBbAEjd0cqA2uF21ggc6TsO', 1, 1, 1, 1, '邓秀兰', '适被需按', 96, 0, '18956541176', 't.fvyam@vcf.re', '广西壮族自治区 贺州市 平桂管理区', 'https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif', 1, NULL, NULL, NULL, NULL, 1, 0);
INSERT INTO `t_user` VALUES (65, 'xkcs', '$2a$10$B1sPu9mkIjySfTpaLJPuT.fK.v.ajOdBbAEjd0cqA2uF21ggc6TsO', 1, 1, 1, 1, '萧丽', '眼形近', 87, 0, '18927114569', 'i.wkwwmb@ujbdjb.tf', '台湾 新北市 树林区', 'https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif', 1, NULL, NULL, NULL, NULL, 1, 0);
INSERT INTO `t_user` VALUES (66, 'all', '$2a$10$B1sPu9mkIjySfTpaLJPuT.fK.v.ajOdBbAEjd0cqA2uF21ggc6TsO', 1, 1, 1, 1, '杜静', '此平门体', 115, 0, '13577323551', 'f.bffc@twep.my', '山东省 莱芜市 钢城区', 'https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif', 1, NULL, NULL, NULL, NULL, 1, 0);
INSERT INTO `t_user` VALUES (67, 'isq', '$2a$10$B1sPu9mkIjySfTpaLJPuT.fK.v.ajOdBbAEjd0cqA2uF21ggc6TsO', 1, 1, 1, 1, '崔娜', '和群起', 2, 1, '13583300372', 'a.jbxgtbo@xvsjj.tf', '黑龙江省 哈尔滨市 通河县', 'https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif', 1, NULL, NULL, NULL, NULL, 1, 0);
INSERT INTO `t_user` VALUES (68, 'iko', '$2a$10$B1sPu9mkIjySfTpaLJPuT.fK.v.ajOdBbAEjd0cqA2uF21ggc6TsO', 1, 1, 1, 1, '黄杰', '精几收结', 66, 0, '13568636906', 'z.xrfjeyl@lnlh.kw', '青海省 海西蒙古族藏族自治州 都兰县', 'https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif', 1, NULL, NULL, NULL, NULL, 1, 0);
INSERT INTO `t_user` VALUES (69, 'kkeq', '$2a$10$B1sPu9mkIjySfTpaLJPuT.fK.v.ajOdBbAEjd0cqA2uF21ggc6TsO', 1, 1, 1, 1, '唐秀兰', '广置个', 84, 1, '13534001557', 'h.nihwvlan@mbrthra.nz', '湖北省 咸宁市 赤壁市', 'https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif', 1, NULL, NULL, NULL, NULL, 1, 0);
INSERT INTO `t_user` VALUES (70, 'myom', '$2a$10$B1sPu9mkIjySfTpaLJPuT.fK.v.ajOdBbAEjd0cqA2uF21ggc6TsO', 1, 1, 1, 1, '赵平', '月北且', 81, 0, '13550723295', 'h.fferp@usdjhnghnm.tr', '山西省 临汾市 古县', 'https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif', 1, NULL, NULL, NULL, NULL, 1, 0);
INSERT INTO `t_user` VALUES (71, 'dtqt', '$2a$10$B1sPu9mkIjySfTpaLJPuT.fK.v.ajOdBbAEjd0cqA2uF21ggc6TsO', 1, 1, 1, 1, '邱娟', '克段具', 47, 0, '13591240083', 'h.wjiumeohn@yor.ls', '四川省 内江市 隆昌县', 'https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif', 1, NULL, NULL, NULL, NULL, 1, 0);
INSERT INTO `t_user` VALUES (72, 'sha', '$2a$10$B1sPu9mkIjySfTpaLJPuT.fK.v.ajOdBbAEjd0cqA2uF21ggc6TsO', 1, 1, 1, 1, '熊平', '原约都', 52, 1, '13558954542', 'n.yftw@cddclcd.re', '云南省 昭通市 盐津县', 'https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif', 1, NULL, NULL, NULL, NULL, 1, 0);
INSERT INTO `t_user` VALUES (73, 'yfz', '$2a$10$B1sPu9mkIjySfTpaLJPuT.fK.v.ajOdBbAEjd0cqA2uF21ggc6TsO', 1, 1, 1, 1, '秦平', '能数且局', 17, 0, '18949652262', 'n.xnrhqine@labjb.mv', '山东省 日照市 莒县', 'https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif', 1, NULL, NULL, NULL, NULL, 1, 0);
INSERT INTO `t_user` VALUES (74, 'xdk', '$2a$10$B1sPu9mkIjySfTpaLJPuT.fK.v.ajOdBbAEjd0cqA2uF21ggc6TsO', 1, 1, 1, 1, '陈平', '明场规', 68, 1, '18938558846', 'k.dvoemscof@arnmuxor.vn', '山西省 忻州市 河曲县', 'https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif', 1, NULL, NULL, NULL, NULL, 1, 0);
INSERT INTO `t_user` VALUES (75, 'hqp', '$2a$10$B1sPu9mkIjySfTpaLJPuT.fK.v.ajOdBbAEjd0cqA2uF21ggc6TsO', 1, 1, 1, 1, '邱平', '联很便', 5, 1, '13283342942', 'b.sdgbgu@hlzvhf.wf', '湖北省 黄石市 大冶市', 'https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif', 1, NULL, NULL, NULL, NULL, 1, 0);
INSERT INTO `t_user` VALUES (76, 'owgq', '$2a$10$B1sPu9mkIjySfTpaLJPuT.fK.v.ajOdBbAEjd0cqA2uF21ggc6TsO', 1, 1, 1, 1, '秦秀兰', '正使任式', 4, 1, '13549468838', 'j.tfqps@extilbwt.sr', '山东省 莱芜市 钢城区', 'https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif', 1, NULL, NULL, NULL, NULL, 1, 0);
INSERT INTO `t_user` VALUES (77, 'vbum', '$2a$10$B1sPu9mkIjySfTpaLJPuT.fK.v.ajOdBbAEjd0cqA2uF21ggc6TsO', 1, 1, 1, 1, '贾艳', '很况得', 0, 0, '18991748427', 'h.mofufvt@kqgvjpafb.co', '西藏自治区 日喀则地区 拉孜县', 'https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif', 1, NULL, NULL, NULL, NULL, 1, 0);
INSERT INTO `t_user` VALUES (78, 'wgs', '$2a$10$B1sPu9mkIjySfTpaLJPuT.fK.v.ajOdBbAEjd0cqA2uF21ggc6TsO', 1, 1, 1, 1, '张娟', '子形无', 33, 0, '13237316861', 'k.dsnnenhxqt@rjygmjhcd.ki', '江苏省 南通市 通州区', 'https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif', 1, NULL, NULL, NULL, NULL, 1, 0);
INSERT INTO `t_user` VALUES (79, 'ufr', '$2a$10$B1sPu9mkIjySfTpaLJPuT.fK.v.ajOdBbAEjd0cqA2uF21ggc6TsO', 1, 1, 1, 1, '蔡涛', '局较织低', 103, 1, '13570813835', 'z.xkxnrtpek@diys.bb', '湖北省 黄冈市 黄梅县', 'https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif', 1, NULL, NULL, NULL, NULL, 1, 0);
INSERT INTO `t_user` VALUES (80, 'mfd', '$2a$10$B1sPu9mkIjySfTpaLJPuT.fK.v.ajOdBbAEjd0cqA2uF21ggc6TsO', 1, 1, 1, 1, '江杰', '千须称', 91, 1, '13552333584', 'l.weqr@eiwggnw.sk', '内蒙古自治区 通辽市 库伦旗', 'https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif', 1, NULL, NULL, NULL, NULL, 1, 0);
INSERT INTO `t_user` VALUES (81, 'whfh', '$2a$10$B1sPu9mkIjySfTpaLJPuT.fK.v.ajOdBbAEjd0cqA2uF21ggc6TsO', 1, 1, 1, 1, '徐丽', '农要别事', 21, 1, '13542256461', 'v.yduwkrci@mdsihfx.ee', '重庆 重庆市 江北区', 'https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif', 1, NULL, NULL, NULL, NULL, 1, 0);
INSERT INTO `t_user` VALUES (82, 'cmyd', '$2a$10$B1sPu9mkIjySfTpaLJPuT.fK.v.ajOdBbAEjd0cqA2uF21ggc6TsO', 1, 1, 1, 1, '刘刚', '据他命种', 6, 0, '13503550765', 'w.mdnmez@llvci.sc', '河南省 新乡市 辉县市', 'https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif', 1, NULL, NULL, NULL, NULL, 1, 0);
INSERT INTO `t_user` VALUES (83, 'gbbr', '$2a$10$B1sPu9mkIjySfTpaLJPuT.fK.v.ajOdBbAEjd0cqA2uF21ggc6TsO', 1, 1, 1, 1, '文涛', '发常例', 48, 0, '13575923157', 'l.hqxflfkjq@trma.sz', '河南省 信阳市 潢川县', 'https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif', 1, NULL, NULL, NULL, NULL, 1, 0);
INSERT INTO `t_user` VALUES (84, 'vyf', '$2a$10$B1sPu9mkIjySfTpaLJPuT.fK.v.ajOdBbAEjd0cqA2uF21ggc6TsO', 1, 1, 1, 1, '戴涛', '速容商验', 34, 0, '18943839817', 'f.mlxuskkx@fwm.lb', '安徽省 滁州市 来安县', 'https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif', 1, NULL, NULL, NULL, NULL, 1, 0);
INSERT INTO `t_user` VALUES (85, 'utq', '$2a$10$B1sPu9mkIjySfTpaLJPuT.fK.v.ajOdBbAEjd0cqA2uF21ggc6TsO', 1, 1, 1, 1, '许磊', '想里小', 117, 0, '13538422207', 'e.tepjnp@okca.bf', '安徽省 滁州市 凤阳县', 'https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif', 1, NULL, NULL, NULL, NULL, 1, 0);
INSERT INTO `t_user` VALUES (86, 'khbb', '$2a$10$B1sPu9mkIjySfTpaLJPuT.fK.v.ajOdBbAEjd0cqA2uF21ggc6TsO', 1, 1, 1, 1, '赵桂英', '确构打民', 15, 0, '13543412971', 'v.jevldchzx@dguhcefz.st', '云南省 西双版纳傣族自治州 勐海县', 'https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif', 1, NULL, NULL, NULL, NULL, 1, 0);
INSERT INTO `t_user` VALUES (87, 'noul', '$2a$10$B1sPu9mkIjySfTpaLJPuT.fK.v.ajOdBbAEjd0cqA2uF21ggc6TsO', 1, 1, 1, 1, '潘娟', '状转器行', 54, 0, '13553153716', 'o.kbwbnh@flrhpch.nl', '台湾 澎湖县 七美乡', 'https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif', 1, NULL, NULL, NULL, NULL, 1, 0);
INSERT INTO `t_user` VALUES (88, 'qzon', '$2a$10$B1sPu9mkIjySfTpaLJPuT.fK.v.ajOdBbAEjd0cqA2uF21ggc6TsO', 1, 1, 1, 1, '陆涛', '你传声管', 41, 0, '13522438761', 'p.hezqbqpv@pnmiwg.vg', '湖南省 湘潭市 其它区', 'https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif', 1, NULL, NULL, NULL, NULL, 1, 0);
INSERT INTO `t_user` VALUES (89, 'okjp', '$2a$10$B1sPu9mkIjySfTpaLJPuT.fK.v.ajOdBbAEjd0cqA2uF21ggc6TsO', 1, 1, 1, 1, '汪勇', '无少育', 90, 0, '13241844347', 'o.ucjmmlorh@wwjtgpyd.kg', '内蒙古自治区 呼伦贝尔市 新巴尔虎左旗', 'https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif', 1, NULL, NULL, NULL, NULL, 1, 0);
INSERT INTO `t_user` VALUES (90, 'xdh', '$2a$10$B1sPu9mkIjySfTpaLJPuT.fK.v.ajOdBbAEjd0cqA2uF21ggc6TsO', 1, 1, 1, 1, '贺丽', '照增命', 115, 1, '13528435356', 'n.ymhivvg@esci.kz', '黑龙江省 七台河市 茄子河区', 'https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif', 1, NULL, NULL, NULL, NULL, 1, 0);
INSERT INTO `t_user` VALUES (91, 'lhxo', '$2a$10$B1sPu9mkIjySfTpaLJPuT.fK.v.ajOdBbAEjd0cqA2uF21ggc6TsO', 1, 1, 1, 1, '徐丽', '确出育界', 76, 1, '18967475640', 'g.rejjf@bxjktdtrm.sb', '安徽省 黄山市 休宁县', 'https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif', 1, NULL, NULL, NULL, NULL, 1, 0);
INSERT INTO `t_user` VALUES (92, 'ufsq', '$2a$10$B1sPu9mkIjySfTpaLJPuT.fK.v.ajOdBbAEjd0cqA2uF21ggc6TsO', 1, 1, 1, 1, '汪敏', '当火色采', 37, 1, '18950638865', 's.icc@bunrpwl.nl', '天津 天津市 河西区', 'https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif', 1, NULL, NULL, NULL, NULL, 1, 0);
INSERT INTO `t_user` VALUES (93, 'vdop', '$2a$10$B1sPu9mkIjySfTpaLJPuT.fK.v.ajOdBbAEjd0cqA2uF21ggc6TsO', 1, 1, 1, 1, '苏桂英', '想治器', 67, 0, '13522827584', 'h.itvjmjmoyq@lxfe.tc', '甘肃省 临夏回族自治州 广河县', 'https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif', 1, NULL, NULL, NULL, NULL, 1, 0);
INSERT INTO `t_user` VALUES (94, 'krs', '$2a$10$B1sPu9mkIjySfTpaLJPuT.fK.v.ajOdBbAEjd0cqA2uF21ggc6TsO', 1, 1, 1, 1, '于杰', '三发门', 118, 1, '13226486149', 'm.temh@bmgw.pn', '安徽省 安庆市 宿松县', 'https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif', 1, NULL, NULL, NULL, NULL, 1, 0);
INSERT INTO `t_user` VALUES (95, 'eifj', '$2a$10$B1sPu9mkIjySfTpaLJPuT.fK.v.ajOdBbAEjd0cqA2uF21ggc6TsO', 1, 1, 1, 1, '戴明', '儿参便史', 46, 0, '13542396255', 's.ltwnnxkd@ukpxsit.gh', '山西省 太原市 清徐县', 'https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif', 1, NULL, NULL, NULL, NULL, 1, 0);
INSERT INTO `t_user` VALUES (96, 'ktut', '$2a$10$B1sPu9mkIjySfTpaLJPuT.fK.v.ajOdBbAEjd0cqA2uF21ggc6TsO', 1, 1, 1, 1, '萧磊', '治江部书', 76, 0, '13235311464', 'b.vozpkvepi@gafywrm.zr', '内蒙古自治区 鄂尔多斯市 杭锦旗', 'https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif', 1, NULL, NULL, NULL, NULL, 1, 0);
INSERT INTO `t_user` VALUES (97, 'jxe', '$2a$10$B1sPu9mkIjySfTpaLJPuT.fK.v.ajOdBbAEjd0cqA2uF21ggc6TsO', 1, 1, 1, 1, '郭艳', '利位使给', 46, 1, '13287177333', 'a.seacsnur@wru.st', '台湾 连江县 南竿乡', 'https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif', 1, NULL, NULL, NULL, NULL, 1, 0);
INSERT INTO `t_user` VALUES (98, 'pcd', '$2a$10$B1sPu9mkIjySfTpaLJPuT.fK.v.ajOdBbAEjd0cqA2uF21ggc6TsO', 1, 1, 1, 1, '任洋', '克战管些', 79, 0, '13512114648', 'e.feyyfmlfk@cbwhzxqxg.ml', '山东省 莱芜市 钢城区', 'https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif', 1, NULL, NULL, NULL, NULL, 1, 0);
INSERT INTO `t_user` VALUES (99, 'qqq', '$2a$10$B1sPu9mkIjySfTpaLJPuT.fK.v.ajOdBbAEjd0cqA2uF21ggc6TsO', 1, 1, 1, 1, 'qqq', '连领说照', 15, 0, '13544369235', 'l.lxnwo@nzpzxamkxn.gt', '澳门特别行政区 澳门半岛 -', 'https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif', 1, NULL, NULL, NULL, NULL, 1, 0);
INSERT INTO `t_user` VALUES (100, 'qjb', '$2a$10$B1sPu9mkIjySfTpaLJPuT.fK.v.ajOdBbAEjd0cqA2uF21ggc6TsO', 1, 1, 1, 1, '贾杰', '听斯手', 38, 0, '13284431452', 'u.jdioqshv@ipes.bf', '上海 上海市 浦东新区', 'https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif', 1, NULL, NULL, NULL, NULL, 1, 1);

-- ----------------------------
-- Table structure for t_user_dept
-- ----------------------------
DROP TABLE IF EXISTS `t_user_dept`;
CREATE TABLE `t_user_dept`  (
  `user_id` int(0) NOT NULL COMMENT '用户ID',
  `dept_id` int(0) NOT NULL COMMENT '部门ID',
  PRIMARY KEY (`user_id`, `dept_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for t_user_role
-- ----------------------------
DROP TABLE IF EXISTS `t_user_role`;
CREATE TABLE `t_user_role`  (
  `user_id` bigint(0) NOT NULL COMMENT '用户编号',
  `role_id` bigint(0) NOT NULL COMMENT '角色编号',
  INDEX `user_id`(`user_id`) USING BTREE,
  INDEX `role_id`(`role_id`) USING BTREE,
  CONSTRAINT `t_user_role_ibfk_2` FOREIGN KEY (`role_id`) REFERENCES `t_role` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `t_user_role_ibfk_3` FOREIGN KEY (`user_id`) REFERENCES `t_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_user_role
-- ----------------------------
INSERT INTO `t_user_role` VALUES (1, 1);
INSERT INTO `t_user_role` VALUES (2, 2);
INSERT INTO `t_user_role` VALUES (3, 3);
INSERT INTO `t_user_role` VALUES (4, 1);
INSERT INTO `t_user_role` VALUES (5, 2);
INSERT INTO `t_user_role` VALUES (6, 2);
INSERT INTO `t_user_role` VALUES (7, 2);
INSERT INTO `t_user_role` VALUES (8, 2);
INSERT INTO `t_user_role` VALUES (9, 2);
INSERT INTO `t_user_role` VALUES (10, 2);
INSERT INTO `t_user_role` VALUES (11, 2);
INSERT INTO `t_user_role` VALUES (12, 2);
INSERT INTO `t_user_role` VALUES (13, 2);
INSERT INTO `t_user_role` VALUES (14, 2);
INSERT INTO `t_user_role` VALUES (15, 3);
INSERT INTO `t_user_role` VALUES (16, 3);
INSERT INTO `t_user_role` VALUES (17, 2);
INSERT INTO `t_user_role` VALUES (18, 2);
INSERT INTO `t_user_role` VALUES (19, 2);
INSERT INTO `t_user_role` VALUES (20, 2);
INSERT INTO `t_user_role` VALUES (21, 2);
INSERT INTO `t_user_role` VALUES (22, 2);
INSERT INTO `t_user_role` VALUES (23, 2);
INSERT INTO `t_user_role` VALUES (24, 2);
INSERT INTO `t_user_role` VALUES (25, 2);
INSERT INTO `t_user_role` VALUES (26, 1);
INSERT INTO `t_user_role` VALUES (27, 3);
INSERT INTO `t_user_role` VALUES (28, 2);
INSERT INTO `t_user_role` VALUES (29, 2);
INSERT INTO `t_user_role` VALUES (30, 3);
INSERT INTO `t_user_role` VALUES (31, 2);
INSERT INTO `t_user_role` VALUES (32, 2);
INSERT INTO `t_user_role` VALUES (33, 2);
INSERT INTO `t_user_role` VALUES (34, 2);
INSERT INTO `t_user_role` VALUES (35, 3);
INSERT INTO `t_user_role` VALUES (36, 1);
INSERT INTO `t_user_role` VALUES (37, 1);
INSERT INTO `t_user_role` VALUES (38, 2);
INSERT INTO `t_user_role` VALUES (39, 2);
INSERT INTO `t_user_role` VALUES (40, 3);
INSERT INTO `t_user_role` VALUES (41, 2);
INSERT INTO `t_user_role` VALUES (42, 1);
INSERT INTO `t_user_role` VALUES (43, 1);
INSERT INTO `t_user_role` VALUES (44, 2);
INSERT INTO `t_user_role` VALUES (45, 1);
INSERT INTO `t_user_role` VALUES (46, 3);
INSERT INTO `t_user_role` VALUES (47, 2);
INSERT INTO `t_user_role` VALUES (48, 3);
INSERT INTO `t_user_role` VALUES (49, 2);
INSERT INTO `t_user_role` VALUES (50, 2);
INSERT INTO `t_user_role` VALUES (51, 2);
INSERT INTO `t_user_role` VALUES (52, 3);
INSERT INTO `t_user_role` VALUES (53, 2);
INSERT INTO `t_user_role` VALUES (54, 2);
INSERT INTO `t_user_role` VALUES (55, 1);
INSERT INTO `t_user_role` VALUES (56, 2);
INSERT INTO `t_user_role` VALUES (57, 1);
INSERT INTO `t_user_role` VALUES (58, 2);
INSERT INTO `t_user_role` VALUES (59, 1);
INSERT INTO `t_user_role` VALUES (60, 3);
INSERT INTO `t_user_role` VALUES (61, 2);
INSERT INTO `t_user_role` VALUES (62, 3);
INSERT INTO `t_user_role` VALUES (63, 3);
INSERT INTO `t_user_role` VALUES (64, 3);
INSERT INTO `t_user_role` VALUES (65, 3);
INSERT INTO `t_user_role` VALUES (66, 3);
INSERT INTO `t_user_role` VALUES (67, 3);
INSERT INTO `t_user_role` VALUES (68, 3);
INSERT INTO `t_user_role` VALUES (69, 3);
INSERT INTO `t_user_role` VALUES (70, 3);
INSERT INTO `t_user_role` VALUES (71, 2);
INSERT INTO `t_user_role` VALUES (72, 3);
INSERT INTO `t_user_role` VALUES (73, 2);
INSERT INTO `t_user_role` VALUES (74, 2);
INSERT INTO `t_user_role` VALUES (75, 3);
INSERT INTO `t_user_role` VALUES (76, 3);
INSERT INTO `t_user_role` VALUES (77, 2);
INSERT INTO `t_user_role` VALUES (78, 2);
INSERT INTO `t_user_role` VALUES (79, 1);
INSERT INTO `t_user_role` VALUES (80, 1);
INSERT INTO `t_user_role` VALUES (81, 2);
INSERT INTO `t_user_role` VALUES (82, 2);
INSERT INTO `t_user_role` VALUES (83, 1);
INSERT INTO `t_user_role` VALUES (84, 3);
INSERT INTO `t_user_role` VALUES (85, 2);
INSERT INTO `t_user_role` VALUES (86, 2);
INSERT INTO `t_user_role` VALUES (87, 2);
INSERT INTO `t_user_role` VALUES (88, 1);
INSERT INTO `t_user_role` VALUES (89, 2);
INSERT INTO `t_user_role` VALUES (90, 3);
INSERT INTO `t_user_role` VALUES (91, 2);
INSERT INTO `t_user_role` VALUES (92, 3);
INSERT INTO `t_user_role` VALUES (93, 3);
INSERT INTO `t_user_role` VALUES (94, 2);
INSERT INTO `t_user_role` VALUES (95, 2);
INSERT INTO `t_user_role` VALUES (96, 2);
INSERT INTO `t_user_role` VALUES (97, 2);
INSERT INTO `t_user_role` VALUES (98, 1);
INSERT INTO `t_user_role` VALUES (99, 3);
INSERT INTO `t_user_role` VALUES (100, 2);

-- ----------------------------
-- Table structure for zipkin_annotations
-- ----------------------------
DROP TABLE IF EXISTS `zipkin_annotations`;
CREATE TABLE `zipkin_annotations`  (
  `trace_id_high` bigint(0) NOT NULL DEFAULT 0 COMMENT 'If non zero, this means the trace uses 128 bit traceIds instead of 64 bit',
  `trace_id` bigint(0) NOT NULL COMMENT 'coincides with zipkin_spans.trace_id',
  `span_id` bigint(0) NOT NULL COMMENT 'coincides with zipkin_spans.id',
  `a_key` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'BinaryAnnotation.key or Annotation.value if type == -1',
  `a_value` blob NULL COMMENT 'BinaryAnnotation.value(), which must be smaller than 64KB',
  `a_type` int(0) NOT NULL COMMENT 'BinaryAnnotation.type() or -1 if Annotation',
  `a_timestamp` bigint(0) NULL DEFAULT NULL COMMENT 'Used to implement TTL; Annotation.timestamp or zipkin_spans.timestamp',
  `endpoint_ipv4` int(0) NULL DEFAULT NULL COMMENT 'Null when Binary/Annotation.endpoint is null',
  `endpoint_ipv6` binary(16) NULL DEFAULT NULL COMMENT 'Null when Binary/Annotation.endpoint is null, or no IPv6 address',
  `endpoint_port` smallint(0) NULL DEFAULT NULL COMMENT 'Null when Binary/Annotation.endpoint is null',
  `endpoint_service_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'Null when Binary/Annotation.endpoint is null',
  UNIQUE INDEX `trace_id_high`(`trace_id_high`, `trace_id`, `span_id`, `a_key`, `a_timestamp`) USING BTREE COMMENT 'Ignore insert on duplicate',
  INDEX `trace_id_high_2`(`trace_id_high`, `trace_id`, `span_id`) USING BTREE COMMENT 'for joining with zipkin_spans',
  INDEX `trace_id_high_3`(`trace_id_high`, `trace_id`) USING BTREE COMMENT 'for getTraces/ByIds',
  INDEX `endpoint_service_name`(`endpoint_service_name`) USING BTREE COMMENT 'for getTraces and getServiceNames',
  INDEX `a_type`(`a_type`) USING BTREE COMMENT 'for getTraces and autocomplete values',
  INDEX `a_key`(`a_key`) USING BTREE COMMENT 'for getTraces and autocomplete values',
  INDEX `trace_id`(`trace_id`, `span_id`, `a_key`) USING BTREE COMMENT 'for dependencies job'
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compressed;

-- ----------------------------
-- Table structure for zipkin_dependencies
-- ----------------------------
DROP TABLE IF EXISTS `zipkin_dependencies`;
CREATE TABLE `zipkin_dependencies`  (
  `day` date NOT NULL,
  `parent` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `child` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `call_count` bigint(0) NULL DEFAULT NULL,
  `error_count` bigint(0) NULL DEFAULT NULL,
  PRIMARY KEY (`day`, `parent`, `child`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compressed;

-- ----------------------------
-- Table structure for zipkin_spans
-- ----------------------------
DROP TABLE IF EXISTS `zipkin_spans`;
CREATE TABLE `zipkin_spans`  (
  `trace_id_high` bigint(0) NOT NULL DEFAULT 0 COMMENT 'If non zero, this means the trace uses 128 bit traceIds instead of 64 bit',
  `trace_id` bigint(0) NOT NULL,
  `id` bigint(0) NOT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `remote_service_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `parent_id` bigint(0) NULL DEFAULT NULL,
  `debug` bit(1) NULL DEFAULT NULL,
  `start_ts` bigint(0) NULL DEFAULT NULL COMMENT 'Span.timestamp(): epoch micros used for endTs query and to implement TTL',
  `duration` bigint(0) NULL DEFAULT NULL COMMENT 'Span.duration(): micros used for minDuration and maxDuration query',
  PRIMARY KEY (`trace_id_high`, `trace_id`, `id`) USING BTREE,
  INDEX `trace_id_high`(`trace_id_high`, `trace_id`) USING BTREE COMMENT 'for getTracesByIds',
  INDEX `name`(`name`) USING BTREE COMMENT 'for getTraces and getSpanNames',
  INDEX `remote_service_name`(`remote_service_name`) USING BTREE COMMENT 'for getTraces and getRemoteServiceNames',
  INDEX `start_ts`(`start_ts`) USING BTREE COMMENT 'for getTraces ordering and range'
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compressed;

SET FOREIGN_KEY_CHECKS = 1;
