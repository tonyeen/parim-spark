package net.parim.system.service;

import java.util.ArrayList;
import java.util.List;

import net.parim.system.entity.PermissionTarget;
import net.parim.system.entity.Site;
import net.parim.system.entity.User;
import net.parim.system.entity.UserGroup;
import net.parim.system.entity.PermissionTarget.ObjectType;
import net.parim.system.repository.PermissionTargetRepository;
import net.parim.system.repository.UserGroupRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserGroupService {
	
	@Autowired
	UserGroupRepository userGroupRepository;
	@Autowired
	PermissionTargetRepository permissionTargetRepository;
	
	public UserGroup findOne(String id){
		return userGroupRepository.findOne(id);
	}
	
	public void save(UserGroup userGroup){
		User user = new User();
		user.setId(1L);
		userGroup.setIsRoot(userGroup.getParent()==null || userGroup.getParent().getId()==null);
		userGroup.setSite(userGroup.getIsRoot()? userGroup.getSite(): findOne(userGroup.getParent().getId()).getSite());
		if(userGroup.getIsNewRecord()){
			userGroup.setCreatedBy(user);
			userGroup.setLastUpdatedBy(user);
			userGroupRepository.insert(userGroup);
		}else{
			userGroup.setLastUpdatedBy(user);
			userGroupRepository.update(userGroup);
		}
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
	
	public void remove(String id){
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
