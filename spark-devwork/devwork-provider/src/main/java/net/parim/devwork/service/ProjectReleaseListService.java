package net.parim.devwork.service;

import java.util.List;

import org.springframework.stereotype.Service;

import net.parim.common.service.CrudService;
import net.parim.devwork.entity.ProjectReleaseList;
import net.parim.devwork.repository.ProjectReleaseListRepository;

@Service
public class ProjectReleaseListService extends CrudService<ProjectReleaseListRepository, ProjectReleaseList, Long> {

	public void deleteAll(List<String> idList){
		repository.deleteAll(idList);
	};
}
	
