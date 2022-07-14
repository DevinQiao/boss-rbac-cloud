/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 80023
 Source Host           : localhost:3306
 Source Schema         : boss_nacos

 Target Server Type    : MySQL
 Target Server Version : 80023
 File Encoding         : 65001

 Date: 14/07/2022 23:53:02
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for config_info
-- ----------------------------
DROP TABLE IF EXISTS `config_info`;
CREATE TABLE `config_info`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `data_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'data_id',
  `group_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `content` longtext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'content',
  `md5` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'md5',
  `gmt_create` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `gmt_modified` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '修改时间',
  `src_user` text CHARACTER SET utf8 COLLATE utf8_bin NULL COMMENT 'source user',
  `src_ip` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'source ip',
  `app_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `tenant_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '租户字段',
  `c_desc` varchar(256) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `c_use` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `effect` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `type` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `c_schema` text CHARACTER SET utf8 COLLATE utf8_bin NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_configinfo_datagrouptenant`(`data_id`, `group_id`, `tenant_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = 'config_info' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of config_info
-- ----------------------------
INSERT INTO `config_info` VALUES (1, 'boss-auth.yaml', 'DEFAULT_GROUP', 'server:\n  port: 9270\n\nspring:\n  redis:\n    database: 0\n    host: ${redis.url}\n    port: 6379\n    lettuce:\n      pool:\n        min-idle: 8\n        max-idle: 500\n        max-active: 2000\n        max-wait: 10000\n    timeout: 5000\n  datasource:\n    dynamic:\n      hikari:\n        connection-timeout: 30000\n        max-lifetime: 1800000\n        max-pool-size: 15\n        min-idle: 5\n        connection-test-query: select 1\n        pool-name: BossHikariCP\n      primary: base\n      datasource:\n        base:\n          username: root\n          password: 16250\n          driver-class-name: com.mysql.cj.jdbc.Driver\n          url: jdbc:mysql://${mysql.url}:3306/boss_rbac?useUnicode=true&characterEncoding=UTF-8&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=GMT%2b8\n  boot:\n    admin:\n      client:\n        url: http://${boss-monitor-admin}:9470\n        username: boss\n        password: 16250\n\nmybatis-plus:\n  type-aliases-package: com.boss.common.entity.po\n  mapper-locations: classpath:mapper/*.xml\n  configuration:\n    jdbc-type-for-null: null\n  global-config:\n    banner: false\n\ninfo:\n  app:\n    name: ${spring.application.name}\n    description: \"@project.description@\"\n    version: \"@project.version@\"\n\nmanagement:\n  endpoints:\n    web:\n      exposure:\n        include: \"*\"\n  endpoint:\n    health:\n      show-details: always\n\nlogstash:\n    destination: ${logstash.url}:4560', '3a9f6c3ec687cc8c19924afb933ae55c', '2022-07-13 02:35:26', '2022-07-14 07:48:14', 'nacos', '192.168.0.105', '', '', 'Boss-Auth微服务配置', '', '', 'yaml', '');
INSERT INTO `config_info` VALUES (2, 'boss-gateway.yaml', 'DEFAULT_GROUP', 'server:\r\n  port: 9370\r\n\r\nspring:\r\n  boot:\r\n    admin:\r\n      client:\r\n        url: http://${boss-monitor-admin}:9470\r\n        username: boss\r\n        password: 16250\r\n  cloud:\r\n    gateway:\r\n      routes:\r\n        - id: Boss-Auth\r\n          uri: lb://Boss-Auth\r\n          predicates:\r\n            - Path=/auth/**\r\n          filters:\r\n            - name: Hystrix\r\n              args:\r\n                name: authfallback\r\n                fallbackUri: forward:/fallback/Boss-Auth\r\n        - id: Boss-Server-System\r\n          uri: lb://Boss-Server-System\r\n          predicates:\r\n            - Path=/system/**\r\n          filters:\r\n              - name: Hystrix\r\n                args:\r\n                  name: systemfallback\r\n                  fallbackUri: forward:/fallback/Boss-Server-System\r\n        - id: Boss-Server-Test\r\n          uri: lb://Boss-Server-Test\r\n          predicates:\r\n            - Path=/test/**\r\n          filters:\r\n              - name: Hystrix\r\n                args:\r\n                  name: testfallback\r\n                  fallbackUri: forward:/fallback/Boss-Server-Test\r\n      default-filters:\r\n        - StripPrefix=1\r\n\r\nmanagement:\r\n  endpoint:\r\n    health:\r\n      show-details: always\r\n  endpoints:\r\n    web:\r\n      exposure:\r\n        include: health,info,gateway\r\n\r\nhystrix:\r\n  command:\r\n    default:\r\n      execution:\r\n        isolation:\r\n          thread:\r\n            timeoutInMilliseconds: 3000', 'cb27f9fe4878c92309b3d66acf3735fc', '2022-07-13 02:45:40', '2022-07-13 02:45:40', 'nacos', '192.168.0.105', '', '', 'Boss-Gateway微服务配置', NULL, NULL, 'yaml', NULL);
INSERT INTO `config_info` VALUES (4, 'boss-monitor-admin.yaml', 'DEFAULT_GROUP', 'server:\r\n  port: 9470\r\n\r\n\r\nspring:\r\n  boot:\r\n    admin:\r\n      ui:\r\n        title: ${spring.application.name}\r\n  security:\r\n    user:\r\n      name: boss\r\n      password: 16250', 'a42d2b49496e6b304fc678729f18b4b5', '2022-07-13 02:49:35', '2022-07-13 02:49:35', 'nacos', '192.168.0.105', '', '', 'Boss-Monitor-Admin微服务配置', NULL, NULL, 'yaml', NULL);
INSERT INTO `config_info` VALUES (5, 'boss-server-system.yaml', 'DEFAULT_GROUP', 'server:\r\n  port: 9170\r\n\r\nspring:\r\n  datasource:\r\n    dynamic:\r\n      hikari:\r\n        connection-timeout: 30000\r\n        max-lifetime: 1800000\r\n        max-pool-size: 15\r\n        min-idle: 5\r\n        connection-test-query: select 1\r\n        pool-name: BossHikariCP\r\n      primary: base\r\n      datasource:\r\n        base:\r\n          username: root\r\n          password: 16250\r\n          driver-class-name: com.mysql.cj.jdbc.Driver\r\n          url: jdbc:mysql://${mysql.url}:3306/boss_rbac?useUnicode=ture&characterEncoding=UTF-8&useJDBCCompliantTimezoneShift=ture&useLegacyDatetimeCode=false&serverTimezone=GMT%2b8\r\n      p6spy: true\r\n  boot:\r\n    admin:\r\n      client:\r\n        url: http://${boss-monitor-admin}:9470\r\n        username: boss\r\n        password: 16250\r\n  zipkin:\r\n    sender:\r\n      type: rabbit\r\n  sleuth:\r\n    sampler:\r\n      probability: 1\r\n  rabbitmq:\r\n    host: ${rabbitmq.url}\r\n    port: 5672\r\n    username: boss\r\n    password: 16250\r\n  autoconfigure:\r\n    exclude: org.springframework.boot.autoconfigure.data.redis.RedisAutoConfiguration\r\n\r\nmybatis-plus:\r\n  type-aliases-package: com.boss.common.entity.po\r\n  mapper-locations: classpath:mapper/*.xml\r\n  configuration:\r\n    jdbc-type-for-null: null\r\n  global-config:\r\n    banner: false\r\n\r\nsecurity:\r\n  oauth2:\r\n    resource:\r\n      id: ${spring.application.name}\r\n      user-info-uri: http://${boss-gateway}:9370/auth/user\r\n\r\nfeign:\r\n  hystrix:\r\n    enabled: true\r\n\r\nhystrix:\r\n  shareSecurityContext: true\r\n\r\ninfo:\r\n  app:\r\n    name: ${spring.application.name}\r\n    description: \"@project.description@\"\r\n    version: \"@project.version@\"\r\n\r\nmanagement:\r\n  endpoints:\r\n    web:\r\n      exposure:\r\n        include: \"*\"\r\n  endpoint:\r\n    health:\r\n      show-details: always', 'dd336d353e9ddbabda8a954a0fbc3f2d', '2022-07-13 02:50:36', '2022-07-13 02:50:36', 'nacos', '192.168.0.105', '', '', 'Boss-Server-System微服务配置', NULL, NULL, 'yaml', NULL);
INSERT INTO `config_info` VALUES (6, 'boss-server-test.yaml', 'DEFAULT_GROUP', 'server:\n  port: 9180\n\nspring:\n  autoconfigure:\n    exclude: org.springframework.boot.autoconfigure.data.redis.RedisAutoConfiguration\n  datasource:\n    dynamic:\n      hikari:\n        connection-timeout: 30000\n        max-lifetime: 1800000\n        max-pool-size: 15\n        min-idle: 5\n        connection-test-query: select 1\n        pool-name: BossTestHikariCP\n      primary: base\n      datasource:\n        base:\n          username: root\n          password: 16250\n          driver-class-name: com.mysql.cj.jdbc.Driver\n          url: jdbc:mysql://${mysql.url}:3306/boss_rbac?useUnicode=ture&characterEncoding=UTF-8&useJDBCCompliantTimezoneShift=ture&useLegacyDatetimeCode=false&serverTimezone=GMT%2b8\n      p6spy: true\n  boot:\n    admin:\n      client:\n        url: http://${boss-monitor-admin}:9470\n        username: boss\n        password: 16250\n  zipkin:\n    sender:\n      type: rabbit\n  sleuth:\n    sampler:\n      probability: 1\n  rabbitmq:\n    host: ${rabbitmq.url}\n    port: 5672\n    username: boss\n    password: 16250\n\nmybatis-plus:\n  type-aliases-package: com.boss.common.entity.po\n  mapper-locations: classpath:mapper/*.xml\n  configuration:\n    jdbc-type-for-null: null\n  global-config:\n    banner: false\n\nsecurity:\n  oauth2:\n    resource:\n      id: ${spring.application.name}\n      user-info-uri: http://${boss-gateway}:9370/auth/user\n\ninfo:\n  app:\n    name: ${spring.application.name}\n    description: \"@project.description@\"\n    version: \"@project.version@\"\n\nmanagement:\n  endpoints:\n    web:\n      exposure:\n        include: \"*\"\n  endpoint:\n    health:\n      show-details: always', '801006244683570478229711494932e5', '2022-07-13 02:51:39', '2022-07-14 02:11:23', 'nacos', '192.168.0.105', '', '', 'Boss-Server-Test微服务配置', '', '', 'yaml', '');

-- ----------------------------
-- Table structure for config_info_aggr
-- ----------------------------
DROP TABLE IF EXISTS `config_info_aggr`;
CREATE TABLE `config_info_aggr`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `data_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'data_id',
  `group_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'group_id',
  `datum_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'datum_id',
  `content` longtext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '内容',
  `gmt_modified` datetime(0) NOT NULL COMMENT '修改时间',
  `app_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `tenant_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '租户字段',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_configinfoaggr_datagrouptenantdatum`(`data_id`, `group_id`, `tenant_id`, `datum_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '增加租户字段' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for config_info_beta
-- ----------------------------
DROP TABLE IF EXISTS `config_info_beta`;
CREATE TABLE `config_info_beta`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `data_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'data_id',
  `group_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'group_id',
  `app_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'app_name',
  `content` longtext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'content',
  `beta_ips` varchar(1024) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'betaIps',
  `md5` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'md5',
  `gmt_create` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `gmt_modified` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '修改时间',
  `src_user` text CHARACTER SET utf8 COLLATE utf8_bin NULL COMMENT 'source user',
  `src_ip` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'source ip',
  `tenant_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '租户字段',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_configinfobeta_datagrouptenant`(`data_id`, `group_id`, `tenant_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = 'config_info_beta' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for config_info_tag
-- ----------------------------
DROP TABLE IF EXISTS `config_info_tag`;
CREATE TABLE `config_info_tag`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `data_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'data_id',
  `group_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'group_id',
  `tenant_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT 'tenant_id',
  `tag_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'tag_id',
  `app_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'app_name',
  `content` longtext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'content',
  `md5` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'md5',
  `gmt_create` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `gmt_modified` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '修改时间',
  `src_user` text CHARACTER SET utf8 COLLATE utf8_bin NULL COMMENT 'source user',
  `src_ip` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'source ip',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_configinfotag_datagrouptenanttag`(`data_id`, `group_id`, `tenant_id`, `tag_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = 'config_info_tag' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for config_tags_relation
-- ----------------------------
DROP TABLE IF EXISTS `config_tags_relation`;
CREATE TABLE `config_tags_relation`  (
  `id` bigint(0) NOT NULL COMMENT 'id',
  `tag_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'tag_name',
  `tag_type` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'tag_type',
  `data_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'data_id',
  `group_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'group_id',
  `tenant_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT 'tenant_id',
  `nid` bigint(0) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`nid`) USING BTREE,
  UNIQUE INDEX `uk_configtagrelation_configidtag`(`id`, `tag_name`, `tag_type`) USING BTREE,
  INDEX `idx_tenant_id`(`tenant_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = 'config_tag_relation' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for group_capacity
-- ----------------------------
DROP TABLE IF EXISTS `group_capacity`;
CREATE TABLE `group_capacity`  (
  `id` bigint(0) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `group_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT 'Group ID，空字符表示整个集群',
  `quota` int(0) UNSIGNED NOT NULL DEFAULT 0 COMMENT '配额，0表示使用默认值',
  `usage` int(0) UNSIGNED NOT NULL DEFAULT 0 COMMENT '使用量',
  `max_size` int(0) UNSIGNED NOT NULL DEFAULT 0 COMMENT '单个配置大小上限，单位为字节，0表示使用默认值',
  `max_aggr_count` int(0) UNSIGNED NOT NULL DEFAULT 0 COMMENT '聚合子配置最大个数，，0表示使用默认值',
  `max_aggr_size` int(0) UNSIGNED NOT NULL DEFAULT 0 COMMENT '单个聚合数据的子配置大小上限，单位为字节，0表示使用默认值',
  `max_history_count` int(0) UNSIGNED NOT NULL DEFAULT 0 COMMENT '最大变更历史数量',
  `gmt_create` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `gmt_modified` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_group_id`(`group_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '集群、各Group容量信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for his_config_info
-- ----------------------------
DROP TABLE IF EXISTS `his_config_info`;
CREATE TABLE `his_config_info`  (
  `id` bigint(0) UNSIGNED NOT NULL,
  `nid` bigint(0) UNSIGNED NOT NULL AUTO_INCREMENT,
  `data_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `group_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `app_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'app_name',
  `content` longtext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `md5` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `gmt_create` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
  `gmt_modified` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
  `src_user` text CHARACTER SET utf8 COLLATE utf8_bin NULL,
  `src_ip` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `op_type` char(10) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `tenant_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '租户字段',
  PRIMARY KEY (`nid`) USING BTREE,
  INDEX `idx_gmt_create`(`gmt_create`) USING BTREE,
  INDEX `idx_gmt_modified`(`gmt_modified`) USING BTREE,
  INDEX `idx_did`(`data_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '多租户改造' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of his_config_info
-- ----------------------------
INSERT INTO `his_config_info` VALUES (0, 1, 'boss-auth.yaml', 'DEFAULT_GROUP', '', 'server:\r\n  port: 9270\r\n\r\nspring:\r\n  redis:\r\n    database: 0\r\n    host: ${redis.url}\r\n    port: 6379\r\n    lettuce:\r\n      pool:\r\n        min-idle: 8\r\n        max-idle: 500\r\n        max-active: 2000\r\n        max-wait: 10000\r\n    timeout: 5000\r\n  datasource:\r\n    dynamic:\r\n      hikari:\r\n        connection-timeout: 30000\r\n        max-lifetime: 1800000\r\n        max-pool-size: 15\r\n        min-idle: 5\r\n        connection-test-query: select 1\r\n        pool-name: BossHikariCP\r\n      primary: base\r\n      datasource:\r\n        base:\r\n          username: root\r\n          password: 16250\r\n          driver-class-name: com.mysql.cj.jdbc.Driver\r\n          url: jdbc:mysql://${mysql.url}:3306/boss_rbac?useUnicode=true&characterEncoding=UTF-8&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=GMT%2b8\r\n  boot:\r\n    admin:\r\n      client:\r\n        url: http://${boss-monitor-admin}:9470\r\n        username: boss\r\n        password: 16250\r\n\r\nmybatis-plus:\r\n  type-aliases-package: com.boss.common.entity.po\r\n  mapper-locations: classpath:mapper/*.xml\r\n  configuration:\r\n    jdbc-type-for-null: null\r\n  global-config:\r\n    banner: false\r\n\r\ninfo:\r\n  app:\r\n    name: ${spring.application.name}\r\n    description: \"@project.description@\"\r\n    version: \"@project.version@\"\r\n\r\nmanagement:\r\n  endpoints:\r\n    web:\r\n      exposure:\r\n        include: \"*\"\r\n  endpoint:\r\n    health:\r\n      show-details: always', '2dcf71bcbe900b805032a0dc593c6990', '2022-07-13 10:35:25', '2022-07-13 02:35:26', 'nacos', '192.168.0.105', 'I', '');
INSERT INTO `his_config_info` VALUES (0, 2, 'boss-gateway.yaml', 'DEFAULT_GROUP', '', 'server:\r\n  port: 9370\r\n\r\nspring:\r\n  boot:\r\n    admin:\r\n      client:\r\n        url: http://${boss-monitor-admin}:9470\r\n        username: boss\r\n        password: 16250\r\n  cloud:\r\n    gateway:\r\n      routes:\r\n        - id: Boss-Auth\r\n          uri: lb://Boss-Auth\r\n          predicates:\r\n            - Path=/auth/**\r\n          filters:\r\n            - name: Hystrix\r\n              args:\r\n                name: authfallback\r\n                fallbackUri: forward:/fallback/Boss-Auth\r\n        - id: Boss-Server-System\r\n          uri: lb://Boss-Server-System\r\n          predicates:\r\n            - Path=/system/**\r\n          filters:\r\n              - name: Hystrix\r\n                args:\r\n                  name: systemfallback\r\n                  fallbackUri: forward:/fallback/Boss-Server-System\r\n        - id: Boss-Server-Test\r\n          uri: lb://Boss-Server-Test\r\n          predicates:\r\n            - Path=/test/**\r\n          filters:\r\n              - name: Hystrix\r\n                args:\r\n                  name: testfallback\r\n                  fallbackUri: forward:/fallback/Boss-Server-Test\r\n      default-filters:\r\n        - StripPrefix=1\r\n\r\nmanagement:\r\n  endpoint:\r\n    health:\r\n      show-details: always\r\n  endpoints:\r\n    web:\r\n      exposure:\r\n        include: health,info,gateway\r\n\r\nhystrix:\r\n  command:\r\n    default:\r\n      execution:\r\n        isolation:\r\n          thread:\r\n            timeoutInMilliseconds: 3000', 'cb27f9fe4878c92309b3d66acf3735fc', '2022-07-13 10:45:39', '2022-07-13 02:45:40', 'nacos', '192.168.0.105', 'I', '');
INSERT INTO `his_config_info` VALUES (0, 3, 'boss-monitor-admin', 'DEFAULT_GROUP', '', 'server:\r\n  port: 9470\r\n\r\n\r\nspring:\r\n  boot:\r\n    admin:\r\n      ui:\r\n        title: ${spring.application.name}\r\n  security:\r\n    user:\r\n      name: boss\r\n      password: 16250', 'a42d2b49496e6b304fc678729f18b4b5', '2022-07-13 10:48:11', '2022-07-13 02:48:12', 'nacos', '192.168.0.105', 'I', '');
INSERT INTO `his_config_info` VALUES (3, 4, 'boss-monitor-admin', 'DEFAULT_GROUP', '', 'server:\r\n  port: 9470\r\n\r\n\r\nspring:\r\n  boot:\r\n    admin:\r\n      ui:\r\n        title: ${spring.application.name}\r\n  security:\r\n    user:\r\n      name: boss\r\n      password: 16250', 'a42d2b49496e6b304fc678729f18b4b5', '2022-07-13 10:49:02', '2022-07-13 02:49:03', 'nacos', '192.168.0.105', 'D', '');
INSERT INTO `his_config_info` VALUES (0, 5, 'boss-monitor-admin.yaml', 'DEFAULT_GROUP', '', 'server:\r\n  port: 9470\r\n\r\n\r\nspring:\r\n  boot:\r\n    admin:\r\n      ui:\r\n        title: ${spring.application.name}\r\n  security:\r\n    user:\r\n      name: boss\r\n      password: 16250', 'a42d2b49496e6b304fc678729f18b4b5', '2022-07-13 10:49:35', '2022-07-13 02:49:35', 'nacos', '192.168.0.105', 'I', '');
INSERT INTO `his_config_info` VALUES (0, 6, 'boss-server-system.yaml', 'DEFAULT_GROUP', '', 'server:\r\n  port: 9170\r\n\r\nspring:\r\n  datasource:\r\n    dynamic:\r\n      hikari:\r\n        connection-timeout: 30000\r\n        max-lifetime: 1800000\r\n        max-pool-size: 15\r\n        min-idle: 5\r\n        connection-test-query: select 1\r\n        pool-name: BossHikariCP\r\n      primary: base\r\n      datasource:\r\n        base:\r\n          username: root\r\n          password: 16250\r\n          driver-class-name: com.mysql.cj.jdbc.Driver\r\n          url: jdbc:mysql://${mysql.url}:3306/boss_rbac?useUnicode=ture&characterEncoding=UTF-8&useJDBCCompliantTimezoneShift=ture&useLegacyDatetimeCode=false&serverTimezone=GMT%2b8\r\n      p6spy: true\r\n  boot:\r\n    admin:\r\n      client:\r\n        url: http://${boss-monitor-admin}:9470\r\n        username: boss\r\n        password: 16250\r\n  zipkin:\r\n    sender:\r\n      type: rabbit\r\n  sleuth:\r\n    sampler:\r\n      probability: 1\r\n  rabbitmq:\r\n    host: ${rabbitmq.url}\r\n    port: 5672\r\n    username: boss\r\n    password: 16250\r\n  autoconfigure:\r\n    exclude: org.springframework.boot.autoconfigure.data.redis.RedisAutoConfiguration\r\n\r\nmybatis-plus:\r\n  type-aliases-package: com.boss.common.entity.po\r\n  mapper-locations: classpath:mapper/*.xml\r\n  configuration:\r\n    jdbc-type-for-null: null\r\n  global-config:\r\n    banner: false\r\n\r\nsecurity:\r\n  oauth2:\r\n    resource:\r\n      id: ${spring.application.name}\r\n      user-info-uri: http://${boss-gateway}:9370/auth/user\r\n\r\nfeign:\r\n  hystrix:\r\n    enabled: true\r\n\r\nhystrix:\r\n  shareSecurityContext: true\r\n\r\ninfo:\r\n  app:\r\n    name: ${spring.application.name}\r\n    description: \"@project.description@\"\r\n    version: \"@project.version@\"\r\n\r\nmanagement:\r\n  endpoints:\r\n    web:\r\n      exposure:\r\n        include: \"*\"\r\n  endpoint:\r\n    health:\r\n      show-details: always', 'dd336d353e9ddbabda8a954a0fbc3f2d', '2022-07-13 10:50:36', '2022-07-13 02:50:36', 'nacos', '192.168.0.105', 'I', '');
INSERT INTO `his_config_info` VALUES (0, 7, 'boss-server-test.yaml', 'DEFAULT_GROUP', '', 'server:\r\n  port: 9180\r\n\r\nspring:\r\n  autoconfigure:\r\n    exclude: org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration, com.baomidou.dynamic.datasource.spring.boot.autoconfigure.DynamicDataSourceAutoConfiguration, org.springframework.boot.autoconfigure.data.redis.RedisAutoConfiguration\r\n  boot:\r\n    admin:\r\n      client:\r\n        url: http://${boss-monitor-admin}:9470\r\n        username: boss\r\n        password: 16250\r\n  zipkin:\r\n    sender:\r\n      type: rabbit\r\n  sleuth:\r\n    sampler:\r\n      probability: 1\r\n  rabbitmq:\r\n    host: ${rabbitmq.url}\r\n    port: 5672\r\n    username: boss\r\n    password: 16250\r\n\r\nsecurity:\r\n  oauth2:\r\n    resource:\r\n      id: ${spring.application.name}\r\n      user-info-uri: http://${boss-gateway}:9370/auth/user\r\n\r\ninfo:\r\n  app:\r\n    name: ${spring.application.name}\r\n    description: \"@project.description@\"\r\n    version: \"@project.version@\"\r\n\r\nmanagement:\r\n  endpoints:\r\n    web:\r\n      exposure:\r\n        include: \"*\"\r\n  endpoint:\r\n    health:\r\n      show-details: always', '65a09c1b2b070904de7e9ae826074f91', '2022-07-13 10:51:39', '2022-07-13 02:51:39', 'nacos', '192.168.0.105', 'I', '');
INSERT INTO `his_config_info` VALUES (1, 8, 'boss-auth.yaml', 'DEFAULT_GROUP', '', 'server:\r\n  port: 9270\r\n\r\nspring:\r\n  redis:\r\n    database: 0\r\n    host: ${redis.url}\r\n    port: 6379\r\n    lettuce:\r\n      pool:\r\n        min-idle: 8\r\n        max-idle: 500\r\n        max-active: 2000\r\n        max-wait: 10000\r\n    timeout: 5000\r\n  datasource:\r\n    dynamic:\r\n      hikari:\r\n        connection-timeout: 30000\r\n        max-lifetime: 1800000\r\n        max-pool-size: 15\r\n        min-idle: 5\r\n        connection-test-query: select 1\r\n        pool-name: BossHikariCP\r\n      primary: base\r\n      datasource:\r\n        base:\r\n          username: root\r\n          password: 16250\r\n          driver-class-name: com.mysql.cj.jdbc.Driver\r\n          url: jdbc:mysql://${mysql.url}:3306/boss_rbac?useUnicode=true&characterEncoding=UTF-8&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=GMT%2b8\r\n  boot:\r\n    admin:\r\n      client:\r\n        url: http://${boss-monitor-admin}:9470\r\n        username: boss\r\n        password: 16250\r\n\r\nmybatis-plus:\r\n  type-aliases-package: com.boss.common.entity.po\r\n  mapper-locations: classpath:mapper/*.xml\r\n  configuration:\r\n    jdbc-type-for-null: null\r\n  global-config:\r\n    banner: false\r\n\r\ninfo:\r\n  app:\r\n    name: ${spring.application.name}\r\n    description: \"@project.description@\"\r\n    version: \"@project.version@\"\r\n\r\nmanagement:\r\n  endpoints:\r\n    web:\r\n      exposure:\r\n        include: \"*\"\r\n  endpoint:\r\n    health:\r\n      show-details: always', '2dcf71bcbe900b805032a0dc593c6990', '2022-07-14 08:57:54', '2022-07-14 00:57:54', 'nacos', '192.168.0.105', 'U', '');
INSERT INTO `his_config_info` VALUES (1, 9, 'boss-auth.yaml', 'DEFAULT_GROUP', '', 'server:\n  port: 9270\n\nspring:\n  redis:\n    database: 0\n    host: ${redis.url}\n    port: 6379\n    lettuce:\n      pool:\n        min-idle: 8\n        max-idle: 500\n        max-active: 2000\n        max-wait: 10000\n    timeout: 5000\n  datasource:\n    dynamic:\n      hikari:\n        connection-timeout: 30000\n        max-lifetime: 1800000\n        max-pool-size: 15\n        min-idle: 5\n        connection-test-query: select 1\n        pool-name: BossHikariCP\n      primary: base\n      datasource:\n        base:\n          username: root\n          password: 16250\n          driver-class-name: com.mysql.cj.jdbc.Driver\n          url: jdbc:mysql://${mysql.url}:3306/boss_rbac?useUnicode=true&characterEncoding=UTF-8&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=GMT%2b8\n  boot:\n    admin:\n      client:\n        url: http://${boss-monitor-admin}:9470\n        username: boss\n        password: 16250\n  logstash:\n    destination: ${logstash.url}:4560\n\nmybatis-plus:\n  type-aliases-package: com.boss.common.entity.po\n  mapper-locations: classpath:mapper/*.xml\n  configuration:\n    jdbc-type-for-null: null\n  global-config:\n    banner: false\n\ninfo:\n  app:\n    name: ${spring.application.name}\n    description: \"@project.description@\"\n    version: \"@project.version@\"\n\nmanagement:\n  endpoints:\n    web:\n      exposure:\n        include: \"*\"\n  endpoint:\n    health:\n      show-details: always', '11d8629c73f1ce119034bc544315b7e8', '2022-07-14 09:34:48', '2022-07-14 01:34:48', 'nacos', '192.168.0.105', 'U', '');
INSERT INTO `his_config_info` VALUES (6, 10, 'boss-server-test.yaml', 'DEFAULT_GROUP', '', 'server:\r\n  port: 9180\r\n\r\nspring:\r\n  autoconfigure:\r\n    exclude: org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration, com.baomidou.dynamic.datasource.spring.boot.autoconfigure.DynamicDataSourceAutoConfiguration, org.springframework.boot.autoconfigure.data.redis.RedisAutoConfiguration\r\n  boot:\r\n    admin:\r\n      client:\r\n        url: http://${boss-monitor-admin}:9470\r\n        username: boss\r\n        password: 16250\r\n  zipkin:\r\n    sender:\r\n      type: rabbit\r\n  sleuth:\r\n    sampler:\r\n      probability: 1\r\n  rabbitmq:\r\n    host: ${rabbitmq.url}\r\n    port: 5672\r\n    username: boss\r\n    password: 16250\r\n\r\nsecurity:\r\n  oauth2:\r\n    resource:\r\n      id: ${spring.application.name}\r\n      user-info-uri: http://${boss-gateway}:9370/auth/user\r\n\r\ninfo:\r\n  app:\r\n    name: ${spring.application.name}\r\n    description: \"@project.description@\"\r\n    version: \"@project.version@\"\r\n\r\nmanagement:\r\n  endpoints:\r\n    web:\r\n      exposure:\r\n        include: \"*\"\r\n  endpoint:\r\n    health:\r\n      show-details: always', '65a09c1b2b070904de7e9ae826074f91', '2022-07-14 10:10:31', '2022-07-14 02:10:32', 'nacos', '192.168.0.105', 'U', '');
INSERT INTO `his_config_info` VALUES (6, 11, 'boss-server-test.yaml', 'DEFAULT_GROUP', '', 'server:\n  port: 9180\n\nspring:\n  autoconfigure:\n    exclude: org.springframework.boot.autoconfigure.data.redis.RedisAutoConfiguration\n  datasource:\n    dynamic:\n      hikari:\n        connection-timeout: 30000\n        max-lifetime: 1800000\n        max-pool-size: 15\n        min-idle: 5\n        connection-test-query: select 1\n        pool-name: BossTestHikariCP\n      primary: base\n      datasource:\n        base:\n          username: root\n          password: 16250\n          driver-class-name: com.mysql.cj.jdbc.Driver\n          url: jdbc:mysql://${mysql.url}:3306/boss_rbac?useUnicode=ture&characterEncoding=UTF-8&useJDBCCompliantTimezoneShift=ture&useLegacyDatetimeCode=false&serverTimezone=GMT%2b8\n      p6spy: true\n  boot:\n    admin:\n      client:\n        url: http://${boss-monitor-admin}:9470\n        username: boss\n        password: 16250\n  zipkin:\n    sender:\n      type: rabbit\n  sleuth:\n    sampler:\n      probability: 1\n  rabbitmq:\n    host: ${rabbitmq.url}\n    port: 5672\n    username: boss\n    password: 16250\n\nsecurity:\n  oauth2:\n    resource:\n      id: ${spring.application.name}\n      user-info-uri: http://${boss-gateway}:9370/auth/user\n\ninfo:\n  app:\n    name: ${spring.application.name}\n    description: \"@project.description@\"\n    version: \"@project.version@\"\n\nmanagement:\n  endpoints:\n    web:\n      exposure:\n        include: \"*\"\n  endpoint:\n    health:\n      show-details: always', '58837b775c4f3cea5d6f665be9c0b31b', '2022-07-14 10:11:22', '2022-07-14 02:11:23', 'nacos', '192.168.0.105', 'U', '');
INSERT INTO `his_config_info` VALUES (1, 12, 'boss-auth.yaml', 'DEFAULT_GROUP', '', 'server:\n  port: 9270\n\nspring:\n  redis:\n    database: 0\n    host: ${redis.url}\n    port: 6379\n    lettuce:\n      pool:\n        min-idle: 8\n        max-idle: 500\n        max-active: 2000\n        max-wait: 10000\n    timeout: 5000\n  datasource:\n    dynamic:\n      hikari:\n        connection-timeout: 30000\n        max-lifetime: 1800000\n        max-pool-size: 15\n        min-idle: 5\n        connection-test-query: select 1\n        pool-name: BossHikariCP\n      primary: base\n      datasource:\n        base:\n          username: root\n          password: 16250\n          driver-class-name: com.mysql.cj.jdbc.Driver\n          url: jdbc:mysql://${mysql.url}:3306/boss_rbac?useUnicode=true&characterEncoding=UTF-8&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=GMT%2b8\n  boot:\n    admin:\n      client:\n        url: http://${boss-monitor-admin}:9470\n        username: boss\n        password: 16250\n\nmybatis-plus:\n  type-aliases-package: com.boss.common.entity.po\n  mapper-locations: classpath:mapper/*.xml\n  configuration:\n    jdbc-type-for-null: null\n  global-config:\n    banner: false\n\ninfo:\n  app:\n    name: ${spring.application.name}\n    description: \"@project.description@\"\n    version: \"@project.version@\"\n\nmanagement:\n  endpoints:\n    web:\n      exposure:\n        include: \"*\"\n  endpoint:\n    health:\n      show-details: always\n\nlogstash:\n    destination: ${logstash.url}:4560', '3a9f6c3ec687cc8c19924afb933ae55c', '2022-07-14 15:27:59', '2022-07-14 07:27:58', 'nacos', '192.168.0.105', 'U', '');
INSERT INTO `his_config_info` VALUES (1, 13, 'boss-auth.yaml', 'DEFAULT_GROUP', '', 'server:\n  port: 9270\n\nspring:\n  redis:\n    database: 0\n    host: ${redis.url}\n    port: 6379\n    lettuce:\n      pool:\n        min-idle: 8\n        max-idle: 500\n        max-active: 2000\n        max-wait: 10000\n    timeout: 5000\n  datasource:\n    dynamic:\n      hikari:\n        connection-timeout: 30000\n        max-lifetime: 1800000\n        max-pool-size: 15\n        min-idle: 5\n        connection-test-query: select 1\n        pool-name: BossHikariCP\n      primary: base\n      datasource:\n        base:\n          username: root\n          password: 16250\n          driver-class-name: com.mysql.cj.jdbc.Driver\n          url: jdbc:mysql://${mysql.url}:3306/boss_rbac?useUnicode=true&characterEncoding=UTF-8&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=GMT%2b8\n  boot:\n    admin:\n      client:\n        url: http://${boss-monitor-admin}:9470\n        username: boss\n        password: 16250\n\nmybatis-plus:\n  type-aliases-package: com.boss.common.entity.po\n  mapper-locations: classpath:mapper/*.xml\n  configuration:\n    jdbc-type-for-null: null\n  global-config:\n    banner: false\n\ninfo:\n  app:\n    name: ${spring.application.name}\n    description: \"@project.description@\"\n    version: \"@project.version@\"\n\nmanagement:\n  endpoints:\n    web:\n      exposure:\n        include: \"*\"\n  endpoint:\n    health:\n      show-details: always\n\nlogstash:\n    host: ${logstash.url} \n    port: 4560', '3cc48109aa33430c6ab08a5d23f078e4', '2022-07-14 15:44:28', '2022-07-14 07:44:27', 'nacos', '192.168.0.105', 'U', '');
INSERT INTO `his_config_info` VALUES (1, 14, 'boss-auth.yaml', 'DEFAULT_GROUP', '', 'server:\n  port: 9270\n\nspring:\n  redis:\n    database: 0\n    host: ${redis.url}\n    port: 6379\n    lettuce:\n      pool:\n        min-idle: 8\n        max-idle: 500\n        max-active: 2000\n        max-wait: 10000\n    timeout: 5000\n  datasource:\n    dynamic:\n      hikari:\n        connection-timeout: 30000\n        max-lifetime: 1800000\n        max-pool-size: 15\n        min-idle: 5\n        connection-test-query: select 1\n        pool-name: BossHikariCP\n      primary: base\n      datasource:\n        base:\n          username: root\n          password: 16250\n          driver-class-name: com.mysql.cj.jdbc.Driver\n          url: jdbc:mysql://${mysql.url}:3306/boss_rbac?useUnicode=true&characterEncoding=UTF-8&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=GMT%2b8\n  boot:\n    admin:\n      client:\n        url: http://${boss-monitor-admin}:9470\n        username: boss\n        password: 16250\n\nmybatis-plus:\n  type-aliases-package: com.boss.common.entity.po\n  mapper-locations: classpath:mapper/*.xml\n  configuration:\n    jdbc-type-for-null: null\n  global-config:\n    banner: false\n\ninfo:\n  app:\n    name: ${spring.application.name}\n    description: \"@project.description@\"\n    version: \"@project.version@\"\n\nmanagement:\n  endpoints:\n    web:\n      exposure:\n        include: \"*\"\n  endpoint:\n    health:\n      show-details: always\n\nlogstash:\n    host: ${logstash.url}\n    port: 4560', 'd55550b2f680007736e0150baa443d49', '2022-07-14 15:48:14', '2022-07-14 07:48:14', 'nacos', '192.168.0.105', 'U', '');

-- ----------------------------
-- Table structure for permissions
-- ----------------------------
DROP TABLE IF EXISTS `permissions`;
CREATE TABLE `permissions`  (
  `role` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `resource` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `action` varchar(8) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  UNIQUE INDEX `uk_role_permission`(`role`, `resource`, `action`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for roles
-- ----------------------------
DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles`  (
  `username` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `role` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  UNIQUE INDEX `idx_user_role`(`username`, `role`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of roles
-- ----------------------------
INSERT INTO `roles` VALUES ('nacos', 'ROLE_ADMIN');

-- ----------------------------
-- Table structure for tenant_capacity
-- ----------------------------
DROP TABLE IF EXISTS `tenant_capacity`;
CREATE TABLE `tenant_capacity`  (
  `id` bigint(0) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `tenant_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT 'Tenant ID',
  `quota` int(0) UNSIGNED NOT NULL DEFAULT 0 COMMENT '配额，0表示使用默认值',
  `usage` int(0) UNSIGNED NOT NULL DEFAULT 0 COMMENT '使用量',
  `max_size` int(0) UNSIGNED NOT NULL DEFAULT 0 COMMENT '单个配置大小上限，单位为字节，0表示使用默认值',
  `max_aggr_count` int(0) UNSIGNED NOT NULL DEFAULT 0 COMMENT '聚合子配置最大个数',
  `max_aggr_size` int(0) UNSIGNED NOT NULL DEFAULT 0 COMMENT '单个聚合数据的子配置大小上限，单位为字节，0表示使用默认值',
  `max_history_count` int(0) UNSIGNED NOT NULL DEFAULT 0 COMMENT '最大变更历史数量',
  `gmt_create` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `gmt_modified` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_tenant_id`(`tenant_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '租户容量信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for tenant_info
-- ----------------------------
DROP TABLE IF EXISTS `tenant_info`;
CREATE TABLE `tenant_info`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `kp` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'kp',
  `tenant_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT 'tenant_id',
  `tenant_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT 'tenant_name',
  `tenant_desc` varchar(256) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'tenant_desc',
  `create_source` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'create_source',
  `gmt_create` bigint(0) NOT NULL COMMENT '创建时间',
  `gmt_modified` bigint(0) NOT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_tenant_info_kptenantid`(`kp`, `tenant_id`) USING BTREE,
  INDEX `idx_tenant_id`(`tenant_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = 'tenant_info' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `username` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `password` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  PRIMARY KEY (`username`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES ('nacos', '$2a$10$EuWPZHzz32dJN7jexM34MOeYirDdFAZm2kuWj7VEOJhhZkDrxfvUu', 1);

SET FOREIGN_KEY_CHECKS = 1;
