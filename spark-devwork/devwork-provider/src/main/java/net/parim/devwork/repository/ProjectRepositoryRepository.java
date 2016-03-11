package net.parim.devwork.repository;

import java.util.List;

import net.parim.common.persistence.CrudRepository;
import net.parim.common.persistence.annotation.MyBatisRepository;
import net.parim.devwork.entity.ProjectRepository;
@MyBatisRepository
public interface ProjectRepositoryRepository extends CrudRepository<ProjectRepository, Long> {
	
	public void deleteAll(List<String> idList);
}
