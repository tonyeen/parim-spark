/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package net.parim.sns.modules.gen.dao;

import net.parim.common.persistence.CurdRepository;
import net.parim.common.persistence.annotation.MyBatisRepository;
import net.parim.sns.modules.gen.entity.GenTemplate;

/**
 * 代码模板DAO接口
 * @author ThinkGem
 * @version 2013-10-15
 */
@MyBatisRepository
public interface GenTemplateDao extends CurdRepository<GenTemplate> {
	
}
