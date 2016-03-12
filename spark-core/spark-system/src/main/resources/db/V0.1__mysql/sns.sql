/*
 Navicat Premium Data Transfer

 Source Server         : 112.126.70.27
 Source Server Type    : MySQL
 Source Server Version : 50627
 Source Host           : 112.126.70.27
 Source Database       : sns

 Target Server Type    : MySQL
 Target Server Version : 50627
 File Encoding         : utf-8

 Date: 12/25/2015 01:23:58 AM
*/

SET NAMES utf8;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
--  Table structure for `admin_privilege`
-- ----------------------------
DROP TABLE IF EXISTS `admin_privilege`;
CREATE TABLE `admin_privilege` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(40) NOT NULL,
  `name` varchar(200) NOT NULL,
  `targets` varchar(32) NOT NULL,
  `user_type` char(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `admin_role`
-- ----------------------------
DROP TABLE IF EXISTS `admin_role`;
CREATE TABLE `admin_role` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `site_id` bigint(20) NOT NULL,
  `targets` varchar(32) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL DEFAULT '0',
  `created_by` bigint(20) NOT NULL,
  `create_date` datetime NOT NULL,
  `last_updated_by` bigint(20) NOT NULL,
  `last_update_date` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `admin_role_xref`
-- ----------------------------
DROP TABLE IF EXISTS `admin_role_xref`;
CREATE TABLE `admin_role_xref` (
  `site_id` bigint(20) NOT NULL,
  `privilege_id` bigint(20) NOT NULL,
  `role_id` bigint(20) NOT NULL,
  `created_by` bigint(20) NOT NULL,
  `create_date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `ila_user`
-- ----------------------------
DROP TABLE IF EXISTS `ila_user`;
CREATE TABLE `ila_user` (
  `id` bigint(20) NOT NULL,
  `email` varchar(200) NOT NULL,
  `user_group_id` bigint(20) DEFAULT NULL,
  `username` varchar(200) NOT NULL,
  `password` varchar(200) NOT NULL,
  `salt` varchar(32) NOT NULL,
  `first_name` varchar(200) NOT NULL,
  `last_name` varchar(200) NOT NULL,
  `faliliar_name` varchar(200) DEFAULT NULL,
  `site_id` bigint(20) NOT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `allow_update` tinyint(1) NOT NULL DEFAULT '1',
  `total_session_count` int(11) DEFAULT NULL,
  `total_session_time` bigint(20) DEFAULT NULL,
  `created_by` bigint(20) NOT NULL,
  `create_date` datetime NOT NULL,
  `last_updated_by` bigint(20) NOT NULL,
  `last_update_date` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `logical_group`
-- ----------------------------
DROP TABLE IF EXISTS `logical_group`;
CREATE TABLE `logical_group` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `condition_id` bigint(20) DEFAULT NULL,
  `site_id` bigint(20) NOT NULL,
  `name` varchar(240) NOT NULL,
  `is_public` tinyint(1) NOT NULL DEFAULT '1',
  `created_by` bigint(20) NOT NULL,
  `create_date` datetime NOT NULL,
  `last_updated_by` bigint(20) NOT NULL,
  `last_update_date` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `pre_category`
-- ----------------------------
DROP TABLE IF EXISTS `pre_category`;
CREATE TABLE `pre_category` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL COMMENT '名称',
  `parent_id` bigint(20) unsigned DEFAULT NULL COMMENT '父分类ID',
  `is_default` tinyint(1) DEFAULT NULL COMMENT '是否默认分类，默认分类不可删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `pre_prefecture`
-- ----------------------------
DROP TABLE IF EXISTS `pre_prefecture`;
CREATE TABLE `pre_prefecture` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL COMMENT '名称',
  `intro` text COMMENT '简介',
  `category_id` bigint(20) unsigned DEFAULT NULL COMMENT '分类',
  `thumbnails` varchar(200) DEFAULT NULL COMMENT '缩略图',
  `start_date` date DEFAULT NULL COMMENT '有效期开始时间',
  `end_date` date DEFAULT NULL COMMENT '有效期结束时间',
  `static_url` varchar(255) DEFAULT NULL COMMENT '静态专区链接地址，此地址不为空时，直接进入改地址',
  `is_publish` tinyint(1) DEFAULT NULL COMMENT '是否发布',
  `is_choice` tinyint(1) DEFAULT NULL COMMENT '是否精品',
  `state` enum('IN_APPROVE','DIS_APPROVED','EN_APPROVED') DEFAULT NULL COMMENT '状态：申请审批中，审批通过，审批未通过，enumeration',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `privilege_ref`
-- ----------------------------
DROP TABLE IF EXISTS `privilege_ref`;
CREATE TABLE `privilege_ref` (
  `site_id` bigint(20) DEFAULT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `target_id` bigint(20) DEFAULT NULL,
  `target_type` varchar(8) DEFAULT NULL,
  `ref_count` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `sequence`
-- ----------------------------
DROP TABLE IF EXISTS `sequence`;
CREATE TABLE `sequence` (
  `seq_name` varchar(50) NOT NULL,
  `current_val` bigint(20) NOT NULL,
  `increment_val` bigint(20) NOT NULL DEFAULT '1',
  PRIMARY KEY (`seq_name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `site`
-- ----------------------------
DROP TABLE IF EXISTS `site`;
CREATE TABLE `site` (
  `id` bigint(20) NOT NULL,
  `parent_id` bigint(20) DEFAULT NULL,
  `name` varchar(120) NOT NULL,
  `short_name` varchar(20) NOT NULL,
  `description` text,
  `created_by` smallint(6) NOT NULL,
  `create_date` datetime NOT NULL,
  `last_updated_by` bigint(20) NOT NULL,
  `last_update_date` datetime NOT NULL,
  `theme` varchar(20) DEFAULT NULL,
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `sns_group`
-- ----------------------------
DROP TABLE IF EXISTS `sns_group`;
CREATE TABLE `sns_group` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 NOT NULL,
  `intro` text CHARACTER SET utf8,
  `logo_path` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `type` char(1) CHARACTER SET utf8 NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `sns_user`
-- ----------------------------
DROP TABLE IF EXISTS `sns_user`;
CREATE TABLE `sns_user` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `sys_dict`
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict`;
CREATE TABLE `sys_dict` (
  `id` bigint(64) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `value` varchar(100) NOT NULL COMMENT '数据值',
  `label` varchar(100) NOT NULL COMMENT '标签名',
  `type` varchar(100) NOT NULL COMMENT '类型',
  `description` varchar(100) NOT NULL COMMENT '描述',
  `sort` decimal(10,0) NOT NULL COMMENT '排序（升序）',
  `parent_id` varchar(64) DEFAULT '0' COMMENT '父级编号',
  `create_by` varchar(64) NOT NULL COMMENT '创建者',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_by` varchar(64) NOT NULL COMMENT '更新者',
  `update_date` datetime NOT NULL COMMENT '更新时间',
  `remarks` varchar(255) DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) NOT NULL DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`),
  KEY `sys_dict_value` (`value`),
  KEY `sys_dict_label` (`label`),
  KEY `sys_dict_del_flag` (`del_flag`)
) ENGINE=InnoDB AUTO_INCREMENT=112 DEFAULT CHARSET=utf8 COMMENT='字典表';

-- ----------------------------
--  Table structure for `sys_menu`
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu` (
  `id` bigint(64) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `parent_id` bigint(64) NOT NULL COMMENT '父级编号',
  `parent_ids` varchar(2000) NOT NULL COMMENT '所有父级编号',
  `name` varchar(100) NOT NULL COMMENT '名称',
  `sort` decimal(10,0) NOT NULL COMMENT '排序',
  `url` varchar(2000) DEFAULT NULL COMMENT '链接',
  `target` varchar(20) DEFAULT NULL COMMENT '目标',
  `icon` varchar(100) DEFAULT NULL COMMENT '图标',
  `is_show` tinyint(1) NOT NULL COMMENT '是否在菜单中显示',
  `permission` varchar(200) DEFAULT NULL COMMENT '权限标识',
  `created_by` varchar(64) DEFAULT NULL COMMENT '创建者',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `updated_by` varchar(64) DEFAULT NULL COMMENT '更新者',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  `remarks` varchar(255) DEFAULT NULL COMMENT '备注信息',
  `is_deleted` tinyint(1) DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`),
  KEY `sys_menu_parent_id` (`parent_id`),
  KEY `sys_menu_del_flag` (`is_deleted`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8 COMMENT='菜单表';

-- ----------------------------
--  Table structure for `sys_menu_xref`
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu_xref`;
CREATE TABLE `sys_menu_xref` (
  `menu_id` bigint(20) DEFAULT NULL,
  `privilege_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `sys_office`
-- ----------------------------
DROP TABLE IF EXISTS `sys_office`;
CREATE TABLE `sys_office` (
  `id` bigint(64) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `parent_id` bigint(64) NOT NULL COMMENT '父级编号',
  `parent_ids` varchar(2000) NOT NULL COMMENT '所有父级编号',
  `name` varchar(100) NOT NULL COMMENT '名称',
  `sort` decimal(10,0) NOT NULL COMMENT '排序',
  `area_id` varchar(64) DEFAULT NULL COMMENT '归属区域',
  `code` varchar(100) DEFAULT NULL COMMENT '区域编码',
  `type` char(1) NOT NULL COMMENT '机构类型',
  `grade` int(1) NOT NULL COMMENT '机构等级',
  `address` varchar(255) DEFAULT NULL COMMENT '联系地址',
  `zip_code` varchar(100) DEFAULT NULL COMMENT '邮政编码',
  `master` varchar(100) DEFAULT NULL COMMENT '负责人',
  `phone` varchar(200) DEFAULT NULL COMMENT '电话',
  `fax` varchar(200) DEFAULT NULL COMMENT '传真',
  `email` varchar(200) DEFAULT NULL COMMENT '邮箱',
  `USEABLE` varchar(64) DEFAULT NULL COMMENT '是否启用',
  `PRIMARY_PERSON` varchar(64) DEFAULT NULL COMMENT '主负责人',
  `DEPUTY_PERSON` varchar(64) DEFAULT NULL COMMENT '副负责人',
  `create_by` varchar(64) DEFAULT NULL COMMENT '创建者',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT NULL COMMENT '更新者',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  `remarks` varchar(255) DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`),
  KEY `sys_office_parent_id` (`parent_id`),
  KEY `sys_office_del_flag` (`del_flag`),
  KEY `sys_office_type` (`type`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='机构表';

-- ----------------------------
--  Table structure for `tree_xref`
-- ----------------------------
DROP TABLE IF EXISTS `tree_xref`;
CREATE TABLE `tree_xref` (
  `parent_id` bigint(20) NOT NULL,
  `child_id` bigint(20) NOT NULL,
  `distance` bigint(20) NOT NULL,
  `path_count` varchar(10) NOT NULL,
  `parent_object_type` varchar(8) NOT NULL,
  `child_object_type` varchar(8) NOT NULL,
  `tree_type` varchar(8) NOT NULL,
  `child_count` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `user_group`
-- ----------------------------
DROP TABLE IF EXISTS `user_group`;
CREATE TABLE `user_group` (
  `id` bigint(20) NOT NULL,
  `parent_id` bigint(20) NOT NULL,
  `site_id` bigint(20) NOT NULL,
  `name` varchar(200) NOT NULL,
  `is_root` tinyint(1) NOT NULL,
  `created_by` bigint(20) NOT NULL,
  `create_date` datetime NOT NULL,
  `last_updated_by` bigint(20) NOT NULL,
  `last_update_date` datetime NOT NULL,
  `custom_theme_id` bigint(20) DEFAULT NULL,
  `mobile_theme_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `user_role`
-- ----------------------------
DROP TABLE IF EXISTS `user_role`;
CREATE TABLE `user_role` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `site_id` bigint(20) NOT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `user_group_id` bigint(20) DEFAULT NULL,
  `logical_group_id` bigint(20) DEFAULT NULL,
  `role_id` bigint(20) DEFAULT NULL,
  `privilege_id` bigint(20) DEFAULT NULL,
  `target` varchar(32) NOT NULL,
  `target_id` bigint(20) NOT NULL,
  `created_by` bigint(20) NOT NULL,
  `create_date` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  View structure for `user_privilege_view`
-- ----------------------------
DROP VIEW IF EXISTS `user_privilege_view`;
CREATE ALGORITHM=UNDEFINED DEFINER=`tony`@`%` SQL SECURITY DEFINER VIEW `user_privilege_view` AS select `ur`.`target_id` AS `target_id`,`ur`.`target` AS `target`,`ur`.`user_id` AS `user_id` from `user_role` `ur` union select `ur`.`target_id` AS `target_id`,`ur`.`target` AS `target`,`x`.`child_id` AS `user_id` from (`user_role` `ur` join `tree_xref` `x`) where ((`ur`.`user_group_id` = `x`.`parent_id`) and (`x`.`tree_type` = 'P') and (`x`.`child_object_type` = 'U'));

-- ----------------------------
--  Procedure structure for `testp`
-- ----------------------------
DROP PROCEDURE IF EXISTS `testp`;
delimiter ;;
CREATE DEFINER=`tony`@`%` PROCEDURE `testp`(in pchildid bigint, in dd varchar(10))
BEGIN
	DECLARE v_child_id BIGINT;
end
 ;;
delimiter ;

-- ----------------------------
--  Function structure for `currval`
-- ----------------------------
DROP FUNCTION IF EXISTS `currval`;
delimiter ;;
CREATE DEFINER=`tony`@`%` FUNCTION `currval`(v_seq_name VARCHAR(50)) RETURNS bigint(20)
begin 
    declare value BIGINT;  
    set value = 0;  
    select current_val into value  
    from sequence 
    where seq_name = v_seq_name;  
    return value;  
end
 ;;
delimiter ;

-- ----------------------------
--  Function structure for `nextval`
-- ----------------------------
DROP FUNCTION IF EXISTS `nextval`;
delimiter ;;
CREATE DEFINER=`tony`@`%` FUNCTION `nextval`(v_seq_name VARCHAR(50)) RETURNS bigint(20)
begin 
  update sequence 
  set current_val = current_val + increment_val  
  where seq_name = v_seq_name;  
  return currval(v_seq_name);  
end
 ;;
delimiter ;

-- ----------------------------
--  Function structure for `setval`
-- ----------------------------
DROP FUNCTION IF EXISTS `setval`;
delimiter ;;
CREATE DEFINER=`tony`@`%` FUNCTION `setval`(v_seq_name VARCHAR(50), v_new_val INTEGER) RETURNS bigint(20)
begin 
  update sequence 
  set current_val = v_new_val  
  where seq_name = v_seq_name;  
	return currval(v_seq_name);
end
 ;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
