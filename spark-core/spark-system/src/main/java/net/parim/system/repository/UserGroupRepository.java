package net.parim.system.repository;

import net.parim.common.persistence.annotation.MyBatisRepository;
import net.parim.system.entity.UserGroup;
import net.parim.system.persistent.TreeRepository;

@MyBatisRepository
public interface UserGroupRepository extends TreeRepository<UserGroup, Long> {

}
