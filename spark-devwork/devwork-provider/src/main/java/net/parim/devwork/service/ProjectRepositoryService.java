package net.parim.devwork.service;

import java.util.List;

import org.springframework.stereotype.Service;

import net.parim.common.service.CrudService;
import net.parim.devwork.entity.ProjectRepository;
import net.parim.devwork.repository.ProjectRepositoryRepository;

@Service
public class ProjectRepositoryService extends CrudService<ProjectRepositoryRepository, ProjectRepository, Long> {

	public void deleteAll(List<String> idList){
		repository.deleteAll(idList);
	};
}
	
