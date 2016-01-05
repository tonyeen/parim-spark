package net.parim.sns.modules.test.dao;

import net.parim.common.persistence.BaseRepository;
import net.parim.common.persistence.annotation.MyBatisRepository;
import net.parim.sns.modules.test.entity.Test;

@MyBatisRepository
public interface TestDao extends BaseRepository {
	
	/**
	 * 根据ID获得一条数据
	 * @param id
	 * @return
	 */
	public Test get(Long id);
}
