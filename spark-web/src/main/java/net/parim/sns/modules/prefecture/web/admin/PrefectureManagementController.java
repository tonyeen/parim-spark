package net.parim.sns.modules.prefecture.web.admin;

import java.util.List;

import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import net.parim.sns.modules.prefecture.entity.Category;
import net.parim.sns.modules.prefecture.entity.Prefecture;
import net.parim.sns.modules.prefecture.service.PrefectureService;

@Controller
@RequestMapping(value="${adminPath}/prefecture")
public class PrefectureManagementController {
	Logger logger =LoggerFactory.getLogger(getClass());
	
	@Value("${adminPath}")
	private String adminPath;
	
	@Autowired
	PrefectureService prefectureService;
	
	
	@RequestMapping(value="/")
	public String index(Prefecture prefecture, 
			@PageableDefault Pageable pageable, Model model){
		
		Page<Prefecture> prefectures = prefectureService.findAll(prefecture, pageable);
		model.addAttribute("prefectures", prefectures);
		model.addAttribute("prefecture", prefecture);
		return "/admin/prefecture/prefectureList";
	}
	
	@RequestMapping(value="/published")
	public String published(Prefecture prefecture, 
			@PageableDefault Pageable pageable, Model model){
		prefecture.setId(12L);
		
		Page<Prefecture> prefectures = prefectureService.findAll(prefecture, pageable);
		model.addAttribute("prefectures", prefectures);
		model.addAttribute("prefecture", prefecture);
		model.addAttribute("tabActive", "published");
		return "/admin/prefecture/prefectureList";
	}
	
	@RequestMapping(value="/properties")
	public String properties(Model model){
		List<Category> categories = prefectureService.findAllCategory();
		model.addAttribute("categories", categories);
		model.addAttribute("prefecture", new Prefecture());
		return "/admin/prefecture/prefectureProperties";
	}
	
	@RequestMapping(value="/properties/{id}")
	public String properties(@PathVariable Long id,Model model){
		Prefecture prefecture = prefectureService.findOne(id);
		List<Category> categories = prefectureService.findAllCategory();
		
		model.addAttribute("prefecture", prefecture);
		model.addAttribute("categories", categories);
		return "/admin/prefecture/prefectureProperties";
	}
	
	@RequestMapping(value="/save")
	public String save(@Valid Prefecture prefecture, BindingResult result,
				RedirectAttributes redirectAttributes,
				Model model){
		//数据绑定错误，或者校验失败
		if(result.hasErrors()){
			List<FieldError> errors = result.getFieldErrors();
			for(FieldError error : errors){
				logger.debug(error.getDefaultMessage());
				model.addAttribute("ERR_"+error.getField(), error.getDefaultMessage());
			}
			
			model.addAttribute("prefecture", prefecture);
			return "/admin/prefecture/prefectureProperties";
		}
		
		prefectureService.save(prefecture);
		
		return "redirect:"+ adminPath +"/prefecture/";
	}
	
}
