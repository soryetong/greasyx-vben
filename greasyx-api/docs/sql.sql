
-- ----------------------------
-- Table structure for sys_users
-- ----------------------------
DROP TABLE IF EXISTS `sys_users`;
CREATE TABLE `sys_users` (
     `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键字段',
     `username` varchar(255) NOT NULL DEFAULT '' COMMENT '用户名',
     `nickname` varchar(255) NOT NULL DEFAULT '' COMMENT '用户昵称',
     `password` varchar(32) NOT NULL DEFAULT '' COMMENT '密码',
     `salt` char(6) NOT NULL DEFAULT '' COMMENT '加密盐',
     `mobile` varchar(50) NOT NULL DEFAULT '' COMMENT '手机号',
     `gender` tinyint(1) NULL DEFAULT 1 COMMENT '性别(1-男 2-女 0-保密)',
     `email` varchar(255) NOT NULL DEFAULT '' COMMENT '邮箱',
     `avatar` varchar(255) NOT NULL DEFAULT '' COMMENT '头像',
     `status` tinyint(1) unsigned NOT NULL DEFAULT 1 COMMENT '状态 1:正常,2:禁用',
     `dept_id` int unsigned NOT NULL DEFAULT 0 COMMENT '部门ID',
     `role_id` int unsigned NOT NULL DEFAULT 0 COMMENT '角色ID',
     `remark` varchar(255) NOT NULL DEFAULT '' COMMENT '备注',
     `create_by` int(10) unsigned NOT NULL DEFAULT 0 COMMENT '创建者ID',
     `update_by` int(10) unsigned NOT NULL DEFAULT 0 COMMENT '更新者ID',
     `last_login_time` bigint(20) NOT NULL DEFAULT 0 COMMENT '最后一次登录的时间',
     `last_login_ip` varchar(64) NOT NULL DEFAULT '' COMMENT '最后一次登录的IP',
     `created_at` datetime DEFAULT NULL COMMENT '创建时间戳',
     `updated_at` datetime DEFAULT NULL COMMENT '修改时间戳',
     `deleted_at` datetime DEFAULT NULL COMMENT '删除时间',
     PRIMARY KEY (`id`),
     UNIQUE KEY `uidx_username` (`username`)
) COMMENT='系统用户表';

-- -----------------------------
-- Table structure for sys_menus
-- -----------------------------
DROP TABLE IF EXISTS `sys_menus`;
CREATE TABLE `sys_menus`  (
      `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键字段',
      `parent_id` bigint unsigned NOT NULL COMMENT '父菜单ID',
      `tree_path` varchar(255)  NULL DEFAULT NULL COMMENT '父节点ID路径',
      `name` varchar(255)  NOT NULL DEFAULT '' COMMENT '菜单名称',
      `type` varchar(50) NOT NULL DEFAULT '' COMMENT '菜单类型',
      `route_name` varchar(255)  NULL DEFAULT NULL COMMENT '路由名称（Vue Router 中用于命名路由）',
      `path` varchar(128)  NULL DEFAULT '' COMMENT '路由路径（Vue Router 中定义的 URL 路径）',
      `component` varchar(128)  NULL DEFAULT NULL COMMENT '组件路径（组件页面完整路径，相对于 src/views/，缺省后缀 .vue）',
      `perm` varchar(128)  NULL DEFAULT NULL COMMENT '【按钮】权限标识',
      `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '显示状态（1-显示 2-隐藏）',
      `affix_tab` tinyint NULL DEFAULT 0 COMMENT '固定标签页（1-是 2-否）',
      `hide_children_in_menu` tinyint NULL DEFAULT 0 COMMENT '子级不展现（1-是 2-否）',
      `hide_in_breadcrumb` tinyint NULL DEFAULT 0 COMMENT '面包屑中不展现（1-是 2-否）',
      `hide_in_menu` tinyint NULL DEFAULT 0 COMMENT '菜单中不展现（1-是 2-否）',
      `hide_in_tab` tinyint NULL DEFAULT 0 COMMENT '标签页中不展现（1-是 2-否）',
      `keep_alive` tinyint NULL DEFAULT 0 COMMENT '是否缓存（1-是 2-否）',
      `sort` int NULL DEFAULT 0 COMMENT '排序',
      `icon` varchar(64)  NULL DEFAULT '' COMMENT '菜单图标',
      `redirect` varchar(128)  NULL DEFAULT NULL COMMENT '跳转路径',
      `params` json NULL COMMENT '路由参数',
      `created_at` datetime DEFAULT NULL COMMENT '创建时间戳',
      `updated_at` datetime DEFAULT NULL COMMENT '修改时间戳',
      `deleted_at` datetime DEFAULT NULL COMMENT '删除时间',
      PRIMARY KEY (`id`)
) ENGINE = InnoDB COMMENT = '菜单管理';

-- -----------------------------
-- Table structure for sys_roles
-- -----------------------------
DROP TABLE IF EXISTS `sys_roles`;
CREATE TABLE `sys_roles`  (
      `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键字段',
      `name` varchar(255)  NOT NULL DEFAULT '' COMMENT '角色名称',
      `code` varchar(50) NOT NULL DEFAULT '' COMMENT '角色编码',
      `sort` int NULL DEFAULT 0 COMMENT '排序',
      `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '状态（1-显示 2-隐藏）',
      `remark` varchar(255) NOT NULL DEFAULT '' COMMENT '备注',
      `created_at` datetime DEFAULT NULL COMMENT '创建时间戳',
      `updated_at` datetime DEFAULT NULL COMMENT '修改时间戳',
      `deleted_at` datetime DEFAULT NULL COMMENT '删除时间',
      PRIMARY KEY (`id`)
) ENGINE = InnoDB COMMENT = '角色管理';

-- -----------------------------
-- Table structure for sys_role_auths
-- -----------------------------
DROP TABLE IF EXISTS `sys_role_auths`;
CREATE TABLE `sys_role_auths`  (
      `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键字段',
      `role_id` bigint(20) NOT NULL DEFAULT 0 COMMENT 'sys_roles表Id',
      `auth_id` bigint(20) NOT NULL DEFAULT 0 COMMENT 'sys_menus表Id',
      `created_at` datetime DEFAULT NULL COMMENT '创建时间戳',
      `updated_at` datetime DEFAULT NULL COMMENT '修改时间戳',
      `deleted_at` datetime DEFAULT NULL COMMENT '删除时间',
      PRIMARY KEY (`id`),
      KEY `uidx_role_id` (`role_id`)
) ENGINE = InnoDB COMMENT = '角色菜单权限';

-- -----------------------------
-- Table structure for sys_role_apis
-- -----------------------------
DROP TABLE IF EXISTS `sys_role_apis`;
CREATE TABLE `sys_role_apis`  (
       `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键字段',
       `role_id` bigint(20) NOT NULL DEFAULT 0 COMMENT 'sys_roles表Id',
       `api_id` bigint(20) NOT NULL DEFAULT 0 COMMENT 'sys_apis表Id',
       `created_at` datetime DEFAULT NULL COMMENT '创建时间戳',
       `updated_at` datetime DEFAULT NULL COMMENT '修改时间戳',
       `deleted_at` datetime DEFAULT NULL COMMENT '删除时间',
       PRIMARY KEY (`id`),
       KEY `uidx_role_id` (`role_id`)
) ENGINE = InnoDB COMMENT = '角色接口权限';

-- -----------------------------
-- Table structure for sys_dicts
-- -----------------------------
DROP TABLE IF EXISTS `sys_dicts`;
CREATE TABLE `sys_dicts`  (
       `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键字段',
       `dict_name` varchar(255)  NOT NULL DEFAULT '' COMMENT '字典名称',
       `dict_type` varchar(64)  NOT NULL DEFAULT '' COMMENT '字典类型',
       `item_key` varchar(50) NOT NULL DEFAULT '' COMMENT '字典编码',
       `item_value` varchar(2500) NOT NULL DEFAULT '' COMMENT '字典值',
       `sort` int NULL DEFAULT 0 COMMENT '排序',
       `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '状态（1-显示 2-隐藏）',
       `remark` varchar(255) NOT NULL DEFAULT '' COMMENT '备注',
       `created_at` datetime DEFAULT NULL COMMENT '创建时间戳',
       `updated_at` datetime DEFAULT NULL COMMENT '修改时间戳',
       `deleted_at` datetime DEFAULT NULL COMMENT '删除时间',
       PRIMARY KEY (`id`)
) ENGINE = InnoDB COMMENT = '数据字典';

-- -----------------------------
-- Table structure for sys_apis
-- -----------------------------
DROP TABLE IF EXISTS `sys_apis`;
CREATE TABLE `sys_apis`  (
        `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键字段',
        `parent_id` bigint(20) NOT NULL DEFAULT 0 COMMENT '父ID',
        `description` varchar(255)  NOT NULL DEFAULT '' COMMENT '描述',
        `method` varchar(255)  NOT NULL DEFAULT '' COMMENT '请求方法',
        `path` varchar(255) NOT NULL DEFAULT '' COMMENT '请求路径',
        `created_at` datetime DEFAULT NULL COMMENT '创建时间戳',
        `updated_at` datetime DEFAULT NULL COMMENT '修改时间戳',
        `deleted_at` datetime DEFAULT NULL COMMENT '删除时间',
        PRIMARY KEY (`id`)
) ENGINE = InnoDB COMMENT = '接口管理';

-- -----------------------------
-- Table structure for sys_records
-- -----------------------------
DROP TABLE IF EXISTS `sys_records`;
CREATE TABLE `sys_records`  (
       `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键字段',
       `username` varchar(255) NOT NULL DEFAULT '' COMMENT '用户名',
       `user_id` bigint(20) NOT NULL DEFAULT 0 COMMENT '用户ID',
       `description` varchar(255)  NOT NULL DEFAULT '' COMMENT '描述',
       `method` varchar(255)  NOT NULL DEFAULT '' COMMENT '请求方法',
       `path` varchar(255) NOT NULL DEFAULT '' COMMENT '请求路径',
       `status_code` bigint(20) NOT NULL DEFAULT 0 COMMENT '状态码',
       `elapsed` varchar(50) NOT NULL DEFAULT '' COMMENT '耗时',
       `msg` varchar(50) NOT NULL DEFAULT '' COMMENT '返回的msg',
       `request` varchar(2555) NOT NULL DEFAULT '' COMMENT '请求参数',
       `response` varchar(2555) NOT NULL DEFAULT '' COMMENT '返回参数',
       `platform` varchar(50) NOT NULL DEFAULT '' COMMENT '平台',
       `ip` varchar(64) NOT NULL DEFAULT '' COMMENT 'IP',
       `address` varchar(255) NOT NULL DEFAULT '' COMMENT '地址',
       `created_at` datetime DEFAULT NULL COMMENT '创建时间戳',
       `updated_at` datetime DEFAULT NULL COMMENT '修改时间戳',
       `deleted_at` datetime DEFAULT NULL COMMENT '删除时间',
       PRIMARY KEY (`id`)
) ENGINE = InnoDB COMMENT = '操作日志';