/*
Navicat MySQL Data Transfer

Source Server         : 本地
Source Server Version : 50553
Source Host           : localhost:3306
Source Database       : apiadmin

Target Server Type    : MYSQL
Target Server Version : 50553
File Encoding         : 65001

Date: 2019-07-28 01:04:25
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `admin_app`
-- ----------------------------
DROP TABLE IF EXISTS `admin_app`;
CREATE TABLE `admin_app` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_id` varchar(50) NOT NULL DEFAULT '' COMMENT '应用id',
  `app_secret` varchar(50) NOT NULL DEFAULT '' COMMENT '应用密码',
  `app_name` varchar(50) NOT NULL DEFAULT '' COMMENT '应用名称',
  `app_status` int(2) NOT NULL DEFAULT '1' COMMENT '应用状态：0表示禁用，1表示启用',
  `app_info` text COMMENT '应用说明',
  `app_api` text COMMENT '当前应用允许请求的全部API接口',
  `app_group` varchar(128) NOT NULL DEFAULT 'default' COMMENT '当前应用所属的应用组唯一标识',
  `app_add_time` int(11) NOT NULL DEFAULT '0' COMMENT '应用创建时间',
  `app_api_show` text COMMENT '前台样式显示所需数据格式',
  PRIMARY KEY (`id`),
  UNIQUE KEY `app_id` (`app_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='appId和appSecret表';

-- ----------------------------
-- Records of admin_app
-- ----------------------------

-- ----------------------------
-- Table structure for `admin_app_group`
-- ----------------------------
DROP TABLE IF EXISTS `admin_app_group`;
CREATE TABLE `admin_app_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL DEFAULT '' COMMENT '组名称',
  `description` text COMMENT '组说明',
  `status` int(2) NOT NULL DEFAULT '1' COMMENT '组状态：0表示禁用，1表示启用',
  `hash` varchar(128) NOT NULL DEFAULT '' COMMENT '组标识',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='应用组，目前只做管理使用，没有实际权限控制';

-- ----------------------------
-- Records of admin_app_group
-- ----------------------------

-- ----------------------------
-- Table structure for `admin_auth_group`
-- ----------------------------
DROP TABLE IF EXISTS `admin_auth_group`;
CREATE TABLE `admin_auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL DEFAULT '' COMMENT '组名称',
  `description` text COMMENT '组描述',
  `status` int(2) NOT NULL DEFAULT '1' COMMENT '组状态：为1正常，为0禁用',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='权限组';

-- ----------------------------
-- Records of admin_auth_group
-- ----------------------------

-- ----------------------------
-- Table structure for `admin_auth_group_access`
-- ----------------------------
DROP TABLE IF EXISTS `admin_auth_group_access`;
CREATE TABLE `admin_auth_group_access` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) unsigned NOT NULL DEFAULT '0',
  `group_id` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `uid` (`uid`),
  KEY `group_id` (`group_id`(191))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户和组的对应关系';

-- ----------------------------
-- Records of admin_auth_group_access
-- ----------------------------

-- ----------------------------
-- Table structure for `admin_auth_rule`
-- ----------------------------
DROP TABLE IF EXISTS `admin_auth_rule`;
CREATE TABLE `admin_auth_rule` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `url` varchar(80) NOT NULL DEFAULT '' COMMENT '规则唯一标识',
  `group_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '权限所属组的ID',
  `auth` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '权限数值',
  `status` int(1) NOT NULL DEFAULT '1' COMMENT '状态：为1正常，为0禁用',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='权限细节';

-- ----------------------------
-- Records of admin_auth_rule
-- ----------------------------

-- ----------------------------
-- Table structure for `admin_fields`
-- ----------------------------
DROP TABLE IF EXISTS `admin_fields`;
CREATE TABLE `admin_fields` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `field_name` varchar(50) NOT NULL DEFAULT '' COMMENT '字段名称',
  `hash` varchar(50) NOT NULL DEFAULT '' COMMENT '权限所属组的ID',
  `data_type` int(2) NOT NULL DEFAULT '0' COMMENT '数据类型，来源于DataType类库',
  `default` varchar(500) NOT NULL DEFAULT '' COMMENT '默认值',
  `is_must` int(2) NOT NULL DEFAULT '0' COMMENT '是否必须 0为不必须，1为必须',
  `range` varchar(500) NOT NULL DEFAULT '' COMMENT '范围，Json字符串，根据数据类型有不一样的含义',
  `info` varchar(500) NOT NULL DEFAULT '' COMMENT '字段说明',
  `type` int(2) NOT NULL DEFAULT '0' COMMENT '字段用处：0为request，1为response',
  `show_name` varchar(50) NOT NULL DEFAULT '' COMMENT 'wiki显示用字段',
  PRIMARY KEY (`id`),
  KEY `hash` (`hash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用于保存各个API的字段规则';

-- ----------------------------
-- Records of admin_fields
-- ----------------------------

-- ----------------------------
-- Table structure for `admin_group`
-- ----------------------------
DROP TABLE IF EXISTS `admin_group`;
CREATE TABLE `admin_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL DEFAULT '' COMMENT '组名称',
  `description` text COMMENT '组说明',
  `status` int(1) NOT NULL DEFAULT '1' COMMENT '状态：为1正常，为0禁用',
  `hash` varchar(128) NOT NULL DEFAULT '' COMMENT '组标识',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) NOT NULL DEFAULT '0' COMMENT '修改时间',
  `image` varchar(256) DEFAULT NULL COMMENT '分组封面图',
  `hot` int(11) NOT NULL DEFAULT '0' COMMENT '分组热度',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COMMENT='接口组管理';

-- ----------------------------
-- Records of admin_group
-- ----------------------------
INSERT INTO `admin_group` VALUES ('1', '默认分组', '默认分组', '1', 'default', '1564109731', '1564109731', '', '0');

-- ----------------------------
-- Table structure for `admin_list`
-- ----------------------------
DROP TABLE IF EXISTS `admin_list`;
CREATE TABLE `admin_list` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `api_class` varchar(50) NOT NULL DEFAULT '' COMMENT 'api索引，保存了类和方法',
  `hash` varchar(50) NOT NULL DEFAULT '' COMMENT 'api唯一标识',
  `access_token` int(2) NOT NULL DEFAULT '1' COMMENT '是否需要认证AccessToken 1：需要，0：不需要',
  `need_login` int(2) NOT NULL DEFAULT '1' COMMENT '是否需要认证用户token  1：需要 0：不需要',
  `status` int(2) NOT NULL DEFAULT '1' COMMENT 'API状态：0表示禁用，1表示启用',
  `method` int(2) NOT NULL DEFAULT '2' COMMENT '请求方式0：不限1：Post，2：Get',
  `info` varchar(500) NOT NULL DEFAULT '' COMMENT 'api中文说明',
  `is_test` int(2) NOT NULL DEFAULT '0' COMMENT '是否是测试模式：0:生产模式，1：测试模式',
  `return_str` text COMMENT '返回数据示例',
  `group_hash` varchar(64) NOT NULL DEFAULT 'default' COMMENT '当前接口所属的接口分组',
  PRIMARY KEY (`id`),
  KEY `hash` (`hash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用于维护接口信息';

-- ----------------------------
-- Records of admin_list
-- ----------------------------

-- ----------------------------
-- Table structure for `admin_menu`
-- ----------------------------
DROP TABLE IF EXISTS `admin_menu`;
CREATE TABLE `admin_menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL DEFAULT '' COMMENT '菜单名',
  `fid` int(11) NOT NULL DEFAULT '0' COMMENT '父级菜单ID',
  `url` varchar(50) NOT NULL DEFAULT '' COMMENT '链接',
  `auth` int(2) NOT NULL DEFAULT '0' COMMENT '访客权限',
  `sort` int(11) NOT NULL DEFAULT '0' COMMENT '排序',
  `hide` int(2) NOT NULL DEFAULT '0' COMMENT '是否显示',
  `icon` varchar(50) NOT NULL DEFAULT '' COMMENT '菜单图标',
  `level` int(2) NOT NULL DEFAULT '0' COMMENT '菜单认证等级',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=71 DEFAULT CHARSET=utf8mb4 COMMENT='目录信息';

-- ----------------------------
-- Records of admin_menu
-- ----------------------------
INSERT INTO `admin_menu` VALUES ('1', '用户登录', '0', 'admin/Login/index', '0', '0', '0', '', '0');
INSERT INTO `admin_menu` VALUES ('2', '用户登出', '0', 'admin/Login/logout', '0', '0', '0', '', '0');
INSERT INTO `admin_menu` VALUES ('3', '系统管理', '0', '', '0', '1', '0', '', '0');
INSERT INTO `admin_menu` VALUES ('4', '菜单维护', '3', '', '0', '1', '0', '', '0');
INSERT INTO `admin_menu` VALUES ('5', '菜单状态修改', '4', 'admin/Menu/changeStatus', '0', '0', '0', '', '0');
INSERT INTO `admin_menu` VALUES ('6', '新增菜单', '4', 'admin/Menu/add', '0', '0', '0', '', '0');
INSERT INTO `admin_menu` VALUES ('7', '编辑菜单', '4', 'admin/Menu/edit', '0', '0', '0', '', '0');
INSERT INTO `admin_menu` VALUES ('8', '菜单删除', '4', 'admin/Menu/del', '0', '0', '0', '', '0');
INSERT INTO `admin_menu` VALUES ('9', '用户管理', '3', '', '0', '2', '0', '', '0');
INSERT INTO `admin_menu` VALUES ('10', '获取当前组的全部用户', '9', 'admin/User/getUsers', '0', '0', '0', '', '0');
INSERT INTO `admin_menu` VALUES ('11', '用户状态修改', '9', 'admin/User/changeStatus', '0', '0', '0', '', '0');
INSERT INTO `admin_menu` VALUES ('12', '新增用户', '9', 'admin/User/add', '0', '0', '0', '', '0');
INSERT INTO `admin_menu` VALUES ('13', '用户编辑', '9', 'admin/User/edit', '0', '0', '0', '', '0');
INSERT INTO `admin_menu` VALUES ('14', '用户删除', '9', 'admin/User/del', '0', '0', '0', '', '0');
INSERT INTO `admin_menu` VALUES ('15', '权限管理', '3', '', '0', '3', '0', '', '0');
INSERT INTO `admin_menu` VALUES ('16', '权限组状态编辑', '15', 'admin/Auth/changeStatus', '0', '0', '0', '', '0');
INSERT INTO `admin_menu` VALUES ('17', '从指定组中删除指定用户', '15', 'admin/Auth/delMember', '0', '0', '0', '', '0');
INSERT INTO `admin_menu` VALUES ('18', '新增权限组', '15', 'admin/Auth/add', '0', '0', '0', '', '0');
INSERT INTO `admin_menu` VALUES ('19', '权限组编辑', '15', 'admin/Auth/edit', '0', '0', '0', '', '0');
INSERT INTO `admin_menu` VALUES ('20', '删除权限组', '15', 'admin/Auth/del', '0', '0', '0', '', '0');
INSERT INTO `admin_menu` VALUES ('21', '获取全部已开放的可选组', '15', 'admin/Auth/getGroups', '0', '0', '0', '', '0');
INSERT INTO `admin_menu` VALUES ('22', '获取组所有的权限列表', '15', 'admin/Auth/getRuleList', '0', '0', '0', '', '0');
INSERT INTO `admin_menu` VALUES ('23', '应用接入', '0', '', '0', '2', '0', '', '0');
INSERT INTO `admin_menu` VALUES ('24', '应用管理', '23', '', '0', '0', '0', '', '0');
INSERT INTO `admin_menu` VALUES ('25', '应用状态编辑', '24', 'admin/App/changeStatus', '0', '0', '0', '', '0');
INSERT INTO `admin_menu` VALUES ('26', '获取AppId,AppSecret,接口列表,应用接口权限细节', '24', 'admin/App/getAppInfo', '0', '0', '0', '', '0');
INSERT INTO `admin_menu` VALUES ('27', '新增应用', '24', 'admin/App/add', '0', '0', '0', '', '0');
INSERT INTO `admin_menu` VALUES ('28', '编辑应用', '24', 'admin/App/edit', '0', '0', '0', '', '0');
INSERT INTO `admin_menu` VALUES ('29', '删除应用', '24', 'admin/App/del', '0', '0', '0', '', '0');
INSERT INTO `admin_menu` VALUES ('30', '接口管理', '0', '', '0', '3', '0', '', '0');
INSERT INTO `admin_menu` VALUES ('31', '接口维护', '30', '', '0', '0', '0', '', '0');
INSERT INTO `admin_menu` VALUES ('32', '接口状态编辑', '31', 'admin/InterfaceList/changeStatus', '0', '0', '0', '', '0');
INSERT INTO `admin_menu` VALUES ('33', '获取接口唯一标识', '31', 'admin/InterfaceList/getHash', '0', '0', '0', '', '0');
INSERT INTO `admin_menu` VALUES ('34', '添加接口', '31', 'admin/InterfaceList/add', '0', '0', '0', '', '0');
INSERT INTO `admin_menu` VALUES ('35', '编辑接口', '31', 'admin/InterfaceList/edit', '0', '0', '0', '', '0');
INSERT INTO `admin_menu` VALUES ('36', '删除接口', '31', 'admin/InterfaceList/del', '0', '0', '0', '', '0');
INSERT INTO `admin_menu` VALUES ('37', '获取接口请求字段', '31', 'admin/Fields/request', '0', '0', '0', '', '0');
INSERT INTO `admin_menu` VALUES ('38', '获取接口返回字段', '31', 'admin/Fields/response', '0', '0', '0', '', '0');
INSERT INTO `admin_menu` VALUES ('39', '添加接口字段', '31', 'admin/Fields/add', '0', '0', '0', '', '0');
INSERT INTO `admin_menu` VALUES ('40', '上传接口返回字段', '31', 'admin/Fields/upload', '0', '0', '0', '', '0');
INSERT INTO `admin_menu` VALUES ('41', '编辑接口字段', '31', 'admin/Fields/edit', '0', '0', '0', '', '0');
INSERT INTO `admin_menu` VALUES ('42', '删除接口字段', '31', 'admin/Fields/del', '0', '0', '0', '', '0');
INSERT INTO `admin_menu` VALUES ('43', '接口分组', '30', '', '0', '1', '0', '', '0');
INSERT INTO `admin_menu` VALUES ('44', '添加接口组', '43', 'admin/InterfaceGroup/add', '0', '0', '0', '', '0');
INSERT INTO `admin_menu` VALUES ('45', '编辑接口组', '43', 'admin/InterfaceGroup/edit', '0', '0', '0', '', '0');
INSERT INTO `admin_menu` VALUES ('46', '删除接口组', '43', 'admin/InterfaceGroup/del', '0', '0', '0', '', '0');
INSERT INTO `admin_menu` VALUES ('47', '获取全部有效的接口组', '43', 'admin/InterfaceGroup/getAll', '0', '0', '0', '', '0');
INSERT INTO `admin_menu` VALUES ('48', '接口组状态维护', '43', 'admin/InterfaceGroup/changeStatus', '0', '0', '0', '', '0');
INSERT INTO `admin_menu` VALUES ('49', '应用分组', '23', '', '0', '1', '0', '', '0');
INSERT INTO `admin_menu` VALUES ('50', '添加应用组', '49', 'admin/AppGroup/add', '0', '0', '0', '', '0');
INSERT INTO `admin_menu` VALUES ('51', '编辑应用组', '49', 'admin/AppGroup/edit', '0', '0', '0', '', '0');
INSERT INTO `admin_menu` VALUES ('52', '删除应用组', '49', 'admin/AppGroup/del', '0', '0', '0', '', '0');
INSERT INTO `admin_menu` VALUES ('53', '获取全部可用应用组', '49', 'admin/AppGroup/getAll', '0', '0', '0', '', '0');
INSERT INTO `admin_menu` VALUES ('54', '应用组状态编辑', '49', 'admin/AppGroup/changeStatus', '0', '0', '0', '', '0');
INSERT INTO `admin_menu` VALUES ('55', '菜单列表', '4', 'admin/Menu/index', '0', '0', '0', '', '0');
INSERT INTO `admin_menu` VALUES ('56', '用户列表', '9', 'admin/User/index', '0', '0', '0', '', '0');
INSERT INTO `admin_menu` VALUES ('57', '权限列表', '15', 'admin/Auth/index', '0', '0', '0', '', '0');
INSERT INTO `admin_menu` VALUES ('58', '应用列表', '24', 'admin/App/index', '0', '0', '0', '', '0');
INSERT INTO `admin_menu` VALUES ('59', '应用分组列表', '49', 'admin/AppGroup/index', '0', '0', '0', '', '0');
INSERT INTO `admin_menu` VALUES ('60', '接口列表', '31', 'admin/InterfaceList/index', '0', '0', '0', '', '0');
INSERT INTO `admin_menu` VALUES ('61', '接口分组列表', '43', 'admin/InterfaceGroup/index', '0', '0', '0', '', '0');
INSERT INTO `admin_menu` VALUES ('62', '日志管理', '3', '', '0', '4', '0', '', '0');
INSERT INTO `admin_menu` VALUES ('63', '获取操作日志列表', '62', 'admin/Log/index', '0', '0', '0', '', '0');
INSERT INTO `admin_menu` VALUES ('64', '删除单条日志记录', '62', 'admin/Log/del', '0', '0', '0', '', '0');
INSERT INTO `admin_menu` VALUES ('65', '刷新路由', '31', 'admin/InterfaceList/refresh', '0', '0', '0', '', '0');
INSERT INTO `admin_menu` VALUES ('67', '文件上传', '0', 'admin/Index/upload', '0', '0', '0', '', '0');
INSERT INTO `admin_menu` VALUES ('68', '更新个人信息', '9', 'admin/User/own', '0', '0', '0', '', '0');
INSERT INTO `admin_menu` VALUES ('69', '刷新AppSecret', '24', 'admin/App/refreshAppSecret', '0', '0', '0', '', '0');
INSERT INTO `admin_menu` VALUES ('70', '获取用户信息', '9', 'admin/Login/getUserInfo', '0', '0', '0', '', '0');

-- ----------------------------
-- Table structure for `admin_user`
-- ----------------------------
DROP TABLE IF EXISTS `admin_user`;
CREATE TABLE `admin_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(64) NOT NULL DEFAULT '' COMMENT '用户名',
  `nickname` varchar(64) NOT NULL DEFAULT '' COMMENT '用户昵称',
  `password` char(32) NOT NULL DEFAULT '' COMMENT '用户密码',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '注册时间',
  `create_ip` bigint(20) NOT NULL DEFAULT '0' COMMENT '注册IP',
  `update_time` int(11) NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` int(1) NOT NULL DEFAULT '0' COMMENT '账号状态 0封号 1正常',
  `openid` varchar(100) DEFAULT '' COMMENT '三方登录唯一ID',
  PRIMARY KEY (`id`),
  KEY `create_time` (`create_time`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COMMENT='管理员认证信息';

-- ----------------------------
-- Records of admin_user
-- ----------------------------
INSERT INTO `admin_user` VALUES ('1', 'root', 'root', 'd93a5def7511da3d0f2d171d9c344e91', '1564109731', '2130706433', '1564109731', '1', null);

-- ----------------------------
-- Table structure for `admin_user_action`
-- ----------------------------
DROP TABLE IF EXISTS `admin_user_action`;
CREATE TABLE `admin_user_action` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_name` varchar(50) NOT NULL DEFAULT '' COMMENT '行为名称',
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT '操作用户ID',
  `nickname` varchar(50) NOT NULL DEFAULT '' COMMENT '用户昵称',
  `add_time` int(11) NOT NULL DEFAULT '0' COMMENT '操作时间',
  `data` text COMMENT '用户提交的数据',
  `url` varchar(200) NOT NULL DEFAULT '0' COMMENT '操作URL',
  PRIMARY KEY (`id`),
  KEY `uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户操作日志';

-- ----------------------------
-- Records of admin_user_action
-- ----------------------------

-- ----------------------------
-- Table structure for `admin_user_data`
-- ----------------------------
DROP TABLE IF EXISTS `admin_user_data`;
CREATE TABLE `admin_user_data` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `login_times` int(11) NOT NULL DEFAULT '0' COMMENT '账号登录次数',
  `last_login_ip` bigint(20) NOT NULL DEFAULT '0' COMMENT '最后登录IP',
  `last_login_time` int(11) NOT NULL DEFAULT '0' COMMENT '最后登录时间',
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT '用户ID',
  `head_img` text COMMENT '用户头像',
  PRIMARY KEY (`id`),
  KEY `uid` (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COMMENT='管理员数据表';

-- ----------------------------
-- Records of admin_user_data
-- ----------------------------
INSERT INTO `admin_user_data` VALUES ('1', '3', '2130706433', '1564123581', '1', '');

-- ----------------------------
-- Table structure for `migrations`
-- ----------------------------
DROP TABLE IF EXISTS `migrations`;
CREATE TABLE `migrations` (
  `version` bigint(20) NOT NULL,
  `migration_name` varchar(100) DEFAULT NULL,
  `start_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `end_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `breakpoint` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of migrations
-- ----------------------------
INSERT INTO `migrations` VALUES ('20190425073802', 'AdminApp', '2019-07-26 10:55:31', '2019-07-26 10:55:31', '0');
INSERT INTO `migrations` VALUES ('20190425094427', 'AdminAppGroup', '2019-07-26 10:55:31', '2019-07-26 10:55:31', '0');
INSERT INTO `migrations` VALUES ('20190508070533', 'AdminAuthGroup', '2019-07-26 10:55:31', '2019-07-26 10:55:31', '0');
INSERT INTO `migrations` VALUES ('20190508100337', 'AdminAuthGroupAccess', '2019-07-26 10:55:31', '2019-07-26 10:55:31', '0');
INSERT INTO `migrations` VALUES ('20190508101122', 'AdminAuthRule', '2019-07-26 10:55:31', '2019-07-26 10:55:31', '0');
INSERT INTO `migrations` VALUES ('20190508152801', 'AdminFields', '2019-07-26 10:55:31', '2019-07-26 10:55:31', '0');
INSERT INTO `migrations` VALUES ('20190508153800', 'AdminGroup', '2019-07-26 10:55:31', '2019-07-26 10:55:31', '0');
INSERT INTO `migrations` VALUES ('20190513065521', 'AdminList', '2019-07-26 10:55:31', '2019-07-26 10:55:31', '0');
INSERT INTO `migrations` VALUES ('20190513070628', 'AdminMenu', '2019-07-26 10:55:31', '2019-07-26 10:55:31', '0');
INSERT INTO `migrations` VALUES ('20190513081034', 'AdminUser', '2019-07-26 10:55:31', '2019-07-26 10:55:31', '0');
INSERT INTO `migrations` VALUES ('20190513082503', 'AdminUserAction', '2019-07-26 10:55:31', '2019-07-26 10:55:31', '0');
INSERT INTO `migrations` VALUES ('20190513085755', 'AdminUserData', '2019-07-26 10:55:31', '2019-07-26 10:55:31', '0');
INSERT INTO `migrations` VALUES ('20190513155519', 'IniAdminMenu', '2019-07-26 10:55:31', '2019-07-26 10:55:31', '0');
INSERT INTO `migrations` VALUES ('20190514034923', 'IniAdminGroup', '2019-07-26 10:55:31', '2019-07-26 10:55:31', '0');
INSERT INTO `migrations` VALUES ('20190515031308', 'IniAdminUser', '2019-07-26 10:55:31', '2019-07-26 10:55:31', '0');
