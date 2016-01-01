package net.parim.sns.modules.sys.web.admin;

import java.util.List;

import net.parim.sns.modules.sys.entity.PermissionTarget;
import net.parim.sns.modules.sys.service.UserGroupTreeService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping(value="${adminPath}/sys/userGroupTree")
public class UserGroupTreeController {
	
	@Autowired
	UserGroupTreeService userGroupTreeService;
	
	@RequestMapping(value="/roots")
	@ResponseBody
	public List<?> roots(){
		return userGroupTreeService.getPermissionRoots();
	}
	
	@RequestMapping(value="/children")
	@ResponseBody
	public List<?> children(@RequestParam(value="id") Long id){
		PermissionTarget permissionTarget = new PermissionTarget();
		permissionTarget.setId(id);
		
		return userGroupTreeService.getChildren(permissionTarget);
	}
}
