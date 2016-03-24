package net.parim.system.service;

import java.io.Serializable;

import net.parim.common.persistence.CrudRepository;
import net.parim.common.service.CrudService;
import net.parim.system.entity.User;
import net.parim.system.persistent.DataEntity;
import net.parim.system.utils.UserUtils;

public abstract class DataCrudService<R extends CrudRepository<T, ID>, T extends DataEntity<?>, ID extends Serializable>
		extends CrudService<R, T, ID> {
	protected User currentUser;
	
	public void save(T entity){
		if(entity.isNewRecord()){
			add(entity);
		}else {
			update(entity);
		}
	}
	
	public void add(T entity){
		entity.setCreatedBy(getCurrentUser());
		repository.insert(entity);
	}
	
	public void update(T entity){
		entity.setLastUpdatedBy(getCurrentUser());
		repository.update(entity);
	}
	
	protected User getCurrentUser(){
		if(currentUser == null){
			currentUser = UserUtils.getCurrentUser();
		}
		return currentUser;
	}
}