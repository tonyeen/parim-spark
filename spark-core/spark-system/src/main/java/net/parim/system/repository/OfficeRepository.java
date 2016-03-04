package net.parim.system.repository;

import java.util.List;

import net.parim.common.persistence.CrudRepository;
import net.parim.common.persistence.annotation.MyBatisRepository;
import net.parim.system.entity.Office;

@MyBatisRepository
public interface OfficeRepository extends CrudRepository<Office, Long> {
	
	public List<Office> findByParentId(Long parentId);
}
