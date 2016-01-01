package net.parim.system.web;

import net.parim.common.config.Global;
import net.parim.system.interceptor.ThemeInterceptor.UseTheme;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class AuthenticateController {

	@RequestMapping(value={"/login", "${adminPath}/login"}, method=RequestMethod.GET)
	@UseTheme(value=false)
	public String login(Model model){
		
		return Global.getThemePath()+"login";
	}
	
	@RequestMapping(value={"/login", "${adminPath}/login"}, method=RequestMethod.POST)
	@UseTheme(value=false)
	public String loginFailed(Model model){
		
		return Global.getThemePath()+"login";
	}
	
	@RequestMapping(value={"/logout", "${adminPath}/logout"}, method=RequestMethod.GET)
	@UseTheme(value=false)
	public String logout(Model model){
		
		return Global.getThemePath()+"login";
	}
}
