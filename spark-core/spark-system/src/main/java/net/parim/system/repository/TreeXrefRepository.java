package net.parim.system.repository;

import java.util.List;

import net.parim.common.persistence.CrudRepository;
import net.parim.common.persistence.annotation.MyBatisRepository;
import net.parim.system.entity.TreeXref;

@MyBatisRepository
public interface TreeXrefRepository extends CrudRepository<TreeXref, Long> {
	
	public List<TreeXref> findAncestors(TreeXref nede);
	
	public List<TreeXref> findParents(TreeXref nede);
	
	public void removeByChildId(Long childId);
	
	public List<TreeXref> findChildren(Long parentId);
}
