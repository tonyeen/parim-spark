package net.parim.devwork.repository;

import java.util.List;

import net.parim.common.persistence.CrudRepository;
import net.parim.common.persistence.annotation.MyBatisRepository;
import net.parim.devwork.entity.Project;

@MyBatisRepository
public interface ProjectRepository 
		extends CrudRepository<Project, Long> {
	public void deleteAll(List<String> idList);
}
