package net.parim.sns.modules.sys.service;

import net.parim.sns.modules.sys.repository.PrivilegeRepository;
import net.parim.sns.modules.sys.repository.RoleRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class PermissionService {
	@Autowired
	PrivilegeRepository privilegeRepository;
	@Autowired
	RoleRepository roleRepository;
	
	
	
}
