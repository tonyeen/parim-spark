package net.parim.sns.modules.sys.repository;

import net.parim.sns.common.persistence.CurdRepository;
import net.parim.sns.common.persistence.annotation.MyBatisReponsitory;
import net.parim.sns.modules.sys.entity.Role;

@MyBatisReponsitory
public interface RoleRepository extends CurdRepository<Role> {
	
}
