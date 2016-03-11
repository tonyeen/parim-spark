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
import net.parim.devwork.entity.ProjectReleaseList;
import net.parim.devwork.service.ProjectReleaseListService;

@Controller						   
@RequestMapping(value="${adminPath}/devwork/projectReleaseList/")
public class ProjectReleaseListController extends BaseController {
	@Value(value="${adminPath}")
	String adminPath;
	
	@Autowired
	private ProjectReleaseListService projectReleaseListService;
	
	@RequestMapping("list")
	public String projectReleaseListList(@PageableDefault Pageable pageable, ProjectReleaseList projectReleaseList, Model model){
		Page<ProjectReleaseList> projectReleaseLists = projectReleaseListService.findAll(projectReleaseList, pageable);
		model.addAttribute("projectReleaseLists", projectReleaseLists);
		return "admin/devwork/projectReleaseListList";
	}
	
	@RequestMapping(value={"properties", "properties/{id}"})
	public String projectReleaseListProperties(ProjectReleaseList projectReleaseList, Model model){
		
		if(null != projectReleaseList.getId() && !"".equals(projectReleaseList.getId()))
		{
			ProjectReleaseList valueProjectReleaseList = projectReleaseListService.findOne(projectReleaseList.getId());
			projectReleaseList = valueProjectReleaseList;
		}
		model.addAttribute(projectReleaseList);
		return "admin/devwork/projectReleaseListProperties";
	}
	
	@ModelAttribute
	public void getThemeline(@RequestParam(value = "id", defaultValue = "-1") Long id, Model model){
		if(id!=-1){
			ProjectReleaseList projectReleaseList = projectReleaseListService.findOne(id);
			model.addAttribute(projectReleaseList);
		}
	}
	
	@RequestMapping(value="save")
	public String saveprojectReleaseListProperties(ProjectReleaseList projectReleaseList, Model model){
		model.addAttribute(projectReleaseList);
		projectReleaseListService.save(projectReleaseList);
		return "redirect:"+adminPath+"/devwork/projectReleaseList/list";
	}
	
	@RequestMapping(value={"delete/{id}","deleteAll/{ids}"})
	public String deleteprojectReleaseListProperties(ProjectReleaseList projectReleaseList, Model model,@PathVariable(value="ids") String ids){
		List<String> idList = new ArrayList<String>();
		if("".equals(ids) || null == ids)
		{
			String idString = projectReleaseList.getId()+"";
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
		projectReleaseListService.deleteAll(idList);
		return "redirect:"+adminPath+"/devwork/projectReleaseList/list";
	}
	
	@RequestMapping(value="findone")
	public String findprojectReleaseList(@PageableDefault Pageable pageable,ProjectReleaseList projectReleaseList, Model model){
		Page<ProjectReleaseList> projectReleaseLists = projectReleaseListService.findAll(projectReleaseList, pageable);
		model.addAttribute("projectReleaseLists", projectReleaseLists);
		return "admin/devwork/projectReleaseListList";
	}
}
