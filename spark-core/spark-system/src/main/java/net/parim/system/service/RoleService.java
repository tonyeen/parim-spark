package net.parim.system.service;

import java.util.List;

import net.parim.system.entity.Role;
import net.parim.system.entity.User;
import net.parim.system.repository.RoleRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

@Service
public class RoleService {
	@Autowired
	RoleRepository roleRepository;
	
	User user = new User();
	
	public RoleService(){
		user.setId(1L);
	}
	
	public void createRole(Role role){
		role.setCreatedBy(user);
		role.setLastUpdatedBy(user);
		roleRepository.insert(role);
	}
	
	public void updateRole(Role role){
		role.setLastUpdatedBy(user);
		roleRepository.update(role);
	}
	
	public void saveRole(Role role){
		if(!role.isNewRecord()){
			updateRole(role);
		}else{
			createRole(role);
		}
	}
	
	public void removeRole(Role role){
		roleRepository.delete(role);
	}
	
	public void removeRole(Long id){
		roleRepository.delete(id);
	}
	
	public void removeRole(List<Role> roles){
		for(Role role: roles){
			removeRole(role);
		}
	}
	
	public Role findRoleById(Long id){
		return roleRepository.findOne(id);
	}
	
	public List<Role> findAllRoles(){
		return roleRepository.findAll();
	}
	
	public List<Role> findAllRoles(Role role){
		return roleRepository.findAll(role);
	}
	
	public Page<Role> findAllRoles(Pageable pageable){
		return findAllRoles(null, pageable);
	}
	
	@SuppressWarnings("unchecked")
	public Page<Role> findAllRoles(Role role, Pageable pageable){
		return (Page<Role>)roleRepository.findAll(role, pageable);
	}
}
