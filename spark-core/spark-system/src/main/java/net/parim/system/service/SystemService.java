package net.parim.system.service;

import java.util.ArrayList;
import java.util.List;

import net.parim.common.service.CrudService;
import net.parim.common.web.MenuProvider;
import net.parim.system.entity.Menu;
import net.parim.system.repository.MenuRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class SystemService 
		extends CrudService<MenuRepository, Menu, Long> 
		implements MenuProvider {
	
	@Autowired
	private MenuRepository menuRepository;
	
	public Menu findMenuById(Long id){
		return menuRepository.findOne(id);
	}
	
	public List<Menu> findAllMenu(){
		return menuRepository.findAll();
	}
	
	public void saveMenu(Menu menu){
		menu.setParent(findMenuById(menu.getParent().getId()));
		
		// 保存当前实体
		if(menu.isNewRecord()){
			//menu.setId(IdGen.uuid());
			menuRepository.insert(menu);
		}else{
			menuRepository.update(menu);
		}
		
		// 修改子级节点
		
		// 更新缓存
	}
	
	public void removeMenu(Menu menu){
		@SuppressWarnings("unchecked")
		List<Menu> children = (List<Menu>) menuRepository.findAllChildren(menu);
		for(Menu m: children) {
			menuRepository.delete(m);
		}
		menuRepository.delete(menu);
		
		//TODO: 更新缓存
	}

	@Override
	public List<?> getMenuList() {
		//return findAllMenu();
		Menu menu = new Menu();
		menu.setId(1L);
		menu.setName("管理控制台");
		
		Menu dashBoard = new Menu();
		dashBoard.setId(2L);
		dashBoard.setName("我的仪表盘");
		//dashBoard.setParent(menu);
		
		List<Menu> menus = new ArrayList<Menu>();
		menus.add(menu);
		menus.add(dashBoard);
		
		return menus;
	}
	
	@SuppressWarnings("unchecked")
	public List<Menu> findAllParents(Menu menu){
		return (List<Menu>) menuRepository.findAllParents(menu);
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
		dashBoard.setId(100L);
		dashBoard.setName("我的仪表盘");
		
		List<Menu> menus = new ArrayList<Menu>();
		menus.add(dashBoard);
		
		return menus;
	}

}
