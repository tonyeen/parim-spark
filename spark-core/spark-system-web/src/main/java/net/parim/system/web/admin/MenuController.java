package net.parim.system.web.admin;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.i18n.LocaleContextHolder;
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

import net.parim.common.utils.StringUtils;
import net.parim.common.web.BaseController;
import net.parim.system.entity.Menu;
import net.parim.system.service.SystemService;

@Controller
@RequestMapping(value="${adminPath}/sys/menu")
public class MenuController extends BaseController {

	@Value("${adminPath}")
	private String adminPath;
	
	@Autowired
	SystemService systemService;
	
	@RequiresPermissions("system:menu:view")
	@RequestMapping(value="/")
	public String list(Model model){
		List<Menu> menus = systemService.findAllMenu();
		
		model.addAttribute("menuList", menus);
		return "admin/sys/menuList";
	}
	
	@RequiresPermissions("system:menu:edit")
	@RequestMapping(value="/properties")
	public String properties(Model model){
		model.addAttribute(new Menu());
		return "admin/sys/menuProperties";
	}
	
	@RequiresPermissions("system:menu:edit")
	@RequestMapping(value="/properties/{id}")
	public String properties(@PathVariable Long id, Model model){
		Menu menu = systemService.findMenuById(id);
		model.addAttribute(menu);
		
		return "admin/sys/menuProperties";
	}
	
	@RequiresPermissions("system:menu:edit")
	@RequestMapping(value="/addsub/{id}")
	public String addSub(@PathVariable Long id, Model model){
		Menu menu = new Menu();
		Menu parent = systemService.findMenuById(id);
		menu.setParent(parent);
		model.addAttribute(menu);
		
		return "admin/sys/menuProperties";
	}
	
	@RequiresPermissions("system:menu:edit")
	@RequestMapping(value="/save")
	public String save(@Valid Menu menu, BindingResult result, Model model, RedirectAttributes redirectAttributes){
		if(result.hasErrors()){
			addBindingError(model, result);
			return "admin/sys/menuProperties";
		}
		
		LocaleContextHolder.getLocale();
		
		systemService.saveMenu(menu);
		addSuccess(redirectAttributes, "menu.save.success", menu.getName());
		
		return "redirect:" + adminPath + "/sys/menu/";
	}
	
	@RequiresPermissions("system:menu:delete")
	@RequestMapping(value="/delete/{id}")
	public String delete(@PathVariable Long id, RedirectAttributes redirectAttributes){
		Menu menu = systemService.findMenuById(id);
		//menu.setId(id);
		systemService.removeMenu(menu);
		
		addSuccess(redirectAttributes, "menu.delete.success", menu.getName());
		
		return "redirect:" + adminPath + "/sys/menu/";
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
	public List<Map<String, Object>> treeData(@RequestParam(required=false) Long extId,@RequestParam(required=false) String isShowHide, HttpServletResponse response) {
		List<Map<String, Object>> mapList = Lists.newArrayList();
		List<Menu> menus = systemService.findAllMenu();
		Menu extMenu = systemService.findOne(extId);
		for (int i=0; i<menus.size(); i++){
			Menu menu = menus.get(i);
			if (StringUtils.isBlank(extId) || (extId!=null && !extId.equals(menu.getId()) && !isParent(menu, extMenu))){
				if(!menu.getIsShow()){
					continue;
				}
				Map<String, Object> map = Maps.newHashMap();
				map.put("id", menu.getId());
				map.put("pId", menu.getParentId());
				map.put("name", menu.getName());
				mapList.add(map);
			}
		}
		return mapList;
	}
	
	private boolean isParent(Menu child, Menu parent){
		List<Menu> menus = systemService.findAllParents(child);
		for(Menu menu: menus){
			if(menu.getId() == parent.getId()){
				return true;
			}
		}
		return false;
	}
}
