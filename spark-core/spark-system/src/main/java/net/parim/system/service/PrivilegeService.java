package net.parim.system.service;

import java.util.List;

import net.parim.common.service.CrudService;
import net.parim.system.entity.Privilege;
import net.parim.system.entity.User;
import net.parim.system.repository.PrivilegeRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

@Service
public class PrivilegeService extends CrudService<PrivilegeRepository, Privilege, Long> {
	@Autowired
	PrivilegeRepository privilegeRepository;
	
	User user = new User();
	
	public PrivilegeService(){
		user.setId(1L);
	}
	
	public void createPrivilege(Privilege privilege){
		privilege.setCreatedBy(user);
		privilege.setLastUpdatedBy(user);
		privilegeRepository.insert(privilege);
	}
	
	public void updatePrivilege(Privilege privilege){
		privilege.setLastUpdatedBy(user);
		privilegeRepository.update(privilege);
	}
	
	public void savePrivilege(Privilege privilege){
		if(!privilege.isNewRecord()){
			updatePrivilege(privilege);
		}else{
			createPrivilege(privilege);
		}
	}
	
	public void removePrivilege(Privilege privilege){
		privilegeRepository.delete(privilege);
	}
	
	public void removePrivileg(Long id){
		privilegeRepository.delete(id);
	}
	
	public void removePrivilege(List<Privilege> privileges){
		for(Privilege privilege: privileges){
			removePrivilege(privilege);
		}
	}
	
	public Privilege findPrivilegeById(Long id){
		return privilegeRepository.findOne(id);
	}
	
	public Privilege findPrivilegeByIdentifier(String identifier){
		return privilegeRepository.findPrivilegeByIdentifier(identifier);
	}
	
	public List<Privilege> findAllPrivileges(){
		return privilegeRepository.findAll();
	}
	
	public List<Privilege> findAllPrivileges(Privilege privilege){
		return privilegeRepository.findAll(privilege);
	}
	
	public Page<Privilege> findAllPrivileges(Pageable pageable){
		return findAllPrivileges(null, pageable);
	}
	
	@SuppressWarnings("unchecked")
	public Page<Privilege> findAllPrivileges(Privilege privilege, Pageable pageable){
		return (Page<Privilege>)privilegeRepository.findAll(privilege, pageable);
	}
	
}
