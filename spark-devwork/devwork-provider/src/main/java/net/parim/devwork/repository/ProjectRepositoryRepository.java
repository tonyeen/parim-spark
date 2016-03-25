package net.parim.devwork.repository;

import java.util.List;

import net.parim.common.persistence.CrudRepository;
import net.parim.common.persistence.annotation.MyBatisRepository;
import net.parim.devwork.entity.ProjectRepository;
@MyBatisRepository
public interface ProjectRepositoryRepository extends CrudRepository<ProjectRepository, Long> {
	//删除方法（包含多条删除和单条删除）
	public void deleteAll(List<String> idList);
}
