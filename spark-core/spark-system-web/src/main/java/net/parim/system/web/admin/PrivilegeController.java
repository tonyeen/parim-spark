package net.parim.system.web.admin;

import net.parim.system.entity.Privilege;
import net.parim.system.service.PrivilegeService;

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
@RequestMapping(value="${adminPath}/sys/privilege")
public class PrivilegeController {
	@Value(value="${adminPath}")
	String adminPath;
	
	@Autowired
	PrivilegeService privilegeService;
	
	@RequestMapping(value="/list")
	public String list(@PageableDefault Pageable pageable, Privilege privilege, Model model){
		Page<Privilege> privs = privilegeService.findAllPrivileges(privilege, pageable);
		model.addAttribute("privileges", privs);
		
		return "admin/sys/privilegeList";
	}
	
	@RequestMapping(value="/properties")
	public String properties(Model model){
		model.addAttribute(new Privilege());
		return "admin/sys/privilegeProperties"; 
	}
	
	@RequestMapping(value="/properties/{id}")
	public String properties(@PathVariable String id, Model model){
		Privilege priv = privilegeService.findPrivilegeById(id);
		model.addAttribute(priv);
		return "admin/sys/privilegeProperties"; 
	}
	
	@RequestMapping(value="/save")
	public String save(Privilege privilege, Model model){
		privilegeService.savePrivilege(privilege);
		
		return "redirect:"+adminPath+"/sys/privilege/list";
	}
}
