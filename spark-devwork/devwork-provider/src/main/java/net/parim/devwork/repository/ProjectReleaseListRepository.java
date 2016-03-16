package net.parim.devwork.repository;

import java.util.List;

import net.parim.common.persistence.CrudRepository;
import net.parim.common.persistence.annotation.MyBatisRepository;
import net.parim.devwork.entity.ProjectReleaseList;
@MyBatisRepository
public interface ProjectReleaseListRepository extends CrudRepository<ProjectReleaseList, Long> {
	//删除方法（包含多条删除和单条删除）
	public void deleteAll(List<String> idList);
}
