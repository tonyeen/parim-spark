package net.parim.system.repository;

import net.parim.common.persistence.CurdRepository;
import net.parim.common.persistence.annotation.MyBatisRepository;
import net.parim.system.entity.Role;

@MyBatisRepository
public interface RoleRepository extends CurdRepository<Role> {
	
}
