package net.parim.sns.modules.sys.repository;

import java.util.List;

import net.parim.sns.common.persistence.CurdRepository;
import net.parim.sns.common.persistence.annotation.MyBatisReponsitory;
import net.parim.sns.modules.sys.entity.Office;

@MyBatisReponsitory
public interface OfficeRepository extends CurdRepository<Office> {
	
	public List<Office> findByParentId(Long parentId);
}
