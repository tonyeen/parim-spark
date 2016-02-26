package net.parim.common.web;

import java.util.List;

public interface MenuProvider {
	
	public List<?> getMenuList();
	
	public List<?> getTopLevelMenus();
	
	public List<?> getMenuListByParentId(String parentId);

}
