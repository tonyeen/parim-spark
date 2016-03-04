package net.parim.system.repository;

import net.parim.common.persistence.CrudRepository;
import net.parim.common.persistence.annotation.MyBatisRepository;
import net.parim.system.entity.User;

@MyBatisRepository
public interface UserRepository extends CrudRepository<User, Long> {

	public User findUserByUsername(String username);
}
