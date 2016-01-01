CREATE TABLE `sns_user` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


create table `pre_prefecture` (
	`id` bigint unsigned not null auto_increment,
	`name` varchar(255) not null comment '名称',
	`intro` text(4000) null comment '简介',
	`category_id` bigint unsigned null comment '分类',
	`thumbnails` varchar(200) null comment '缩略图',
	`start_date` date null comment '有效期开始时间',
	`end_date` date null comment '有效期结束时间',
	`static_url` varchar(255) comment '静态专区链接地址，此地址不为空时，直接进入改地址',
	`is_publish` tinyint(1) comment '是否发布',
	`is_choice` tinyint(1) comment '是否精品',
	`state` enum('in_approve','dis_approved', 'en_approved')
		comment '状态：申请审批中，审批通过，审批未通过，enumeration',
	PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

create table `pre_category` (
	`id` bigint unsigned not null auto_increment,
	`name` varchar(255) not null comment '名称',
	`parent_id` bigint unsigned comment '父分类ID',
	`is_default` tinyint(1) comment '是否默认分类，默认分类不可删除',
	PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;