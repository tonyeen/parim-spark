/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package net.parim.sns.modules.gen.dao;

import net.parim.common.persistence.CurdRepository;
import net.parim.common.persistence.annotation.MyBatisReponsitory;
import net.parim.sns.modules.gen.entity.GenTable;

/**
 * 业务表DAO接口
 * @author ThinkGem
 * @version 2013-10-15
 */
@MyBatisReponsitory
public interface GenTableDao extends CurdRepository<GenTable> {
	
}
