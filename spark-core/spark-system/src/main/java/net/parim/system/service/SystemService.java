package net.parim.system.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
		if(menu.getId() == null){
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
		return findAllMenu();
	}

}
