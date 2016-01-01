package net.parim.system.service;

import java.util.List;

import net.parim.system.entity.User;
import net.parim.system.repository.UserRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

@Service
public class UserService {
	
	@Autowired
	UserRepository userRepository;
	
	public void save(User user){
		User cuUser = new User();
		cuUser.setId(1L);
		if(user.getId()!=null){
			user.setLastUpdatedBy(cuUser);
			userRepository.update(user);
		}else{
			user.setCreatedBy(cuUser);
			user.setLastUpdatedBy(cuUser);
			userRepository.insert(user);
		}
	}
	
	public User findOne(Long id){
		return userRepository.findOne(id);
	}
	
	public List<User> findAll(User user){
		
		return userRepository.findAll(user);
	}
	
	public Page<User> findAll(User user, Pageable pageable){
		
		return (Page<User>)userRepository.findAll(user, pageable);
	}
}
