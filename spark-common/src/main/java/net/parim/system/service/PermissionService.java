package net.parim.system.service;

import net.parim.system.repository.PrivilegeRepository;
import net.parim.system.repository.RoleRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class PermissionService {
	@Autowired
	PrivilegeRepository privilegeRepository;
	@Autowired
	RoleRepository roleRepository;
	
	
	
}
