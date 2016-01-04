package net.parim.system.web.admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import net.parim.system.entity.PermissionTarget;
import net.parim.system.entity.Site;
import net.parim.system.entity.UserGroup;
import net.parim.system.entity.PermissionTarget.ObjectType;
import net.parim.system.service.UserGroupService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.common.collect.Lists;

@Controller
@RequestMapping(value="${adminPath}/sys/org")
public class OrgController {
	@Autowired
	UserGroupService userGroupService;
	
	@Value(value="${adminPath}")
	private String adminPath;
	
	@RequestMapping(value="/")
	public String index() {
		return "admin/sys/orgIndex";
	}
	
	@RequestMapping(value="/list")
	public String list(UserGroup org, Model model){
		List<UserGroup> orgs = userGroupService.findAll(org);
		model.addAttribute("orgs", orgs);
		
		return "admin/sys/orgList";
	}
	
	@RequestMapping(value="/properties")
	public String properties(Model model){
		model.addAttribute("org",new UserGroup());
		
		return "admin/sys/orgProperties";
	}
	
	@RequestMapping(value="/save")
	public String save(PermissionTarget permissionTarget, UserGroup userGroup,
				RedirectAttributes redirectAttributes, Model model){
		if(permissionTarget.getParent().getObjectType()!=null 
				&& permissionTarget.getParent().getObjectType()== ObjectType.S){
			Site site = new Site();
			site.setId(permissionTarget.getParent().getId());
			userGroup.setParent(null);
			userGroup.setSite(site);
		}
		if(permissionTarget.getParent().getObjectType()!=null 
				&& permissionTarget.getParent().getObjectType()== ObjectType.O){
			UserGroup parent = new UserGroup();
			parent.setId(permissionTarget.getParent().getId());
			userGroup.setParent(parent);
		}
		
		userGroupService.save(userGroup);
		
		return "redirect:"+adminPath+"/sys/org/list";
	}
	
	
	@RequestMapping(value="/treeData")
	@ResponseBody
	public List<Map<String, Object>> treeData(@RequestParam(required=false, defaultValue="0") Long extId){
		List<Map<String, Object>> mapList = Lists.newArrayList();
		List<UserGroup> orgs = userGroupService.findAll();//orgService.findChildren(extId);
		for(UserGroup org : orgs){
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("id", org.getId());
			map.put("pid", org.getParent().getId());
			map.put("name", org.getName());
			//map.put("isParent", true);
			mapList.add(map);
		}
		return mapList;
		
	}
}
