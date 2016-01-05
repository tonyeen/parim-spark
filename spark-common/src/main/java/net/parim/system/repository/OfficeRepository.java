package net.parim.system.repository;

import java.util.List;

import net.parim.common.persistence.CurdRepository;
import net.parim.common.persistence.annotation.MyBatisRepository;
import net.parim.system.entity.Office;

@MyBatisRepository
public interface OfficeRepository extends CurdRepository<Office> {
	
	public List<Office> findByParentId(Long parentId);
}
