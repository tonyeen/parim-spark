package net.parim.devwork.service;

import java.util.List;

import org.springframework.stereotype.Service;

import net.parim.common.service.CrudService;
import net.parim.devwork.entity.Project;
import net.parim.devwork.repository.ProjectRepository;

@Service
public class ProjectService extends CrudService<ProjectRepository, Project, Long> {

	public void deleteAll(List<String> idList){
		repository.deleteAll(idList);
	};
}
