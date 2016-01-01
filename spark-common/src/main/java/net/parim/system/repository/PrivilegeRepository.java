package net.parim.system.repository;

import net.parim.common.persistence.CurdRepository;
import net.parim.common.persistence.annotation.MyBatisReponsitory;
import net.parim.system.entity.Privilege;

@MyBatisReponsitory
public interface PrivilegeRepository extends CurdRepository<Privilege> {

	public Privilege findPrivilegeByIdentifier(String identifier);
}
