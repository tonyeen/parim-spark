/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package net.parim.sns.modules.gen.dao;

import net.parim.common.persistence.CurdRepository;
import net.parim.common.persistence.annotation.MyBatisRepository;
import net.parim.sns.modules.gen.entity.GenTableColumn;

/**
 * 业务表字段DAO接口
 * @author ThinkGem
 * @version 2013-10-15
 */
@MyBatisRepository
public interface GenTableColumnDao extends CurdRepository<GenTableColumn> {
	
	public void deleteByGenTableId(Long genTableId);
}
