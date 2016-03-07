package net.parim.system.web.admin;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import net.parim.system.entity.Dict;
import net.parim.system.entity.PermissionTarget;
import net.parim.system.entity.PermissionTarget.ObjectType;
import net.parim.system.entity.Site;
import net.parim.system.entity.UserGroup;
import net.parim.system.service.DictService;

@Controller
@RequestMapping(value="${adminPath}/sys/dict")
public class DictController {
	
	@Value(value="${adminPath}")
	String adminPath;

	@Autowired
	DictService dictService;
	
	@RequestMapping(value="/list")
	public String list(@PageableDefault Pageable pageable,PermissionTarget permissionTarget,Dict dict,Model model){
		if(permissionTarget.getObjectType()==ObjectType.S){
			Site site = new Site();
			site.setId(permissionTarget.getId());
		}
		if(permissionTarget.getObjectType()==ObjectType.O){
			UserGroup userGroup = new UserGroup();
			userGroup.setId(permissionTarget.getId());
		}
		
		if(null == dict)
		{
			dict = new Dict();
		}
		Page<Dict> dicts = dictService.findAll(dict, pageable);
		model.addAttribute("dicts",dicts);
		return "admin/sys/dictList";
	}
	
	@RequestMapping(value="/properties")
	public String properties(Model model){
		model.addAttribute(new Dict());
		return "admin/sys/dictProperties"; 
	}
	
	@RequestMapping(value="/save")
	public String save(Dict dict, PermissionTarget pt, Model model){
		dictService.save(dict);
		return "redirect:"+adminPath+"/sys/dict/list";
	}
	
	@RequestMapping(value="/properties/{id}")
	public String properties(@PathVariable Long id, Model model){
		Dict dict = dictService.findOne(id);
		model.addAttribute(dict);
		return "admin/sys/dictProperties"; 
	}
	
	//@RequiresPermissions("system:menu:delete")
	@RequestMapping(value="/delete/{id}")
	public String delete(@PathVariable Long id){
		Dict dict = dictService.findOne(id);
		if(dict != null)
		{
			dictService.delete(id);
		}
		return "redirect:" + adminPath + "/sys/dict/list";
	}
}
