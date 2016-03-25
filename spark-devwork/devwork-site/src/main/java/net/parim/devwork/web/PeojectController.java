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
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

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
	
	//列表数据显示
	@RequestMapping("list")
	public String projectList(@PageableDefault Pageable pageable, Project project, Model model){
		Page<Project> projects = projectService.findAll(project, pageable);
		model.addAttribute("projects", projects);
		return "admin/devwork/projectList";
	}
	
	//修改、增加的跳转方法
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
	
	//保存
	@RequestMapping(value="save")
	public String saveProjectProperties(Project project, Model model){
		model.addAttribute(project);
		projectService.save(project);
		return "redirect:"+adminPath+"/devwork/project/list";
	}
	//单条、批量删除
	@RequestMapping(value="deleteAll/{ids}")
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
				//如果单条删除
			}else{
				idList.add(ids);
			}
		}
		projectService.deleteAll(idList);
		return "redirect:"+adminPath+"/devwork/project/list";
	}
	//模糊查询
	@RequestMapping(value="findone")
	public String findProject(@PageableDefault Pageable pageable,Project project, Model model){
		Page<Project> projects = projectService.findAll(project, pageable);
		model.addAttribute("projects", projects);
		return "admin/devwork/projectList";
	}
}
