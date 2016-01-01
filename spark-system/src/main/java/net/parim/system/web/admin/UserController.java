package net.parim.system.web.admin;

import net.parim.system.entity.PermissionTarget;
import net.parim.system.entity.Site;
import net.parim.system.entity.User;
import net.parim.system.entity.UserGroup;
import net.parim.system.entity.PermissionTarget.ObjectType;
import net.parim.system.service.SiteService;
import net.parim.system.service.UserGroupService;
import net.parim.system.service.UserService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping(value="${adminPath}/sys/user")
public class UserController {
	
	@Autowired
	UserService userService;
	@Value(value="${adminPath}")
	String adminPath;
	@Autowired
	SiteService siteService;
	@Autowired
	UserGroupService userGroupService;
	
	@RequestMapping(value="/")
	public String index(){
		return "admin/sys/userIndex";
	}
	
	@RequestMapping(value="/list")
	public String list(@PageableDefault Pageable pageable,PermissionTarget permissionTarget, User user, Model model){
		if(permissionTarget.getObjectType()==ObjectType.S){
			Site site = new Site();
			site.setId(permissionTarget.getId());
			user.setId(null);
			user.setSite(site);
		}
		if(permissionTarget.getObjectType()==ObjectType.O){
			UserGroup userGroup = new UserGroup();
			userGroup.setId(permissionTarget.getId());
			user.setId(null);
			user.setUserGroup(userGroup);
		}
		
		Page<User> users = userService.findAll(user, pageable);
		model.addAttribute("users", users);
		
		return "admin/sys/userList";
	}
	
	@RequestMapping(value="/properties")
	public String properties(Model model){
		model.addAttribute(new User());
		return "admin/sys/userProperties"; 
	}
	
	@RequestMapping(value="/properties/{id}")
	public String properties(@PathVariable Long id, Model model){
		User user = userService.findOne(id);
		model.addAttribute(user);
		return "admin/sys/userProperties"; 
	}
	
	@RequestMapping(value="/save")
	public String save(User user, PermissionTarget pt, Model model){
		if (pt.getParent().getObjectType()==ObjectType.S) {
			Site site = new Site(pt.getParentId());
			user.setSite(site);
		}else if (pt.getParent().getObjectType()==ObjectType.O) {
			UserGroup userGroup = userGroupService.findOne(pt.getParentId());
			user.setUserGroup(userGroup);
			user.setSite(userGroup.getSite());
		}
		
		user.setSalt("df");
		
		userService.save(user);
		
		return "redirect:"+adminPath+"/sys/user/list";
	}
}
