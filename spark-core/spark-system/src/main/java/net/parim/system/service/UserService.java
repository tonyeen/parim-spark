package net.parim.system.service;

import java.util.List;

import net.parim.common.security.PasswordHelper;
import net.parim.common.utils.StringUtils;
import net.parim.system.entity.User;
import net.parim.system.repository.UserRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

@Service
public class UserService extends DataCrudService<UserRepository, User, Long> {
	
	@Autowired
	UserRepository userRepository;
	
	public void save(User user){
		User cuUser = new User();
		cuUser.setId(1L);
		if(user.isNewRecord()){
			String salt = PasswordHelper.generateSalt();
	        String plainPassword = user.getPassword();
	        if (StringUtils.isBlank(plainPassword)) {
	            plainPassword = "888888";
	            //TODO 增加根据模板邮件通知功能
	        }
	        user.setSalt(salt);
	        user.setPassword(PasswordHelper.entryptPassword(plainPassword, salt));
			
			user.setCreatedBy(cuUser);
			user.setLastUpdatedBy(cuUser);
			userRepository.insert(user);
		}else{
			String salt = PasswordHelper.generateSalt();
	        String plainPassword = user.getPassword();
	        if (!StringUtils.isBlank(plainPassword)) {
	        	user.setSalt(salt);
		        user.setPassword(PasswordHelper.entryptPassword(plainPassword, salt));
	            //TODO 增加根据模板邮件通知功能
	        }
			
			user.setLastUpdatedBy(cuUser);
			userRepository.update(user);
		}
	}
	
	public User findOne(Long id){
		return userRepository.findOne(id);
	}
	
	public List<User> findAll(User user){
		
		return userRepository.findAll(user);
	}
	
	@SuppressWarnings("unchecked")
	public Page<User> findAll(User user, Pageable pageable){
		return (Page<User>)userRepository.findAll(user, pageable);
	}
}
