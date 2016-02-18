package net.parim.system.web.admin;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping(value="${adminPath}/tag")
public class TagController {
	
	@RequestMapping(value="/treeselect")
	public String treeselect(HttpServletRequest request, Model model) {
		model.addAttribute("url", request.getParameter("url")); 	// 树结构数据URL
		model.addAttribute("asyncUrl", request.getParameter("asyncUrl")); 	// 树结构数据URL
		model.addAttribute("isAsync", request.getParameter("isAsync")); 	// 树结构数据URL
		model.addAttribute("extId", request.getParameter("extId")); // 排除的编号ID
		model.addAttribute("checked", request.getParameter("checked")); // 是否可复选
		model.addAttribute("selectIds", request.getParameter("selectIds")); // 指定默认选中的ID
		model.addAttribute("isAll", request.getParameter("isAll")); 	// 是否读取全部数据，不进行权限过滤
		model.addAttribute("module", request.getParameter("module"));	// 过滤栏目模型（仅针对CMS的Category树）
		model.addAttribute("simpleData", request.getParameter("simpleData"));	// 过滤栏目模型（仅针对CMS的Category树）
		return "admin/sys/tagTreeselect";
	}
	
	@RequestMapping(value = "/iconselect")
	public String iconselect(HttpServletRequest request, Model model) {
		model.addAttribute("value", request.getParameter("value"));
		return "admin/sys/tagIconselect";
	}
}
