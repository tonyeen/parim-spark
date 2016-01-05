package net.parim.system.repository;

import net.parim.common.persistence.TreeRepository;
import net.parim.common.persistence.annotation.MyBatisRepository;
import net.parim.system.entity.UserGroup;

@MyBatisRepository
public interface UserGroupRepository extends TreeRepository<UserGroup> {

}
