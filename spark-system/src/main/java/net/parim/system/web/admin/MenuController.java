package net.parim.system.web.admin;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;

import net.parim.common.utils.StringUtils;
import net.parim.system.entity.Menu;
import net.parim.system.service.SystemService;

@Controller
@RequestMapping(value="${adminPath}/sys/menu")
public class MenuController {

	@Value("${adminPath}")
	private String adminPath;
	
	@Autowired
	SystemService systemService;
	
	
	@RequestMapping(value="/")
	public String list(Model model){
		List<Menu> menus = systemService.findAllMenu();
		
		model.addAttribute("menuList", menus);
		return "admin/sys/menuList";
	}
	
	@RequestMapping(value="/properties")
	public String properties(Model model){
		model.addAttribute(new Menu());
		return "admin/sys/menuProperties";
	}
	
	@RequestMapping(value="/properties/{id}")
	public String properties(@PathVariable Long id, Model model){
		Menu menu = systemService.findMenuById(id);
		model.addAttribute(menu);
		
		return "admin/sys/menuProperties";
	}
	
	@RequestMapping(value="/save")
	public String save(Menu menu, Model model, RedirectAttributes redirectAttributes){
		
		systemService.saveMenu(menu);
		//addMessage(redirectAttributes, "保存菜单'" + menu.getName() + "'成功");
		model.addAttribute("message", "保存菜单'" + menu.getName() + "'成功");
		
		return "redirect:" + adminPath + "/sys/menu/";
	}
	
	@RequestMapping(value="/delete/${id}")
	public String delete(@PathVariable Long id){
		Menu menu = new Menu();
		menu.setId(id);
		systemService.removeMenu(menu);
		
		return "redirect:/sys/menu/";
	}
	
	/**
	 * isShowHide是否显示隐藏菜单
	 * @param extId
	 * @param isShowHidden
	 * @param response
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "treeData")
	public List<Map<String, Object>> treeData(@RequestParam(required=false) String extId,@RequestParam(required=false) String isShowHide, HttpServletResponse response) {
		List<Map<String, Object>> mapList = Lists.newArrayList();
		List<Menu> menus = systemService.findAllMenu();
		for (int i=0; i<menus.size(); i++){
			Menu menu = menus.get(i);
			if (StringUtils.isBlank(extId) || (extId!=null && !extId.equals(menu.getId()) && menu.getParentIds().indexOf(","+extId+",")==-1)){
				if(!menu.getIsShow()){
					continue;
				}
				Map<String, Object> map = Maps.newHashMap();
				map.put("id", menu.getId());
				map.put("pId", menu.getParent().getId());
				map.put("name", menu.getName());
				mapList.add(map);
			}
		}
		return mapList;
	}
}
