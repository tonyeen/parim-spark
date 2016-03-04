package net.parim.system.repository;

import net.parim.common.persistence.TreeRepository;
import net.parim.common.persistence.annotation.MyBatisRepository;
import net.parim.system.entity.Menu;

@MyBatisRepository
public interface MenuRepository extends TreeRepository<Menu, Long> {
	
	public Menu findByIdentifier(String identifier);
}
