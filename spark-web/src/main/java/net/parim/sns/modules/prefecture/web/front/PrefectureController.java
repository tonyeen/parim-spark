package net.parim.sns.modules.prefecture.web.front;

import java.util.List;

import net.parim.sns.modules.prefecture.entity.Prefecture;
import net.parim.sns.modules.prefecture.service.PrefectureService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping(value={"/prefecture", "/front/prefecture"})
public class PrefectureController {

	@Autowired
	private PrefectureService prefectureService;
	
	@RequestMapping(value = {"", "/", "/index"}, method = RequestMethod.GET)
	public String index(Model model){
		List<Prefecture> choicenessPrefectures = null ;//= prefectureService.getChoicenessList(new Prefecture(), );
		List<Prefecture> departmentaPrefectures = prefectureService.getDepartmentalList(6);
		
		model.addAttribute("choicenessPrefectures", choicenessPrefectures);
		model.addAttribute("departmentaPrefectures", departmentaPrefectures);
		
		return "/prefecture/index";
	}
}
