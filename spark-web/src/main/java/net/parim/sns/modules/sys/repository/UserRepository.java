package net.parim.sns.modules.sys.repository;

import net.parim.sns.common.persistence.CurdRepository;
import net.parim.sns.common.persistence.annotation.MyBatisReponsitory;
import net.parim.sns.modules.sys.entity.User;

@MyBatisReponsitory
public interface UserRepository extends CurdRepository<User> {

	public User findUserByUsername(String username);
}
