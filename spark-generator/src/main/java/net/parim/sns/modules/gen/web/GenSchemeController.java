/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package net.parim.sns.modules.gen.web;

import net.parim.common.utils.StringUtils;
import net.parim.common.web.BaseController;
import net.parim.sns.modules.gen.entity.GenScheme;
import net.parim.sns.modules.gen.service.GenSchemeService;
import net.parim.sns.modules.gen.service.GenTableService;
import net.parim.sns.modules.gen.util.GenUtils;
import net.parim.system.security.UserToken;
import net.parim.system.utils.UserUtils;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

/**
 * 生成方案Controller
 * @author ThinkGem
 * @version 2013-10-15
 */
@Controller
@RequestMapping(value = "${adminPath}/gen/genScheme")
public class GenSchemeController extends BaseController {

	@Autowired
	private GenSchemeService genSchemeService;
	
	@Autowired
	private GenTableService genTableService;
	
	@ModelAttribute
	public GenScheme get(@RequestParam(required=false) Long id) {
		if (StringUtils.isNotBlank(id)){
			return genSchemeService.get(id);
		}else{
			return new GenScheme();
		}
	}
	
	//@RequiresPermissions("gen:genScheme:view")
	@RequestMapping(value = {"list", ""})
	public String list(@PageableDefault Pageable pageable, GenScheme genScheme, Model model) {
		UserToken user = UserUtils.getUserToken();
		if (!user.isAdmin()){
			genScheme.setCreatedBy(user);
		}
        Page<GenScheme> page = genSchemeService.find(genScheme, pageable); 
        model.addAttribute("page", page);
		
		return "admin/gen/genSchemeList";
	}

	//@RequiresPermissions("gen:genScheme:view")
	@RequestMapping(value = "form")
	public String form(GenScheme genScheme, Model model) {
		if (StringUtils.isBlank(genScheme.getPackageName())){
			genScheme.setPackageName("net.parim.modules");
		}
//		if (StringUtils.isBlank(genScheme.getFunctionAuthor())){
//			genScheme.setFunctionAuthor(UserUtils.getUser().getName());
//		}
		model.addAttribute("genScheme", genScheme);
		model.addAttribute("config", GenUtils.getConfig());
		model.addAttribute("tableList", genTableService.findAll());
		return "admin/gen/genSchemeForm";
	}

	//@RequiresPermissions("gen:genScheme:edit")
	@RequestMapping(value = "save")
	public String save(GenScheme genScheme, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, genScheme)){
			return form(genScheme, model);
		}
		
		String result = genSchemeService.save(genScheme);
		addMessage(redirectAttributes, "操作生成方案'" + genScheme.getName() + "'成功<br/>"+result);
		
		// 跳转到生成方案代码
		if ("1".equals(genScheme.getFlag())){
			redirectAttributes.addAttribute(genScheme);
			return "redirect:" + adminPath + "/gen/genScheme/generate/step1";
		}
		
		return "redirect:" + adminPath + "/gen/genScheme/?repage";
	}
	
	//@RequiresPermissions("gen:genScheme:edit")
	@RequestMapping(value = "delete")
	public String delete(GenScheme genScheme, RedirectAttributes redirectAttributes) {
		genSchemeService.delete(genScheme);
		addMessage(redirectAttributes, "删除生成方案成功");
		return "redirect:" + adminPath + "/gen/genScheme/?repage";
	}
	
	@RequestMapping(value = "generate/step1")
	public String generateStep1(GenScheme genScheme, Model model){
		model.addAttribute("genScheme", genScheme);
		return "admin/gen/generateStep1";
	}
	
	@RequestMapping(value = "generate/step2")
	public String generateStep2(GenScheme genScheme, @RequestParam(value="projectDir") String projectDir, Model model, RedirectAttributes redirectAttributes){
		if(null==projectDir || "".equals(projectDir.trim())){
			addError(redirectAttributes, "generator.select.project-dir.error");
			redirectAttributes.addFlashAttribute("genScheme", genScheme);
			return "redirect:" + adminPath + "/gen/genScheme/generate/step1";
		}
		
		genScheme.setProjectDir(projectDir);
		String result = genSchemeService.generateCode(genScheme);
		
		addMessage(model, result);
		
		model.addAttribute("genScheme", genScheme);
		return "admin/gen/generateStep2";
	}
}
