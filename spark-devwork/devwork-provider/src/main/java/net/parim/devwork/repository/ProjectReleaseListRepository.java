package net.parim.devwork.repository;

import java.util.List;

import net.parim.common.persistence.CrudRepository;
import net.parim.common.persistence.annotation.MyBatisRepository;
import net.parim.devwork.entity.ProjectReleaseList;
@MyBatisRepository
public interface ProjectReleaseListRepository extends CrudRepository<ProjectReleaseList, Long> {

	public void deleteAll(List<String> idList);
}
