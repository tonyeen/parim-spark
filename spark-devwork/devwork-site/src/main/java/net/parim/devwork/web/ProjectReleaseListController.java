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
import net.parim.devwork.entity.ProjectReleaseList;
import net.parim.devwork.service.ProjectReleaseListService;

@Controller						   
@RequestMapping(value="${adminPath}/devwork/projectReleaseList/")
public class ProjectReleaseListController extends BaseController {
	@Value(value="${adminPath}")
	String adminPath;
	
	@Autowired
	private ProjectReleaseListService projectReleaseListService;
	//列表显示
	@RequestMapping("list")
	public String projectReleaseListList(@PageableDefault Pageable pageable, ProjectReleaseList projectReleaseList, Model model){
		Page<ProjectReleaseList> projectReleaseLists = projectReleaseListService.findAll(projectReleaseList, pageable);
		model.addAttribute("projectReleaseLists", projectReleaseLists);
		return "admin/devwork/projectReleaseListList";
	}
	//修改、增加前的跳转方法
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
	
	//保存
	@RequestMapping(value="save")
	public String saveprojectReleaseListProperties(ProjectReleaseList projectReleaseList, Model model){
		model.addAttribute(projectReleaseList);
		projectReleaseListService.save(projectReleaseList);
		return "redirect:"+adminPath+"/devwork/projectReleaseList/list";
	}
	//单条、批量删除
	@RequestMapping(value="deleteAll/{ids}")
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
				//如果单条删除
			}else{
				idList.add(ids);
			}
		}
		projectReleaseListService.deleteAll(idList);
		return "redirect:"+adminPath+"/devwork/projectReleaseList/list";
	}
	//模糊查询
	@RequestMapping(value="findone")
	public String findprojectReleaseList(@PageableDefault Pageable pageable,ProjectReleaseList projectReleaseList, Model model){
		Page<ProjectReleaseList> projectReleaseLists = projectReleaseListService.findAll(projectReleaseList, pageable);
		model.addAttribute("projectReleaseLists", projectReleaseLists);
		return "admin/devwork/projectReleaseListList";
	}
	
}
