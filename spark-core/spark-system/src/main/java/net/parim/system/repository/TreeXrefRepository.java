package net.parim.system.repository;

import java.util.List;

import net.parim.common.persistence.CurdRepository;
import net.parim.common.persistence.annotation.MyBatisRepository;
import net.parim.system.entity.TreeXref;

@MyBatisRepository
public interface TreeXrefRepository extends CurdRepository<TreeXref> {
	
	public List<TreeXref> findAncestors(TreeXref nede);
	
	public List<TreeXref> findParents(TreeXref nede);
	
	public void removeByChildId(String childId);
	
	public List<TreeXref> findChildren(String parentId);
}
