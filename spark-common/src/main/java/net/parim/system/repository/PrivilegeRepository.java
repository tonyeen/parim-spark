package net.parim.system.repository;

import net.parim.common.persistence.CurdRepository;
import net.parim.common.persistence.annotation.MyBatisRepository;
import net.parim.system.entity.Privilege;

@MyBatisRepository
public interface PrivilegeRepository extends CurdRepository<Privilege> {

	public Privilege findPrivilegeByIdentifier(String identifier);
}
