package net.parim.common.web.utils;

import java.util.List;

import net.parim.common.utils.SpringContextHolder;
import net.parim.common.web.DefaultMenuProvider;
import net.parim.common.web.MenuProvider;

public class MenuFunctions {
	
	private static MenuProvider menuProvider;
	
	static {
		menuProvider = SpringContextHolder.getBean(MenuProvider.class);
		if(null == menuProvider){
			menuProvider = new DefaultMenuProvider();
		}
	}
	
	public static List<?> getMenuList(){
		return menuProvider.getMenuList();
	}
	
	public static List<?> getTopLevelMenus(){
		return menuProvider.getTopLevelMenus();
	}
	
	public static List<?> getMenuListByParentId(String parentId){
		return menuProvider.getMenuListByParentId(parentId);
	}
	
	public static List<?> getUserCustomMenus(){
		return menuProvider.getUserCustomMenus();
	}
}
