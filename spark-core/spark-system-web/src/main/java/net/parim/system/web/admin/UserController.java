package net.parim.system.web.admin;

import java.io.File;

import javax.servlet.http.HttpServletResponse;

import net.parim.common.config.Global;
import net.parim.common.web.BaseController;
import net.parim.system.entity.PermissionTarget;
import net.parim.system.entity.PermissionTarget.ObjectType;
import net.parim.system.entity.Site;
import net.parim.system.entity.User;
import net.parim.system.entity.UserGroup;
import net.parim.system.service.SiteService;
import net.parim.system.service.UserGroupService;
import net.parim.system.service.UserService;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping(value="${adminPath}/sys/user")
public class UserController extends BaseController {
	
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
			//user.setId(null);
			user.setSite(site);
		}
		if(permissionTarget.getObjectType()==ObjectType.O){
			UserGroup userGroup = new UserGroup();
			userGroup.setId(permissionTarget.getId());
			//user.setId(null);
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
		
		userService.save(user);
		
		return "redirect:"+adminPath+"/sys/user/list";
	}
	
	/**
	 * 上传附件
	 * @param uploadFile
	 * @return
	 */
	//后台访问路径加"admin"，加上根访问路径，完整地址为：http://localhost/elearn/demo/admin/upload
	@RequestMapping(value="/import", method=RequestMethod.POST)
	//@ResponseBody
	public String importUser(@RequestParam("file")MultipartFile uploadFile, RedirectAttributes redirectAttributes /* Model model, HttpServletResponse response*/) {
		try {
			String suffix = uploadFile.getOriginalFilename().substring(uploadFile.getOriginalFilename().lastIndexOf("."));
			File file = new File(Global.getConfig("userfiles.basedir")+ File.separator + System.currentTimeMillis() + suffix);
			FileUtils.writeByteArrayToFile(file, uploadFile.getBytes());
		} catch (Exception e) {
			addError(redirectAttributes, "user.import.error", uploadFile.getOriginalFilename());
		}
		addSuccess(redirectAttributes, "user.import.success", uploadFile.getOriginalFilename());
		
		//return renderString(response, "success");
		return "redirect:"+adminPath+"/sys/user/list";
	}
}
