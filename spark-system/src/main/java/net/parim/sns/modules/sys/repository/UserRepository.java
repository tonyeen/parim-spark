package net.parim.sns.modules.sys.repository;

import net.parim.common.persistence.CurdRepository;
import net.parim.common.persistence.annotation.MyBatisReponsitory;
import net.parim.sns.modules.sys.entity.User;

@MyBatisReponsitory
public interface UserRepository extends CurdRepository<User> {

	public User findUserByUsername(String username);
}
