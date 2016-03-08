package net.parim.devwork.service;

import org.springframework.stereotype.Service;

import net.parim.common.service.CrudService;
import net.parim.devwork.entity.Project;
import net.parim.devwork.repository.ProjectRepository;

@Service
public class ProjectService extends CrudService<ProjectRepository, Project, Long> {

}
