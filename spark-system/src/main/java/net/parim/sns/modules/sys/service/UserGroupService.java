package net.parim.sns.modules.sys.service;

import java.util.ArrayList;
import java.util.List;

import net.parim.sns.modules.sys.entity.PermissionTarget;
import net.parim.sns.modules.sys.entity.PermissionTarget.ObjectType;
import net.parim.sns.modules.sys.entity.Site;
import net.parim.sns.modules.sys.entity.User;
import net.parim.sns.modules.sys.entity.UserGroup;
import net.parim.sns.modules.sys.repository.PermissionTargetRepository;
import net.parim.sns.modules.sys.repository.UserGroupRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserGroupService {
	
	@Autowired
	UserGroupRepository userGroupRepository;
	@Autowired
	PermissionTargetRepository permissionTargetRepository;
	
	public UserGroup findOne(Long id){
		return userGroupRepository.findOne(id);
	}
	
	public void save(UserGroup userGroup){
		User user = new User();
		user.setId(1L);
		userGroup.setIsRoot(userGroup.getParent()==null || userGroup.getParent().getId()==null);
		userGroup.setSite(userGroup.getIsRoot()? userGroup.getSite(): findOne(userGroup.getParent().getId()).getSite());
		if(userGroup.getId()==null || userGroup.getId() == 0){
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
