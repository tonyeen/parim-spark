package net.parim.system.web.admin;

import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import net.parim.system.entity.Site;
import net.parim.system.service.SiteService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;

@Controller
@RequestMapping(value="${adminPath}/sys/site")
public class SiteController {
	@Autowired
	private SiteService siteService;
	
	@Value(value="${adminPath}")
	private String adminPath;
	
	@RequestMapping(value="/")
	public String index(Model model){
		List<Site> rootSites = siteService.findRoots();
		model.addAttribute("roots", rootSites);
		//return "admin/sys/siteIndex";
		return "redirect:"+adminPath+"/sys/site/list";
	}
	
	@RequestMapping(value="/list")
	public String list(Site site, Model model){
		//List<Site> sites = siteService.findChildren(site);
		List<Site> sites = siteService.findAll();
		model.addAttribute("sites", sites);
		
		return "admin/sys/siteList";
	}
	
	@RequestMapping(value="/properties")
	public String properties(Model model){
		model.addAttribute(new Site());
		
		return "admin/sys/siteProperties";
	}
	
	@RequestMapping(value="/properties/{id}")
	public String properties(@PathVariable Long id, Model model){
		Site site = siteService.findOne(id);
		model.addAttribute(site);
		
		return "admin/sys/siteProperties";
	}
	
	@RequestMapping(value="/save")
	public String save(@Valid Site site, BindingResult bindingResult, RedirectAttributes redirectAttributes, Model model){
		if(bindingResult.hasErrors()){
			
			return "admin/sys/siteProperties";
		}
		siteService.save(site);
		return "redirect:"+adminPath+"/sys/site/";
	}
	
	@RequestMapping(value="/delete/{id}")
	public String delete(@PathVariable Long id, RedirectAttributes redirectAttributes, Model model){
		siteService.remove(new Site(id));
		return "redirect:"+adminPath+"/sys/site/";
	}
	
	@RequestMapping(value="/treeData")
	@ResponseBody
	public List<Site> treeData(@RequestParam(required=false, defaultValue="0") Long id, Model model){
		return siteService.findChildren(new Site(id));
	}
	
	@RequestMapping(value="/treeSelectData")
	@ResponseBody
	public List<Map<String, Object>> treeSelectData(@RequestParam(required=false, defaultValue="0") Long extId, Model model){
		List<Map<String, Object>> mapList = Lists.newArrayList();
		List<Site> sites = siteService.findAll();
		for (int i=0; i<sites.size(); i++){
			Site site = sites.get(i);
			
			Map<String, Object> map = Maps.newHashMap();
			map.put("id", site.getId());
			map.put("pId", site.getParentId());
			map.put("name", site.getName());
			mapList.add(map);
		}
		return mapList;
	}
}
