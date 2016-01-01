package net.parim.sns.modules.sys.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import net.parim.sns.modules.sys.entity.PermissionTarget;
import net.parim.sns.modules.sys.entity.User;
import net.parim.sns.modules.sys.repository.PermissionTargetRepository;

@Service
public class UserGroupTreeService {
	@Autowired
	PermissionTargetRepository permissionTargetRepository;

	public List<PermissionTarget> getPermissionRoots(){
		User user = new User();
		user.setId(1L);
		
		List<PermissionTarget.ObjectType> objectTypes = new ArrayList<PermissionTarget.ObjectType>();
		objectTypes.add(PermissionTarget.ObjectType.S);
		objectTypes.add(PermissionTarget.ObjectType.O);
		
		return permissionTargetRepository.findRoots(user, objectTypes);
	}
	
	public List<PermissionTarget> getChildren(PermissionTarget permissionTarget){
		
		List<PermissionTarget.ObjectType> objectTypes = new ArrayList<PermissionTarget.ObjectType>();
		objectTypes.add(PermissionTarget.ObjectType.S);
		objectTypes.add(PermissionTarget.ObjectType.O);
		
		return permissionTargetRepository.findChildren(permissionTarget, objectTypes);
	}
}
