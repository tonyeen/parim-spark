package net.parim.system.repository;

import net.parim.common.persistence.CurdRepository;
import net.parim.common.persistence.annotation.MyBatisReponsitory;
import net.parim.system.entity.User;

@MyBatisReponsitory
public interface UserRepository extends CurdRepository<User> {

	public User findUserByUsername(String username);
}
