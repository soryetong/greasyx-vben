/*
 Navicat Premium Data Transfer

 Source Server         : 127.0.0.1
 Source Server Type    : MySQL
 Source Server Version : 50736 (5.7.36)
 Source Host           : 127.0.0.1:3307
 Source Schema         : greasyx-admin

 Target Server Type    : MySQL
 Target Server Version : 50736 (5.7.36)
 File Encoding         : 65001

 Date: 08/03/2025 17:53:38
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;
    
-- ----------------------------
-- Table structure for casbin_rule
-- ----------------------------
DROP TABLE IF EXISTS `casbin_rule`;
CREATE TABLE `casbin_rule` (
       `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
       `ptype` varchar(100) DEFAULT NULL,
       `v0` varchar(100) DEFAULT NULL,
       `v1` varchar(100) DEFAULT NULL,
       `v2` varchar(100) DEFAULT NULL,
       `v3` varchar(100) DEFAULT NULL,
       `v4` varchar(100) DEFAULT NULL,
       `v5` varchar(100) DEFAULT NULL,
       PRIMARY KEY (`id`),
       UNIQUE KEY `idx_casbin_rule` (`ptype`,`v0`,`v1`,`v2`,`v3`,`v4`,`v5`)
) COMMENT='系统权限表';

-- ----------------------------
-- Records of casbin_rule
-- ----------------------------
BEGIN;
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (1, 'p', '1', '/api/delete/:id', 'DELETE', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (2, 'p', '1', '/api/list', 'GET', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (3, 'p', '1', '/api/update/:id', 'PUT', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (4, 'p', '1', '/auth/login', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (5, 'p', '1', '/dict/add', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (6, 'p', '1', '/dict/delete/:id', 'DELETE', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (7, 'p', '1', '/dict/list', 'GET', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (8, 'p', '1', '/dict/update/:id', 'PUT', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (9, 'p', '1', '/menu/add', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (10, 'p', '1', '/menu/delete/:id', 'DELETE', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (11, 'p', '1', '/menu/info/:id', 'GET', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (12, 'p', '1', '/menu/router', 'GET', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (13, 'p', '1', '/menu/tree', 'GET', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (14, 'p', '1', '/menu/update/:id', 'PUT', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (15, 'p', '1', '/record/delete/:id', 'DELETE', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (16, 'p', '1', '/record/list', 'GET', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (17, 'p', '1', '/role/add', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (18, 'p', '1', '/role/assign/:id', 'PUT', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (19, 'p', '1', '/role/delete/:id', 'DELETE', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (20, 'p', '1', '/role/info/:id', 'GET', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (21, 'p', '1', '/role/list', 'GET', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (22, 'p', '1', '/role/update/:id', 'PUT', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (23, 'p', '1', '/user/add', 'POST', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (24, 'p', '1', '/user/delete/:id', 'DELETE', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (25, 'p', '1', '/user/info', 'GET', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (26, 'p', '1', '/user/list', 'GET', '', '', '');
INSERT INTO `casbin_rule` (`id`, `ptype`, `v0`, `v1`, `v2`, `v3`, `v4`, `v5`) VALUES (27, 'p', '1', '/user/update/:id', 'PUT', '', '', '');
COMMIT;

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

-- ----------------------------
-- Records of sys_users
-- ----------------------------
BEGIN;
INSERT INTO `sys_users` (`id`, `username`, `nickname`, `password`, `salt`, `mobile`, `gender`, `email`, `avatar`, `status`, `dept_id`, `role_id`, `remark`, `create_by`, `update_by`, `last_login_time`, `last_login_ip`, `created_at`, `updated_at`, `deleted_at`) VALUES (1, 'admin', 'admin', '5c14354e49476afde977e6ae340a5a42', 'GVynGR', '', 0, '', '/uploads/default/logo.png', 1, 0, 1, '', 0, 0, 0, '', '2025-03-12 10:50:50', '2025-03-12 10:50:50', NULL);
COMMIT;

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

-- ----------------------------
-- Records of sys_menus
-- ----------------------------
BEGIN;
INSERT INTO `sys_menus` (`id`, `parent_id`, `tree_path`, `name`, `type`, `route_name`, `path`, `component`, `perm`, `status`, `affix_tab`, `hide_children_in_menu`, `hide_in_breadcrumb`, `hide_in_menu`, `hide_in_tab`, `keep_alive`, `sort`, `icon`, `redirect`, `params`, `created_at`, `updated_at`, `deleted_at`) VALUES (1, 0, '', 'page.dashboard.title', 'FOLDER', 'Dashboard', '/', 'BasicLayout', '', 1, 0, 0, 0, 0, 0, 0, 1, 'lucide:layout-dashboard', '', NULL, '2025-03-04 10:27:32', '2025-03-14 17:32:08', NULL);
INSERT INTO `sys_menus` (`id`, `parent_id`, `tree_path`, `name`, `type`, `route_name`, `path`, `component`, `perm`, `status`, `affix_tab`, `hide_children_in_menu`, `hide_in_breadcrumb`, `hide_in_menu`, `hide_in_tab`, `keep_alive`, `sort`, `icon`, `redirect`, `params`, `created_at`, `updated_at`, `deleted_at`) VALUES (2, 1, '', 'page.dashboard.analytics', 'MENU', 'Analytics', '/analytics', '/views/dashboard/analytics/index', '', 1, 0, 0, 0, 0, 0, 0, 2, 'lucide:area-chart', '', NULL, '2025-03-04 10:45:29', '2025-03-04 10:45:29', NULL);
INSERT INTO `sys_menus` (`id`, `parent_id`, `tree_path`, `name`, `type`, `route_name`, `path`, `component`, `perm`, `status`, `affix_tab`, `hide_children_in_menu`, `hide_in_breadcrumb`, `hide_in_menu`, `hide_in_tab`, `keep_alive`, `sort`, `icon`, `redirect`, `params`, `created_at`, `updated_at`, `deleted_at`) VALUES (3, 0, '', 'page.system.title', 'FOLDER', 'System', '/', 'BasicLayout', '', 1, 0, 0, 0, 0, 0, 0, 10, 'lucide:align-start-vertical', '', NULL, '2025-03-03 17:54:39', '2025-03-03 17:54:39', NULL);
INSERT INTO `sys_menus` (`id`, `parent_id`, `tree_path`, `name`, `type`, `route_name`, `path`, `component`, `perm`, `status`, `affix_tab`, `hide_children_in_menu`, `hide_in_breadcrumb`, `hide_in_menu`, `hide_in_tab`, `keep_alive`, `sort`, `icon`, `redirect`, `params`, `created_at`, `updated_at`, `deleted_at`) VALUES (4, 3, '', 'page.system.user.title', 'MENU', 'User', '/system/user', '/views/system/user/index', '', 1, 0, 0, 0, 0, 0, 0, 2, 'lucide:user-round-cog', '', NULL, '2025-03-04 15:35:24', '2025-03-04 15:35:24', NULL);
INSERT INTO `sys_menus` (`id`, `parent_id`, `tree_path`, `name`, `type`, `route_name`, `path`, `component`, `perm`, `status`, `affix_tab`, `hide_children_in_menu`, `hide_in_breadcrumb`, `hide_in_menu`, `hide_in_tab`, `keep_alive`, `sort`, `icon`, `redirect`, `params`, `created_at`, `updated_at`, `deleted_at`) VALUES (5, 3, '', 'page.system.menu.title', 'MENU', 'Menu', '/system/menu', '/views/system/menu/index', '', 1, 0, 0, 0, 0, 0, 0, 3, 'lucide:menu', '', NULL, '2025-03-04 10:25:09', '2025-03-04 17:08:44', NULL);
INSERT INTO `sys_menus` (`id`, `parent_id`, `tree_path`, `name`, `type`, `route_name`, `path`, `component`, `perm`, `status`, `affix_tab`, `hide_children_in_menu`, `hide_in_breadcrumb`, `hide_in_menu`, `hide_in_tab`, `keep_alive`, `sort`, `icon`, `redirect`, `params`, `created_at`, `updated_at`, `deleted_at`) VALUES (7, 3, '', 'page.system.role.title', 'MENU', 'Role', '/system/role', '/views/system/role/index', '', 1, 0, 0, 0, 0, 0, 0, 4, 'lucide:anchor', '', NULL, '2025-03-05 13:41:40', '2025-03-05 13:41:40', NULL);
INSERT INTO `sys_menus` (`id`, `parent_id`, `tree_path`, `name`, `type`, `route_name`, `path`, `component`, `perm`, `status`, `affix_tab`, `hide_children_in_menu`, `hide_in_breadcrumb`, `hide_in_menu`, `hide_in_tab`, `keep_alive`, `sort`, `icon`, `redirect`, `params`, `created_at`, `updated_at`, `deleted_at`) VALUES (8, 4, '', 'page.system.user.button.create', 'BUTTON', 'CreateUser', '', 'BasicLayout', 'system:user:create', 1, 0, 0, 0, 0, 0, 0, 1, '', '', NULL, '2025-03-11 10:12:56', '2025-03-11 10:44:28', NULL);
INSERT INTO `sys_menus` (`id`, `parent_id`, `tree_path`, `name`, `type`, `route_name`, `path`, `component`, `perm`, `status`, `affix_tab`, `hide_children_in_menu`, `hide_in_breadcrumb`, `hide_in_menu`, `hide_in_tab`, `keep_alive`, `sort`, `icon`, `redirect`, `params`, `created_at`, `updated_at`, `deleted_at`) VALUES (9, 4, '', 'page.system.user.button.delete', 'BUTTON', 'DeleteUser', '', 'BasicLayout', 'system:user:delete', 1, 0, 0, 0, 0, 0, 0, 5, '', '', NULL, '2025-03-11 10:27:48', '2025-03-11 10:27:48', NULL);
INSERT INTO `sys_menus` (`id`, `parent_id`, `tree_path`, `name`, `type`, `route_name`, `path`, `component`, `perm`, `status`, `affix_tab`, `hide_children_in_menu`, `hide_in_breadcrumb`, `hide_in_menu`, `hide_in_tab`, `keep_alive`, `sort`, `icon`, `redirect`, `params`, `created_at`, `updated_at`, `deleted_at`) VALUES (10, 4, '', 'page.system.user.button.update', 'BUTTON', 'UpdateUser', '', 'BasicLayout', 'system:user:update', 1, 0, 0, 0, 0, 0, 0, 3, '', '', NULL, '2025-03-11 10:37:15', '2025-03-11 10:37:15', NULL);
INSERT INTO `sys_menus` (`id`, `parent_id`, `tree_path`, `name`, `type`, `route_name`, `path`, `component`, `perm`, `status`, `affix_tab`, `hide_children_in_menu`, `hide_in_breadcrumb`, `hide_in_menu`, `hide_in_tab`, `keep_alive`, `sort`, `icon`, `redirect`, `params`, `created_at`, `updated_at`, `deleted_at`) VALUES (11, 4, '', 'ui.button.search', 'BUTTON', 'SearchUser', '', 'BasicLayout', 'system:user:search', 1, 0, 0, 0, 0, 0, 0, 4, '', '', NULL, '2025-03-11 10:39:56', '2025-03-11 10:39:56', NULL);
INSERT INTO `sys_menus` (`id`, `parent_id`, `tree_path`, `name`, `type`, `route_name`, `path`, `component`, `perm`, `status`, `affix_tab`, `hide_children_in_menu`, `hide_in_breadcrumb`, `hide_in_menu`, `hide_in_tab`, `keep_alive`, `sort`, `icon`, `redirect`, `params`, `created_at`, `updated_at`, `deleted_at`) VALUES (12, 5, '', 'page.system.menu.button.create', 'BUTTON', 'MenuCreate', '', 'BasicLayout', 'system:menu:create', 1, 0, 0, 0, 0, 0, 0, 1, '', '', NULL, '2025-03-11 10:50:08', '2025-03-11 10:50:08', NULL);
INSERT INTO `sys_menus` (`id`, `parent_id`, `tree_path`, `name`, `type`, `route_name`, `path`, `component`, `perm`, `status`, `affix_tab`, `hide_children_in_menu`, `hide_in_breadcrumb`, `hide_in_menu`, `hide_in_tab`, `keep_alive`, `sort`, `icon`, `redirect`, `params`, `created_at`, `updated_at`, `deleted_at`) VALUES (13, 5, '', 'page.system.menu.button.delete', 'BUTTON', 'MenuDelete', '', 'BasicLayout', 'system:menu:delete', 1, 0, 0, 0, 0, 0, 0, 2, '', '', NULL, '2025-03-11 10:51:10', '2025-03-11 10:51:10', NULL);
INSERT INTO `sys_menus` (`id`, `parent_id`, `tree_path`, `name`, `type`, `route_name`, `path`, `component`, `perm`, `status`, `affix_tab`, `hide_children_in_menu`, `hide_in_breadcrumb`, `hide_in_menu`, `hide_in_tab`, `keep_alive`, `sort`, `icon`, `redirect`, `params`, `created_at`, `updated_at`, `deleted_at`) VALUES (14, 5, '', 'page.system.menu.button.update', 'BUTTON', 'MenuUpdate', '', 'BasicLayout', 'system:menu:update', 1, 0, 0, 0, 0, 0, 0, 0, '', '', NULL, '2025-03-11 11:57:17', '2025-03-11 11:57:17', NULL);
INSERT INTO `sys_menus` (`id`, `parent_id`, `tree_path`, `name`, `type`, `route_name`, `path`, `component`, `perm`, `status`, `affix_tab`, `hide_children_in_menu`, `hide_in_breadcrumb`, `hide_in_menu`, `hide_in_tab`, `keep_alive`, `sort`, `icon`, `redirect`, `params`, `created_at`, `updated_at`, `deleted_at`) VALUES (15, 5, '', 'ui.button.search', 'BUTTON', 'MenuSearch', '', 'BasicLayout', 'system:menu:search', 1, 0, 0, 0, 0, 0, 0, 0, '', '', NULL, '2025-03-11 11:57:48', '2025-03-11 11:57:48', NULL);
INSERT INTO `sys_menus` (`id`, `parent_id`, `tree_path`, `name`, `type`, `route_name`, `path`, `component`, `perm`, `status`, `affix_tab`, `hide_children_in_menu`, `hide_in_breadcrumb`, `hide_in_menu`, `hide_in_tab`, `keep_alive`, `sort`, `icon`, `redirect`, `params`, `created_at`, `updated_at`, `deleted_at`) VALUES (16, 7, '', 'page.system.role.button.create', 'BUTTON', 'RoleCreate', '', 'BasicLayout', 'system:role:create', 1, 0, 0, 0, 0, 0, 0, 0, '', '', NULL, '2025-03-12 17:12:14', '2025-03-12 17:12:14', NULL);
INSERT INTO `sys_menus` (`id`, `parent_id`, `tree_path`, `name`, `type`, `route_name`, `path`, `component`, `perm`, `status`, `affix_tab`, `hide_children_in_menu`, `hide_in_breadcrumb`, `hide_in_menu`, `hide_in_tab`, `keep_alive`, `sort`, `icon`, `redirect`, `params`, `created_at`, `updated_at`, `deleted_at`) VALUES (17, 7, '', 'page.system.role.button.delete', 'BUTTON', 'RoleDelete', '', 'BasicLayout', 'system:role:delete', 1, 0, 0, 0, 0, 0, 0, 0, '', '', NULL, '2025-03-12 17:12:44', '2025-03-12 17:12:44', NULL);
INSERT INTO `sys_menus` (`id`, `parent_id`, `tree_path`, `name`, `type`, `route_name`, `path`, `component`, `perm`, `status`, `affix_tab`, `hide_children_in_menu`, `hide_in_breadcrumb`, `hide_in_menu`, `hide_in_tab`, `keep_alive`, `sort`, `icon`, `redirect`, `params`, `created_at`, `updated_at`, `deleted_at`) VALUES (18, 7, '', 'page.system.role.button.update', 'BUTTON', 'RoleUpdate', '', 'BasicLayout', 'system:role:update', 1, 0, 0, 0, 0, 0, 0, 0, '', '', NULL, '2025-03-12 17:13:09', '2025-03-12 17:13:09', NULL);
INSERT INTO `sys_menus` (`id`, `parent_id`, `tree_path`, `name`, `type`, `route_name`, `path`, `component`, `perm`, `status`, `affix_tab`, `hide_children_in_menu`, `hide_in_breadcrumb`, `hide_in_menu`, `hide_in_tab`, `keep_alive`, `sort`, `icon`, `redirect`, `params`, `created_at`, `updated_at`, `deleted_at`) VALUES (19, 7, '', 'ui.button.search', 'BUTTON', 'RoleSearch', '', 'BasicLayout', 'system:role:search', 1, 0, 0, 0, 0, 0, 0, 0, '', '', NULL, '2025-03-12 17:13:31', '2025-03-12 17:13:31', NULL);
INSERT INTO `sys_menus` (`id`, `parent_id`, `tree_path`, `name`, `type`, `route_name`, `path`, `component`, `perm`, `status`, `affix_tab`, `hide_children_in_menu`, `hide_in_breadcrumb`, `hide_in_menu`, `hide_in_tab`, `keep_alive`, `sort`, `icon`, `redirect`, `params`, `created_at`, `updated_at`, `deleted_at`) VALUES (20, 3, '', 'page.system.api.title', 'MENU', 'Api', '/system/api', '/views/system/api/index', '', 1, 0, 0, 0, 0, 0, 0, 0, 'lucide:atom', '', NULL, '2025-03-13 13:50:45', '2025-03-13 13:50:45', NULL);
INSERT INTO `sys_menus` (`id`, `parent_id`, `tree_path`, `name`, `type`, `route_name`, `path`, `component`, `perm`, `status`, `affix_tab`, `hide_children_in_menu`, `hide_in_breadcrumb`, `hide_in_menu`, `hide_in_tab`, `keep_alive`, `sort`, `icon`, `redirect`, `params`, `created_at`, `updated_at`, `deleted_at`) VALUES (21, 20, '', 'page.system.api.button.create', 'BUTTON', 'ApiCreate', '', 'BasicLayout', 'system:api:create', 1, 0, 0, 0, 0, 0, 0, 0, '', '', NULL, '2025-03-13 13:51:50', '2025-03-13 13:51:50', NULL);
INSERT INTO `sys_menus` (`id`, `parent_id`, `tree_path`, `name`, `type`, `route_name`, `path`, `component`, `perm`, `status`, `affix_tab`, `hide_children_in_menu`, `hide_in_breadcrumb`, `hide_in_menu`, `hide_in_tab`, `keep_alive`, `sort`, `icon`, `redirect`, `params`, `created_at`, `updated_at`, `deleted_at`) VALUES (22, 20, '', 'page.system.api.button.delete', 'BUTTON', 'ApiDelete', '', 'BasicLayout', 'system:api:delete', 1, 0, 0, 0, 0, 0, 0, 0, '', '', NULL, '2025-03-13 13:52:19', '2025-03-13 13:52:19', NULL);
INSERT INTO `sys_menus` (`id`, `parent_id`, `tree_path`, `name`, `type`, `route_name`, `path`, `component`, `perm`, `status`, `affix_tab`, `hide_children_in_menu`, `hide_in_breadcrumb`, `hide_in_menu`, `hide_in_tab`, `keep_alive`, `sort`, `icon`, `redirect`, `params`, `created_at`, `updated_at`, `deleted_at`) VALUES (23, 20, '', 'page.system.api.button.update', 'BUTTON', 'ApiUpdate', '', 'BasicLayout', 'system:api:update', 1, 0, 0, 0, 0, 0, 0, 0, '', '', NULL, '2025-03-13 13:52:48', '2025-03-13 13:52:48', NULL);
INSERT INTO `sys_menus` (`id`, `parent_id`, `tree_path`, `name`, `type`, `route_name`, `path`, `component`, `perm`, `status`, `affix_tab`, `hide_children_in_menu`, `hide_in_breadcrumb`, `hide_in_menu`, `hide_in_tab`, `keep_alive`, `sort`, `icon`, `redirect`, `params`, `created_at`, `updated_at`, `deleted_at`) VALUES (24, 20, '', 'ui.button.search', 'BUTTON', 'ApiSearch', '', 'BasicLayout', 'system:api:search', 1, 0, 0, 0, 0, 0, 0, 0, '', '', NULL, '2025-03-13 13:53:15', '2025-03-13 13:53:15', NULL);
INSERT INTO `sys_menus` (`id`, `parent_id`, `tree_path`, `name`, `type`, `route_name`, `path`, `component`, `perm`, `status`, `affix_tab`, `hide_children_in_menu`, `hide_in_breadcrumb`, `hide_in_menu`, `hide_in_tab`, `keep_alive`, `sort`, `icon`, `redirect`, `params`, `created_at`, `updated_at`, `deleted_at`) VALUES (25, 3, '', 'page.system.dict.title', 'MENU', 'Dict', '/system/dict', '/views/system/dict/index', '', 1, 0, 0, 0, 0, 0, 0, 0, 'lucide:book-open-text', '', NULL, '2025-03-13 16:40:28', '2025-03-13 16:40:28', NULL);
INSERT INTO `sys_menus` (`id`, `parent_id`, `tree_path`, `name`, `type`, `route_name`, `path`, `component`, `perm`, `status`, `affix_tab`, `hide_children_in_menu`, `hide_in_breadcrumb`, `hide_in_menu`, `hide_in_tab`, `keep_alive`, `sort`, `icon`, `redirect`, `params`, `created_at`, `updated_at`, `deleted_at`) VALUES (26, 25, '', 'page.system.dict.button.create', 'BUTTON', 'DictCreate', '', 'BasicLayout', 'system:dict:create', 1, 0, 0, 0, 0, 0, 0, 0, '', '', NULL, '2025-03-13 16:47:13', '2025-03-13 16:47:13', NULL);
INSERT INTO `sys_menus` (`id`, `parent_id`, `tree_path`, `name`, `type`, `route_name`, `path`, `component`, `perm`, `status`, `affix_tab`, `hide_children_in_menu`, `hide_in_breadcrumb`, `hide_in_menu`, `hide_in_tab`, `keep_alive`, `sort`, `icon`, `redirect`, `params`, `created_at`, `updated_at`, `deleted_at`) VALUES (27, 25, '', 'page.system.dict.button.delete', 'BUTTON', 'DictDelete', '', 'BasicLayout', 'system:dict:delete', 1, 0, 0, 0, 0, 0, 0, 0, '', '', NULL, '2025-03-13 16:47:38', '2025-03-13 16:47:38', NULL);
INSERT INTO `sys_menus` (`id`, `parent_id`, `tree_path`, `name`, `type`, `route_name`, `path`, `component`, `perm`, `status`, `affix_tab`, `hide_children_in_menu`, `hide_in_breadcrumb`, `hide_in_menu`, `hide_in_tab`, `keep_alive`, `sort`, `icon`, `redirect`, `params`, `created_at`, `updated_at`, `deleted_at`) VALUES (28, 25, '', 'page.system.dict.button.update', 'BUTTON', 'DictUpdate', '', 'BasicLayout', 'system:dict:update', 1, 0, 0, 0, 0, 0, 0, 0, '', '', NULL, '2025-03-13 16:48:08', '2025-03-13 16:48:08', NULL);
INSERT INTO `sys_menus` (`id`, `parent_id`, `tree_path`, `name`, `type`, `route_name`, `path`, `component`, `perm`, `status`, `affix_tab`, `hide_children_in_menu`, `hide_in_breadcrumb`, `hide_in_menu`, `hide_in_tab`, `keep_alive`, `sort`, `icon`, `redirect`, `params`, `created_at`, `updated_at`, `deleted_at`) VALUES (29, 25, '', 'ui.button.search', 'BUTTON', 'DictSearch', '', 'BasicLayout', 'system:dict:search', 1, 0, 0, 0, 0, 0, 0, 0, '', '', NULL, '2025-03-13 16:48:29', '2025-03-13 16:48:29', NULL);
INSERT INTO `sys_menus` (`id`, `parent_id`, `tree_path`, `name`, `type`, `route_name`, `path`, `component`, `perm`, `status`, `affix_tab`, `hide_children_in_menu`, `hide_in_breadcrumb`, `hide_in_menu`, `hide_in_tab`, `keep_alive`, `sort`, `icon`, `redirect`, `params`, `created_at`, `updated_at`, `deleted_at`) VALUES (30, 3, '', 'page.system.record.title', 'MENU', 'RecordList', '/system/record', '/views/system/record/index', '', 1, 0, 0, 0, 0, 0, 0, 0, 'lucide:arrow-left-right', '', NULL, '2025-03-14 16:09:56', '2025-03-14 16:09:56', NULL);
INSERT INTO `sys_menus` (`id`, `parent_id`, `tree_path`, `name`, `type`, `route_name`, `path`, `component`, `perm`, `status`, `affix_tab`, `hide_children_in_menu`, `hide_in_breadcrumb`, `hide_in_menu`, `hide_in_tab`, `keep_alive`, `sort`, `icon`, `redirect`, `params`, `created_at`, `updated_at`, `deleted_at`) VALUES (31, 30, '', 'page.system.record.button.delete', 'BUTTON', 'RecordDelete', '', 'BasicLayout', 'system:record:delete', 1, 0, 0, 0, 0, 0, 0, 0, '', '', NULL, '2025-03-14 17:33:55', '2025-03-14 17:33:55', NULL);
COMMIT;

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
      PRIMARY KEY (`id`),
      UNIQUE KEY `uidx_code` (`code`)
) ENGINE = InnoDB COMMENT = '角色管理';

-- ----------------------------
-- Records of sys_roles
-- ----------------------------
BEGIN;
INSERT INTO `sys_roles` (`id`, `name`, `code`, `sort`, `status`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (1, '超级管理员', 'super', 0, 1, '', '2025-03-05 16:02:41', '2025-03-06 17:29:27', NULL);
COMMIT;

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

-- ----------------------------
-- Records of sys_role_auths
-- ----------------------------
BEGIN;
INSERT INTO `sys_role_auths` (`id`, `role_id`, `auth_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (1, 1, 1, '2025-03-05 18:02:41', '2025-03-05 18:02:41', NULL);
INSERT INTO `sys_role_auths` (`id`, `role_id`, `auth_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (2, 1, 2, '2025-03-05 18:02:41', '2025-03-05 18:02:41', NULL);
INSERT INTO `sys_role_auths` (`id`, `role_id`, `auth_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (3, 1, 3, '2025-03-05 18:02:41', '2025-03-05 18:02:41', NULL);
INSERT INTO `sys_role_auths` (`id`, `role_id`, `auth_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (4, 1, 4, '2025-03-05 18:02:41', '2025-03-05 18:02:41', NULL);
INSERT INTO `sys_role_auths` (`id`, `role_id`, `auth_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (5, 1, 8, '2025-03-05 18:02:41', '2025-03-05 18:02:41', NULL);
INSERT INTO `sys_role_auths` (`id`, `role_id`, `auth_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (6, 1, 9, '2025-03-05 18:02:41', '2025-03-05 18:02:41', NULL);
INSERT INTO `sys_role_auths` (`id`, `role_id`, `auth_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (7, 1, 10, '2025-03-05 18:02:41', '2025-03-05 18:02:41', NULL);
INSERT INTO `sys_role_auths` (`id`, `role_id`, `auth_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (8, 1, 11, '2025-03-05 18:02:41', '2025-03-05 18:02:41', NULL);
INSERT INTO `sys_role_auths` (`id`, `role_id`, `auth_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (9, 1, 5, '2025-03-05 18:02:41', '2025-03-05 18:02:41', NULL);
INSERT INTO `sys_role_auths` (`id`, `role_id`, `auth_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (10, 1, 12, '2025-03-05 18:02:41', '2025-03-05 18:02:41', NULL);
INSERT INTO `sys_role_auths` (`id`, `role_id`, `auth_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (11, 1, 13, '2025-03-05 18:02:41', '2025-03-05 18:02:41', NULL);
INSERT INTO `sys_role_auths` (`id`, `role_id`, `auth_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (12, 1, 14, '2025-03-05 18:02:41', '2025-03-05 18:02:41', NULL);
INSERT INTO `sys_role_auths` (`id`, `role_id`, `auth_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (13, 1, 15, '2025-03-05 18:02:41', '2025-03-05 18:02:41', NULL);
INSERT INTO `sys_role_auths` (`id`, `role_id`, `auth_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (14, 1, 7, '2025-03-05 18:02:41', '2025-03-05 18:02:41', NULL);
INSERT INTO `sys_role_auths` (`id`, `role_id`, `auth_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (15, 1, 16, '2025-03-05 18:02:41', '2025-03-05 18:02:41', NULL);
INSERT INTO `sys_role_auths` (`id`, `role_id`, `auth_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (16, 1, 17, '2025-03-05 18:02:41', '2025-03-05 18:02:41', NULL);
INSERT INTO `sys_role_auths` (`id`, `role_id`, `auth_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (17, 1, 18, '2025-03-05 18:02:41', '2025-03-05 18:02:41', NULL);
INSERT INTO `sys_role_auths` (`id`, `role_id`, `auth_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (18, 1, 19, '2025-03-05 18:02:41', '2025-03-05 18:02:41', NULL);
INSERT INTO `sys_role_auths` (`id`, `role_id`, `auth_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (19, 1, 20, '2025-03-05 18:02:41', '2025-03-05 18:02:41', NULL);
INSERT INTO `sys_role_auths` (`id`, `role_id`, `auth_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (20, 1, 21, '2025-03-05 18:02:41', '2025-03-05 18:02:41', NULL);
INSERT INTO `sys_role_auths` (`id`, `role_id`, `auth_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (21, 1, 22, '2025-03-05 18:02:41', '2025-03-05 18:02:41', NULL);
INSERT INTO `sys_role_auths` (`id`, `role_id`, `auth_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (22, 1, 23, '2025-03-05 18:02:41', '2025-03-05 18:02:41', NULL);
INSERT INTO `sys_role_auths` (`id`, `role_id`, `auth_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (23, 1, 24, '2025-03-05 18:02:41', '2025-03-05 18:02:41', NULL);
INSERT INTO `sys_role_auths` (`id`, `role_id`, `auth_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (24, 1, 25, '2025-03-05 18:02:41', '2025-03-05 18:02:41', NULL);
INSERT INTO `sys_role_auths` (`id`, `role_id`, `auth_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (25, 1, 26, '2025-03-05 18:02:41', '2025-03-05 18:02:41', NULL);
INSERT INTO `sys_role_auths` (`id`, `role_id`, `auth_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (26, 1, 27, '2025-03-05 18:02:41', '2025-03-05 18:02:41', NULL);
INSERT INTO `sys_role_auths` (`id`, `role_id`, `auth_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (27, 1, 28, '2025-03-05 18:02:41', '2025-03-05 18:02:41', NULL);
INSERT INTO `sys_role_auths` (`id`, `role_id`, `auth_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (28, 1, 29, '2025-03-05 18:02:41', '2025-03-05 18:02:41', NULL);
INSERT INTO `sys_role_auths` (`id`, `role_id`, `auth_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (29, 1, 30, '2025-03-05 18:02:41', '2025-03-05 18:02:41', NULL);
INSERT INTO `sys_role_auths` (`id`, `role_id`, `auth_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (30, 1, 31, '2025-03-05 18:02:41', '2025-03-05 18:02:41', NULL);
COMMIT;

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
       PRIMARY KEY (`id`),
       KEY `idx_description` (`description`)
) ENGINE = InnoDB COMMENT = '接口管理';

-- ----------------------------
-- Records of sys_apis
-- ----------------------------
BEGIN;
INSERT INTO `sys_apis` (`id`, `parent_id`, `description`, `method`, `path`, `created_at`, `updated_at`, `deleted_at`) VALUES (1, 0, 'Base组', '', '', '2025-03-06 10:21:25', '2025-03-06 10:21:25', NULL);
INSERT INTO `sys_apis` (`id`, `parent_id`, `description`, `method`, `path`, `created_at`, `updated_at`, `deleted_at`) VALUES (2, 1, '用户登录', 'POST', '/auth/login', '2025-03-06 10:22:03', '2025-03-06 10:22:03', NULL);
INSERT INTO `sys_apis` (`id`, `parent_id`, `description`, `method`, `path`, `created_at`, `updated_at`, `deleted_at`) VALUES (3, 1, '用户信息', 'GET', '/user/info', '2025-03-06 10:23:05', '2025-03-06 10:23:05', NULL);
INSERT INTO `sys_apis` (`id`, `parent_id`, `description`, `method`, `path`, `created_at`, `updated_at`, `deleted_at`) VALUES (4, 0, '系统用户管理', '', '', '2025-03-06 13:38:16', '2025-03-06 13:38:16', NULL);
INSERT INTO `sys_apis` (`id`, `parent_id`, `description`, `method`, `path`, `created_at`, `updated_at`, `deleted_at`) VALUES (5, 4, '新增管理员', 'POST', '/user/add', '2025-03-06 13:39:32', '2025-03-06 13:39:32', NULL);
INSERT INTO `sys_apis` (`id`, `parent_id`, `description`, `method`, `path`, `created_at`, `updated_at`, `deleted_at`) VALUES (6, 4, '管理员列表', 'GET', '/user/list', '2025-03-06 13:39:51', '2025-03-06 13:39:51', NULL);
INSERT INTO `sys_apis` (`id`, `parent_id`, `description`, `method`, `path`, `created_at`, `updated_at`, `deleted_at`) VALUES (7, 4, '修改管理员', 'PUT', '/user/update/:id', '2025-03-06 13:40:11', '2025-03-06 13:40:11', NULL);
INSERT INTO `sys_apis` (`id`, `parent_id`, `description`, `method`, `path`, `created_at`, `updated_at`, `deleted_at`) VALUES (8, 4, '删除管理员', 'DELETE', '/user/delete/:id', '2025-03-06 13:40:27', '2025-03-06 13:40:27', NULL);
INSERT INTO `sys_apis` (`id`, `parent_id`, `description`, `method`, `path`, `created_at`, `updated_at`, `deleted_at`) VALUES (9, 0, '系统菜单管理', '', '', '2025-03-06 13:40:45', '2025-03-06 13:40:45', NULL);
INSERT INTO `sys_apis` (`id`, `parent_id`, `description`, `method`, `path`, `created_at`, `updated_at`, `deleted_at`) VALUES (10, 1, '当前用户可用的菜单', 'GET', '/menu/router', '2025-03-06 13:41:32', '2025-03-06 13:41:32', NULL);
INSERT INTO `sys_apis` (`id`, `parent_id`, `description`, `method`, `path`, `created_at`, `updated_at`, `deleted_at`) VALUES (11, 9, '菜单树', 'GET', '/menu/tree', '2025-03-06 13:41:52', '2025-03-06 13:41:52', NULL);
INSERT INTO `sys_apis` (`id`, `parent_id`, `description`, `method`, `path`, `created_at`, `updated_at`, `deleted_at`) VALUES (12, 9, '添加菜单', 'POST', '/menu/add', '2025-03-06 13:42:07', '2025-03-06 13:42:07', NULL);
INSERT INTO `sys_apis` (`id`, `parent_id`, `description`, `method`, `path`, `created_at`, `updated_at`, `deleted_at`) VALUES (13, 9, '修改菜单', 'PUT', '/menu/update/:id', '2025-03-06 13:42:28', '2025-03-06 13:42:28', NULL);
INSERT INTO `sys_apis` (`id`, `parent_id`, `description`, `method`, `path`, `created_at`, `updated_at`, `deleted_at`) VALUES (14, 9, '获取菜单数据', 'GET', '/menu/info/:id', '2025-03-06 13:42:44', '2025-03-06 13:42:44', NULL);
INSERT INTO `sys_apis` (`id`, `parent_id`, `description`, `method`, `path`, `created_at`, `updated_at`, `deleted_at`) VALUES (15, 9, '删除菜单', 'DELETE', '/menu/delete/:id', '2025-03-06 13:42:59', '2025-03-06 13:42:59', NULL);
INSERT INTO `sys_apis` (`id`, `parent_id`, `description`, `method`, `path`, `created_at`, `updated_at`, `deleted_at`) VALUES (16, 0, '系统角色管理', '', '', '2025-03-06 13:45:04', '2025-03-06 13:45:04', NULL);
INSERT INTO `sys_apis` (`id`, `parent_id`, `description`, `method`, `path`, `created_at`, `updated_at`, `deleted_at`) VALUES (17, 16, '新增角色', 'POST', '/role/add', '2025-03-06 13:46:01', '2025-03-06 13:46:01', NULL);
INSERT INTO `sys_apis` (`id`, `parent_id`, `description`, `method`, `path`, `created_at`, `updated_at`, `deleted_at`) VALUES (18, 16, '角色列表', 'GET', '/role/list', '2025-03-06 13:46:16', '2025-03-06 13:46:16', NULL);
INSERT INTO `sys_apis` (`id`, `parent_id`, `description`, `method`, `path`, `created_at`, `updated_at`, `deleted_at`) VALUES (19, 16, '角色信息', 'GET', '/role/info/:id', '2025-03-06 13:47:08', '2025-03-06 13:47:08', NULL);
INSERT INTO `sys_apis` (`id`, `parent_id`, `description`, `method`, `path`, `created_at`, `updated_at`, `deleted_at`) VALUES (20, 16, '角色修改', 'PUT', '/role/update/:id', '2025-03-06 13:47:24', '2025-03-06 13:47:24', NULL);
INSERT INTO `sys_apis` (`id`, `parent_id`, `description`, `method`, `path`, `created_at`, `updated_at`, `deleted_at`) VALUES (21, 16, '给角色分配权限', 'PUT', '/role/assign/:id', '2025-03-06 13:47:42', '2025-03-06 13:47:42', NULL);
INSERT INTO `sys_apis` (`id`, `parent_id`, `description`, `method`, `path`, `created_at`, `updated_at`, `deleted_at`) VALUES (22, 16, '删除角色', 'DELETE', '/role/delete/:id', '2025-03-06 13:47:57', '2025-03-06 13:47:57', NULL);
INSERT INTO `sys_apis` (`id`, `parent_id`, `description`, `method`, `path`, `created_at`, `updated_at`, `deleted_at`) VALUES (23, 0, '系统API管理', '', '', '2025-03-06 13:48:27', '2025-03-06 13:48:27', NULL);
INSERT INTO `sys_apis` (`id`, `parent_id`, `description`, `method`, `path`, `created_at`, `updated_at`, `deleted_at`) VALUES (24, 23, '新增接口', 'POST', '/api/add', '2025-03-06 13:48:50', '2025-03-06 13:48:50', NULL);
INSERT INTO `sys_apis` (`id`, `parent_id`, `description`, `method`, `path`, `created_at`, `updated_at`, `deleted_at`) VALUES (25, 23, '接口列表', 'GET', '/api/list', '2025-03-06 13:49:14', '2025-03-06 13:49:14', NULL);
INSERT INTO `sys_apis` (`id`, `parent_id`, `description`, `method`, `path`, `created_at`, `updated_at`, `deleted_at`) VALUES (26, 23, '修改接口', 'PUT', '/api/update/:id', '2025-03-06 13:50:26', '2025-03-06 13:50:26', NULL);
INSERT INTO `sys_apis` (`id`, `parent_id`, `description`, `method`, `path`, `created_at`, `updated_at`, `deleted_at`) VALUES (27, 23, '删除接口', 'DELETE', '/api/delete/:id', '2025-03-06 13:50:42', '2025-03-06 13:50:42', NULL);
INSERT INTO `sys_apis` (`id`, `parent_id`, `description`, `method`, `path`, `created_at`, `updated_at`, `deleted_at`) VALUES (28, 0, '系统字典管理', '', '', '2025-03-06 13:50:55', '2025-03-06 13:50:55', NULL);
INSERT INTO `sys_apis` (`id`, `parent_id`, `description`, `method`, `path`, `created_at`, `updated_at`, `deleted_at`) VALUES (29, 28, '新增条目', 'POST', '/dict/add', '2025-03-06 13:51:17', '2025-03-06 13:51:17', NULL);
INSERT INTO `sys_apis` (`id`, `parent_id`, `description`, `method`, `path`, `created_at`, `updated_at`, `deleted_at`) VALUES (30, 28, '字典列表', 'GET', '/dict/list', '2025-03-06 13:51:31', '2025-03-06 13:51:31', NULL);
INSERT INTO `sys_apis` (`id`, `parent_id`, `description`, `method`, `path`, `created_at`, `updated_at`, `deleted_at`) VALUES (31, 28, '修改字典', 'PUT', '/dict/update/:id', '2025-03-06 13:51:46', '2025-03-06 13:51:46', NULL);
INSERT INTO `sys_apis` (`id`, `parent_id`, `description`, `method`, `path`, `created_at`, `updated_at`, `deleted_at`) VALUES (32, 28, '删除字典', 'DELETE', '/dict/delete/:id', '2025-03-06 13:52:04', '2025-03-06 13:52:04', NULL);
INSERT INTO `sys_apis` (`id`, `parent_id`, `description`, `method`, `path`, `created_at`, `updated_at`, `deleted_at`) VALUES (33, 0, '系统日志管理', '', '', '2025-03-06 13:52:14', '2025-03-06 14:00:24', NULL);
INSERT INTO `sys_apis` (`id`, `parent_id`, `description`, `method`, `path`, `created_at`, `updated_at`, `deleted_at`) VALUES (34, 33, '日志列表', 'GET', '/record/list', '2025-03-06 13:52:27', '2025-03-06 13:52:27', NULL);
INSERT INTO `sys_apis` (`id`, `parent_id`, `description`, `method`, `path`, `created_at`, `updated_at`, `deleted_at`) VALUES (35, 33, '日志删除', 'DELETE', '/record/delete/:id', '2025-03-06 13:52:43', '2025-03-06 13:52:43', NULL);
COMMIT;

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

-- ----------------------------
-- Records of sys_role_apis
-- ----------------------------
BEGIN;
INSERT INTO `sys_role_apis` (`id`, `role_id`, `api_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (1, 1, 1, '2025-03-06 17:29:03', '2025-03-06 17:29:03', NULL);
INSERT INTO `sys_role_apis` (`id`, `role_id`, `api_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (2, 1, 2, '2025-03-06 17:29:03', '2025-03-06 17:29:03', NULL);
INSERT INTO `sys_role_apis` (`id`, `role_id`, `api_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (3, 1, 3, '2025-03-06 17:29:03', '2025-03-06 17:29:03', NULL);
INSERT INTO `sys_role_apis` (`id`, `role_id`, `api_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (4, 1, 4, '2025-03-06 17:29:03', '2025-03-06 17:29:03', NULL);
INSERT INTO `sys_role_apis` (`id`, `role_id`, `api_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (5, 1, 5, '2025-03-06 17:29:03', '2025-03-06 17:29:03', NULL);
INSERT INTO `sys_role_apis` (`id`, `role_id`, `api_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (6, 1, 6, '2025-03-06 17:29:03', '2025-03-06 17:29:03', NULL);
INSERT INTO `sys_role_apis` (`id`, `role_id`, `api_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (7, 1, 7, '2025-03-06 17:29:03', '2025-03-06 17:29:03', NULL);
INSERT INTO `sys_role_apis` (`id`, `role_id`, `api_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (8, 1, 8, '2025-03-06 17:29:03', '2025-03-06 17:29:03', NULL);
INSERT INTO `sys_role_apis` (`id`, `role_id`, `api_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (9, 1, 9, '2025-03-06 17:29:03', '2025-03-06 17:29:03', NULL);
INSERT INTO `sys_role_apis` (`id`, `role_id`, `api_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (10, 1, 10, '2025-03-06 17:29:03', '2025-03-06 17:29:03', NULL);
INSERT INTO `sys_role_apis` (`id`, `role_id`, `api_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (11, 1, 11, '2025-03-06 17:29:03', '2025-03-06 17:29:03', NULL);
INSERT INTO `sys_role_apis` (`id`, `role_id`, `api_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (12, 1, 12, '2025-03-06 17:29:03', '2025-03-06 17:29:03', NULL);
INSERT INTO `sys_role_apis` (`id`, `role_id`, `api_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (13, 1, 13, '2025-03-06 17:29:03', '2025-03-06 17:29:03', NULL);
INSERT INTO `sys_role_apis` (`id`, `role_id`, `api_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (14, 1, 14, '2025-03-06 17:29:03', '2025-03-06 17:29:03', NULL);
INSERT INTO `sys_role_apis` (`id`, `role_id`, `api_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (15, 1, 15, '2025-03-06 17:29:03', '2025-03-06 17:29:03', NULL);
INSERT INTO `sys_role_apis` (`id`, `role_id`, `api_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (16, 1, 16, '2025-03-06 17:29:03', '2025-03-06 17:29:03', NULL);
INSERT INTO `sys_role_apis` (`id`, `role_id`, `api_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (17, 1, 17, '2025-03-06 17:29:03', '2025-03-06 17:29:03', NULL);
INSERT INTO `sys_role_apis` (`id`, `role_id`, `api_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (18, 1, 18, '2025-03-06 17:29:03', '2025-03-06 17:29:03', NULL);
INSERT INTO `sys_role_apis` (`id`, `role_id`, `api_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (19, 1, 19, '2025-03-06 17:29:03', '2025-03-06 17:29:03', NULL);
INSERT INTO `sys_role_apis` (`id`, `role_id`, `api_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (20, 1, 20, '2025-03-06 17:29:03', '2025-03-06 17:29:03', NULL);
INSERT INTO `sys_role_apis` (`id`, `role_id`, `api_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (21, 1, 21, '2025-03-06 17:29:03', '2025-03-06 17:29:03', NULL);
INSERT INTO `sys_role_apis` (`id`, `role_id`, `api_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (22, 1, 22, '2025-03-06 17:29:03', '2025-03-06 17:29:03', NULL);
INSERT INTO `sys_role_apis` (`id`, `role_id`, `api_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (23, 1, 23, '2025-03-06 17:29:03', '2025-03-06 17:29:03', NULL);
INSERT INTO `sys_role_apis` (`id`, `role_id`, `api_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (24, 1, 24, '2025-03-06 17:29:03', '2025-03-06 17:29:03', NULL);
INSERT INTO `sys_role_apis` (`id`, `role_id`, `api_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (25, 1, 25, '2025-03-06 17:29:03', '2025-03-06 17:29:03', NULL);
INSERT INTO `sys_role_apis` (`id`, `role_id`, `api_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (26, 1, 26, '2025-03-06 17:29:03', '2025-03-06 17:29:03', NULL);
INSERT INTO `sys_role_apis` (`id`, `role_id`, `api_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (27, 1, 27, '2025-03-06 17:29:03', '2025-03-06 17:29:03', NULL);
INSERT INTO `sys_role_apis` (`id`, `role_id`, `api_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (28, 1, 28, '2025-03-06 17:29:03', '2025-03-06 17:29:03', NULL);
INSERT INTO `sys_role_apis` (`id`, `role_id`, `api_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (29, 1, 29, '2025-03-06 17:29:03', '2025-03-06 17:29:03', NULL);
INSERT INTO `sys_role_apis` (`id`, `role_id`, `api_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (30, 1, 30, '2025-03-06 17:29:03', '2025-03-06 17:29:03', NULL);
INSERT INTO `sys_role_apis` (`id`, `role_id`, `api_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (31, 1, 31, '2025-03-06 17:29:03', '2025-03-06 17:29:03', NULL);
INSERT INTO `sys_role_apis` (`id`, `role_id`, `api_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (32, 1, 32, '2025-03-06 17:29:03', '2025-03-06 17:29:03', NULL);
INSERT INTO `sys_role_apis` (`id`, `role_id`, `api_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (33, 1, 33, '2025-03-06 17:29:03', '2025-03-06 17:29:03', NULL);
INSERT INTO `sys_role_apis` (`id`, `role_id`, `api_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (34, 1, 34, '2025-03-06 17:29:03', '2025-03-06 17:29:03', NULL);
INSERT INTO `sys_role_apis` (`id`, `role_id`, `api_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (35, 1, 35, '2025-03-06 17:29:03', '2025-03-06 17:29:03', NULL);
COMMIT;

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
       PRIMARY KEY (`id`),
       KEY `idx_dict_name` (`dict_name`),
       KEY `idx_dict_type` (`dict_type`)
) ENGINE = InnoDB COMMENT = '数据字典';

-- ----------------------------
-- Records of sys_dicts
-- ----------------------------
BEGIN;
INSERT INTO `sys_dicts` (`id`, `dict_name`, `dict_type`, `item_key`, `item_value`, `sort`, `status`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (1, '性别', 'gender', 'man', '1', 0, 1, '男性', '2025-03-07 17:33:06', '2025-03-07 17:33:06', NULL);
INSERT INTO `sys_dicts` (`id`, `dict_name`, `dict_type`, `item_key`, `item_value`, `sort`, `status`, `remark`, `created_at`, `updated_at`, `deleted_at`) VALUES (2, '性别', 'gender', 'woman', '2', 0, 1, '女性', '2025-03-07 17:33:21', '2025-03-07 17:33:21', NULL);
COMMIT;

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

SET FOREIGN_KEY_CHECKS = 1;