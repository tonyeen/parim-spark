package net.parim.system.service;

import java.util.List;

import net.parim.system.entity.Site;
import net.parim.system.entity.UserGroup;
import net.parim.system.repository.PermissionTargetRepository;
import net.parim.system.repository.UserGroupRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserGroupService extends DataCrudService<UserGroupRepository, UserGroup, Long> {
	
	//
	
	@Autowired
	UserGroupRepository userGroupRepository;
	@Autowired
	PermissionTargetRepository permissionTargetRepository;
	
	public UserGroup findOne(Long id){
		return userGroupRepository.findOne(id);
	}
	
	public void save(UserGroup userGroup){
		
		if(userGroup.getParent() != null && !userGroup.getParent().isNewRecord()){
			userGroup.setSite(findOne(userGroup.getParent().getId()).getSite());
		}
		super.save(userGroup);
	}
	
	public List<UserGroup> findAll(){
		
		return userGroupRepository.findAll();
	}
	
	public List<UserGroup> findAll(UserGroup userGroup){
	
		return userGroupRepository.findAll(userGroup);
	}
	
	public List<UserGroup> findBySite(Site site){
		return null;
	}
	
	public List<UserGroup> findChildren(){
		return null;
	}
	
	public void remove(Long id){
		userGroupRepository.delete(id);
	}
	
	public void remove(UserGroup userGroup){
		userGroupRepository.delete(userGroup);
	}
	
	public void remove(List<UserGroup> userGroups){
		if(userGroups==null){
			return;
		}
		for(UserGroup ug : userGroups){
			remove(ug);
		}
	}

}
