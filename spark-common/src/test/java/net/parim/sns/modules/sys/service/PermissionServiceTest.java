package net.parim.sns.modules.sys.service;

import java.util.List;

import net.parim.sns.common.test.SpringTransactionalContextTests;
import net.parim.system.entity.User;
import net.parim.system.entity.UserRole;
import net.parim.system.service.PermissionService;

import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

public class PermissionServiceTest extends SpringTransactionalContextTests {
	Logger logger = LoggerFactory.getLogger(getClass());

	@Autowired
	PermissionService permissionService;
	
	@Test
	public void testFindUserPrivilegeXref(){
		User user = new User();
		user.setId(1L);
		List<UserRole> userPrivs = permissionService.findUserPrivilegeXref(user);
		//System.out.println("userPrivs>>>>>>>>>>>>>>>"+userPrivs);
	}
}
