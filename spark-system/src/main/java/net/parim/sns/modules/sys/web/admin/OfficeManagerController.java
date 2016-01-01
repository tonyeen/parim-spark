package net.parim.sns.modules.sys.web.admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import net.parim.sns.modules.sys.entity.Office;
import net.parim.sns.modules.sys.service.OfficeService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.common.collect.Lists;

@Controller
@RequestMapping(value="${adminPath}/sys/office")
public class OfficeManagerController {
	@Autowired
	OfficeService officeService;
	
	@RequestMapping(value="/")
	public String index() {
		return "admin/sys/officeIndex";
	}
	
	@RequestMapping(value="/list")
	public String list(Office office, Model model){
		List<Office> offices = officeService.findAll(office);
		model.addAttribute("offices", offices);
		
		return "admin/sys/officeList";
	}
	
	@RequestMapping(value="/properties")
	public String properties(Model model){
		model.addAttribute(new Office());
		
		return "admin/sys/officeProperties";
	}
	
	
	@RequestMapping(value="/treeData")
	@ResponseBody
	public List<Map<String, Object>> treeData(@RequestParam(required=false, defaultValue="0") Long extId){
		List<Map<String, Object>> mapList = Lists.newArrayList();
		List<Office> offices = officeService.findAll();//officeService.findChildren(extId);
		for(Office office : offices){
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("id", office.getId());
			map.put("pid", office.getParent().getId());
			map.put("name", office.getName());
			//map.put("isParent", true);
			mapList.add(map);
		}
		return mapList;
		
	}
}
