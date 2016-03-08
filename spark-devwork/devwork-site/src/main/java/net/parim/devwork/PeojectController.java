package net.parim.devwork;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import net.parim.common.web.BaseController;
import net.parim.devwork.entity.Project;
import net.parim.devwork.service.ProjectService;

@Controller
@RequestMapping("${adminPath}/devwork/project/")
public class PeojectController extends BaseController {
	
	@Autowired
	private ProjectService projectService;
	
	@RequestMapping("list")
	public String projectList(@PageableDefault Pageable pageable, Project project, Model model){
		Page<Project> projects = projectService.findAll(project, pageable);
		
		model.addAttribute("projects", projects);
		
		return "admin/devwork/projectList";
	}
	
	@RequestMapping(value={"properties", "properties/{id}"})
	public String projectProperties(Project project, Model model){
		model.addAttribute(project);
		return "admin/devwork/projectProperties";
	}
	
	@ModelAttribute
	public void getThemeline(@RequestParam(value = "id", defaultValue = "-1") Long id, Model model){
		if(id!=-1){
			Project project = projectService.findOne(id);
			model.addAttribute(project);
		}
	}
}
