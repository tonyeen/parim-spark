package net.parim.system.utils;

import java.util.List;

import net.parim.common.utils.SpringContextHolder;
import net.parim.system.entity.Menu;
import net.parim.system.repository.MenuRepository;
import net.parim.system.repository.UserRepository;
import net.parim.system.security.UserToken;

public class UserUtils {
	
	private static UserRepository userRepository = SpringContextHolder.getBean(UserRepository.class);
	private static MenuRepository menuRepository = SpringContextHolder.getBean(MenuRepository.class);
	
	public static List<Menu> getMenuList(){
		return menuRepository.findAll();
	}
	
	public static UserToken getUserToken(){
		UserToken userToken = new UserToken();
		userToken.setId(1L);
		return userToken;
	}
	

}
