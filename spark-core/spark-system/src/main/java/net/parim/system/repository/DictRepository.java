package net.parim.system.repository;

import java.util.List;

import net.parim.common.persistence.CrudRepository;
import net.parim.common.persistence.annotation.MyBatisRepository;
import net.parim.system.entity.Dict;

@MyBatisRepository
public interface DictRepository extends CrudRepository<Dict, Long> {
	
	public List<Dict> findAll();

}
