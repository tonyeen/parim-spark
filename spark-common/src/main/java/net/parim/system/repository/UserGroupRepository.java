package net.parim.system.repository;

import net.parim.common.persistence.TreeRepository;
import net.parim.common.persistence.annotation.MyBatisReponsitory;
import net.parim.system.entity.UserGroup;

@MyBatisReponsitory
public interface UserGroupRepository extends TreeRepository<UserGroup> {

}
