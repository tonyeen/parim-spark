package net.parim.system.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import net.parim.common.utils.IdGen;
import net.parim.common.web.MenuProvider;
import net.parim.system.entity.Menu;
import net.parim.system.repository.MenuRepository;

@Service
public class SystemService implements MenuProvider {
	
	@Autowired
	private MenuRepository menuRepository;
	
	public Menu findMenuById(String id){
		return menuRepository.findOne(id);
	}
	
	public List<Menu> findAllMenu(){
		return menuRepository.findAll();
	}
	
	public void saveMenu(Menu menu){
		menu.setParent(findMenuById(menu.getParent().getId()));
		menu.setParentIds(menu.getParent().getParentIds()+","+menu.getParent().getId());
		
		// 保存当前实体
		if(menu.getIsNewRecord()){
			menu.setId(IdGen.uuid());
			menuRepository.insert(menu);
		}else{
			menuRepository.update(menu);
		}
		
		// 修改子级节点
		
		// 更新缓存
	}
	
	public void removeMenu(Menu menu){
		menuRepository.delete(menu);
		// 更新缓存
	}

	@Override
	public List<?> getMenuList() {
		//return findAllMenu();
		Menu menu = new Menu();
		menu.setId(1);
		menu.setName("管理控制台");
		
		Menu dashBoard = new Menu();
		dashBoard.setId(2);
		dashBoard.setName("我的仪表盘");
		//dashBoard.setParent(menu);
		
		List<Menu> menus = new ArrayList<Menu>();
		menus.add(menu);
		menus.add(dashBoard);
		
		return menus;
	}

	@Override
	public List<?> getTopLevelMenus() {
		return menuRepository.findAllRoots(null, null);
	}

	@Override
	public List<?> getMenuListByParentId(String parentId) {
		Menu menu = menuRepository.findByIdentifier(parentId);
		return menuRepository.findChildren(menu);
	}
	
	@Override
	public List<?> getUserCustomMenus() {
		Menu dashBoard = new Menu();
		dashBoard.setId(100);
		dashBoard.setName("我的仪表盘");
		
		List<Menu> menus = new ArrayList<Menu>();
		menus.add(dashBoard);
		
		return menus;
	}

}
