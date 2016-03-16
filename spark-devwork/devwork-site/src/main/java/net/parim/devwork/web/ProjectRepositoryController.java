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
import net.parim.devwork.entity.ProjectRepository;
import net.parim.devwork.service.ProjectRepositoryService;

@Controller						   
@RequestMapping(value="${adminPath}/devwork/projectRepository/")
public class ProjectRepositoryController extends BaseController {
	@Value(value="${adminPath}")
	String adminPath;
	
	@Autowired
	private ProjectRepositoryService projectRepositoryService;
	//列表显示
	@RequestMapping("list")
	public String projectRepositoryList(@PageableDefault Pageable pageable, ProjectRepository projectRepository, Model model){
		Page<ProjectRepository> projectRepositories = projectRepositoryService.findAll(projectRepository, pageable);
		model.addAttribute("projectRepositories", projectRepositories);
		return "admin/devwork/projectRepositoryList";
	}
	//增加、修改前的跳转方法
	@RequestMapping(value={"properties", "properties/{id}"})
	public String projectRepositoryProperties(ProjectRepository projectRepository, Model model){
		
		if(null != projectRepository.getId() && !"".equals(projectRepository.getId()))
		{
			ProjectRepository valueProjectRepository = projectRepositoryService.findOne(projectRepository.getId());
			projectRepository = valueProjectRepository;
		}
		model.addAttribute(projectRepository);
		return "admin/devwork/projectRepositoryProperties";
	}
	//设定前台传来的id为long
	@ModelAttribute
	public void getThemeline(@RequestParam(value = "id", defaultValue = "-1") Long id, @RequestParam(value = "ids", required = false) String ids,Model model){
		if(id!=-1){
			ProjectRepository projectRepository = projectRepositoryService.findOne(id);
			model.addAttribute(projectRepository);
		}
	}
	//保存
	@RequestMapping(value="save")
	public String saveProjectRepositoryProperties(ProjectRepository projectRepository, Model model){
		model.addAttribute(projectRepository);
		projectRepositoryService.save(projectRepository);
		return "redirect:"+adminPath+"/devwork/projectRepository/list";
	}
	//单条、批量删除
	@RequestMapping(value="deleteAll/{ids}")
	public String deleteProjectRepositoryProperties(ProjectRepository projectRepository, Model model,@PathVariable(value="ids") String ids){
		List<String> idList = new ArrayList<String>();
		if("".equals(ids) || null == ids)
		{
			String idString = projectRepository.getId()+"";
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
		projectRepositoryService.deleteAll(idList);
		return "redirect:"+adminPath+"/devwork/projectRepository/list";
	}
	//模糊查询
	@RequestMapping(value="findone")
	public String findProjectRepository(@PageableDefault Pageable pageable,ProjectRepository projectRepository, Model model){
		Page<ProjectRepository> projectRepositories = projectRepositoryService.findAll(projectRepository, pageable);
		model.addAttribute("projectRepositories", projectRepositories);
		return "admin/devwork/projectRepositoryList";
	}
}
