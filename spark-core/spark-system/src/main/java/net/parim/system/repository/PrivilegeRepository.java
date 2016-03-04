package net.parim.system.repository;

import net.parim.common.persistence.CrudRepository;
import net.parim.common.persistence.annotation.MyBatisRepository;
import net.parim.system.entity.Privilege;

@MyBatisRepository
public interface PrivilegeRepository extends CrudRepository<Privilege, Long> {

	public Privilege findPrivilegeByIdentifier(String identifier);
}
