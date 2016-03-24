package net.parim.system.utils;

import java.util.List;

import org.apache.shiro.SecurityUtils;
import org.springframework.cache.annotation.Cacheable;

import net.parim.common.utils.Constants;
import net.parim.common.utils.SpringContextHolder;
import net.parim.system.entity.Menu;
import net.parim.system.entity.User;
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
	
	@Cacheable(value="default", keyGenerator="wiselyKeyGenerator")
	public static User getUser(Long key){
		return userRepository.findOne(key);
	}
	
	public static User getCurrentUser(){
		 return (User) SecurityUtils.getSubject().getSession().getAttribute(Constants.CURRENT_USER);
	}
	

}
