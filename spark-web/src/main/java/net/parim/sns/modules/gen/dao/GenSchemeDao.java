/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package net.parim.sns.modules.gen.dao;

import org.springframework.data.repository.CrudRepository;

import net.parim.sns.common.persistence.CurdRepository;
import net.parim.sns.common.persistence.annotation.MyBatisReponsitory;
import net.parim.sns.modules.gen.entity.GenScheme;

/**
 * 生成方案DAO接口
 * @author ThinkGem
 * @version 2013-10-15
 */
@MyBatisReponsitory
public interface GenSchemeDao extends CurdRepository<GenScheme> {
	
}
