package net.parim.devwork.web;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import net.parim.common.web.BaseController;
import net.parim.devwork.entity.Project;
import net.parim.devwork.service.ProjectService;

@Controller
@RequestMapping(value="${adminPath}/devwork/project/")
public class PeojectController extends BaseController {
	@Value(value="${adminPath}")
	String adminPath;
	
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
		
		if(null != project.getId() && !"".equals(project.getId()))
		{
			Project valueProject = projectService.findOne(project.getId());
			project = valueProject;
		}
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
	
	@RequestMapping(value="save")
	public String saveProjectProperties(Project project, Model model){
		model.addAttribute(project);
		projectService.save(project);
		return "redirect:"+adminPath+"/devwork/project/list";
	}
	
	@RequestMapping(value={"delete/{id}","deleteAll/{ids}"})
	public String deleteProjectProperties(Project project, Model model,@PathVariable(value="ids") String ids){
		List<String> idList = new ArrayList<String>();
		if("".equals(ids) || null == ids)
		{
			String idString = project.getId()+"";
			idList.add(idString);
		}else{
			if(ids.contains(","))
			{
				String[] idArray = ids.split(",");
				
				for(String idString : idArray)
				{
					idList.add(idString);
				}
			}
		}
		projectService.deleteAll(idList);
		return "redirect:"+adminPath+"/devwork/project/list";
	}
	
	@RequestMapping(value="findone")
	public String findProject(@PageableDefault Pageable pageable,Project project, Model model){
		Page<Project> projects = projectService.findAll(project, pageable);
		model.addAttribute("projects", projects);
		return "admin/devwork/projectList";
	}
}
