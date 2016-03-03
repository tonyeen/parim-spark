package net.parim.modules.test.dao;

import net.parim.common.persistence.BaseRepository;
import net.parim.common.persistence.annotation.MyBatisRepository;
import net.parim.modules.test.entity.TestEntity;

@MyBatisRepository
public interface TestDao extends BaseRepository {
	
	/**
	 * 根据ID获得一条数据
	 * @param id
	 * @return
	 */
	public TestEntity get(Long id);
}
