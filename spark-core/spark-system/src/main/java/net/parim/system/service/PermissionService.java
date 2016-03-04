package net.parim.system.service;

import java.util.ArrayList;
import java.util.List;

import net.parim.system.entity.PermissionTarget;
import net.parim.system.entity.Privilege;
import net.parim.system.entity.Role;
import net.parim.system.entity.User;
import net.parim.system.entity.UserRole;
import net.parim.system.entity.Privilege.Type;
import net.parim.system.repository.PermissionTargetRepository;
import net.parim.system.repository.PrivilegeRepository;
import net.parim.system.repository.RoleRepository;
import net.parim.system.repository.UserRoleRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

@Service
public class PermissionService {
	@Autowired
	PrivilegeRepository privilegeRepository;
	@Autowired
	RoleRepository roleRepository;
	@Autowired
	PermissionTargetRepository permissionTargetRepository;
	@Autowired
	UserRoleRepository userRoleRepository;
	
	public UserRole findUserRole(Long id){
		return null;
	}
	
	public List<UserRole> findUserRolesByUser(User user){
		return userRoleRepository.findAllByUser(user);
	}
	
	public Page<UserRole> findUserRolesByUser(User user, Pageable pageable){
		return null;
	}
	
	public List<UserRole> findUserPrivileges(User user){
		return null;
	}
	
	public List<UserRole> findUserPrivilegeXref(User user){
		List<UserRole> privs = new ArrayList<UserRole>();
		List<UserRole> userRoles = findUserRolesByUser(user);
		if(null==userRoles || userRoles.isEmpty()){
			return null;
		}
		for(UserRole userRole:userRoles){
			if(userRole.getRole()!=null 
					&& !userRole.getRole().isNewRecord()){
				Role role = roleRepository.findOne(userRole.getRole());
				List<Privilege> rolePrivileges = role.getPrivileges();
				if(null!=rolePrivileges && !rolePrivileges.isEmpty()){
					for(Privilege privilege: rolePrivileges){
						UserRole priv = new UserRole();
						priv.setUser(user);
						priv.setPrivilege(privilege);
						priv.setTarget(userRole.getTarget());
						priv.setTargetId(userRole.getTargetId());
						privs.add(priv);
					}
				}
			}
			if(userRole.getPrivilege()!=null){
				Privilege privilege = privilegeRepository.findOne(userRole.getPrivilege());
				userRole.setPrivilege(privilege);
				privs.add(userRole);
			}
		}
		expandPermissionTarget(privs);
		return privs;
	}
	
	private void expandPermissionTarget(List<UserRole> privs){
		if(null==privs || privs.isEmpty()){
			return;
		}
		
		List<UserRole> allExtends = new ArrayList<UserRole>();
		for(UserRole parent : privs){
			if(parent.getPrivilege().getType() == Type.resource){
				List<UserRole> oneExtends = new ArrayList<UserRole>();
				List<PermissionTarget> children = permissionTargetRepository.findAllChildren(parent.getTargetId());
				if(null!=children && !children.isEmpty()){
					for(PermissionTarget child: children){
						UserRole priv = new UserRole();
						priv.setUser(parent.getUser());
						priv.setPrivilege(parent.getPrivilege());
						priv.setTarget(child.getObjectType().toString());
						priv.setTargetId(child.getId());
						oneExtends.add(priv);
					}
				}
				allExtends.addAll(oneExtends);
			}
		}
		privs.addAll(allExtends);
	}
}
