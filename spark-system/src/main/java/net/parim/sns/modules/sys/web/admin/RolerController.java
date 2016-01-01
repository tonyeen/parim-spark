package net.parim.sns.modules.sys.web.admin;

import net.parim.sns.modules.sys.entity.Role;
import net.parim.sns.modules.sys.service.RoleService;

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
@RequestMapping(value="${adminPath}/sys/role")
public class RolerController {
	
	@Autowired
	RoleService roleService;
	@Value(value="${adminPath}")
	String adminPath;
	
	@RequestMapping(value="/list")
	public String list(@PageableDefault Pageable pageable, Role role, Model model){
		Page<Role> roles = roleService.findAllRoles(role, pageable);
		model.addAttribute("roles", roles);
		
		return "admin/sys/roleList";
	}
	
	@RequestMapping(value="/properties")
	public String properties(Model model){
		model.addAttribute(new Role());
		return "admin/sys/roleProperties"; 
	}
	
	@RequestMapping(value="/properties/{id}")
	public String properties(@PathVariable Long id, Model model){
		Role role = roleService.findRoleById(id);
		model.addAttribute(role);
		return "admin/sys/roleProperties"; 
	}
	
	@RequestMapping(value="/save")
	public String save(Role role, Model model){
		
		roleService.saveRole(role);
		
		return "redirect:"+adminPath+"/sys/role/list";
	}
}
