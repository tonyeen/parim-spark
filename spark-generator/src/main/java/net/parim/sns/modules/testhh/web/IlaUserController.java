/**
 * Copyright &copy; 2012-2014 <a href="http://spark.parim.net">Parim Stark Team</a> All rights reserved.
 */
package net.parim.sns.modules.testhh.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import net.parim.common.config.Global;
import net.parim.common.web.BaseController;
import net.parim.common.utils.StringUtils;
import net.parim.sns.modules.testhh.entity.IlaUser;
import net.parim.sns.modules.testhh.service.IlaUserService;

/**
 * 静静地测试Controller
 * @author Tony
 * @version 2016-01-05
 */
@Controller
@RequestMapping(value = "${adminPath}/testhh/ilaUser")
public class IlaUserController extends BaseController {

	@Autowired
	private IlaUserService ilaUserService;
	
	@ModelAttribute
	public IlaUser get(@RequestParam(required=false) Long id) {
		IlaUser entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = ilaUserService.findOne(id);
		}
		if (entity == null){
			entity = new IlaUser();
		}
		return entity;
	}
	
	@RequiresPermissions("testhh:ilaUser:view")
	@RequestMapping(value = {"list", ""})
	public String list(@PageableDefault Pageable pageable, IlaUser ilaUser, Model model) {
		Page<IlaUser> page = ilaUserService.findAll(ilaUser, pageable); 
		model.addAttribute("page", page);
		return "modules/testhh/ilaUserList";
	}

	@RequiresPermissions("testhh:ilaUser:view")
	@RequestMapping(value = "properties")
	public String properties(IlaUser ilaUser, Model model) {
		model.addAttribute("ilaUser", ilaUser);
		return "modules/testhh/ilaUserProperties";
	}

	@RequiresPermissions("testhh:ilaUser:edit")
	@RequestMapping(value = "save")
	public String save(@Valid IlaUser ilaUser, BindingResult bindingResult, Model model, RedirectAttributes redirectAttributes) {
		if (bindingResult.hasErrors()){
		    addBindingError(model, bindingResult);
			return properties(ilaUser, model);
		}
		ilaUserService.save(ilaUser);
		addSuccess(redirectAttributes, "object.save.success", "功能名称");
		return "redirect:"+ adminPath +"/testhh/ilaUser/";
	}
	
	@RequiresPermissions("testhh:ilaUser:delete")
	@RequestMapping(value = "delete")
	public String delete(IlaUser ilaUser, RedirectAttributes redirectAttributes) {
		ilaUserService.delete(ilaUser);
		addSuccess(redirectAttributes, "object.delete.success", "功能名称");
		return "redirect:"+ adminPath +"/testhh/ilaUser/";
	}

}