package net.parim.sns.modules.sys.repository;

import java.util.List;

import net.parim.common.persistence.CurdRepository;
import net.parim.common.persistence.annotation.MyBatisReponsitory;
import net.parim.sns.modules.sys.entity.TreeXref;

@MyBatisReponsitory
public interface TreeXrefRepository extends CurdRepository<TreeXref> {
	
	public List<TreeXref> findAncestors(TreeXref nede);
	
	public List<TreeXref> findParents(TreeXref nede);
	
	public void removeByChildId(Long childId);
}
