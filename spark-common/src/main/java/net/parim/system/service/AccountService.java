package net.parim.system.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import net.parim.system.entity.User;
import net.parim.system.exception.IncorrectCredentialsException;
import net.parim.system.exception.UnknownAccountException;
import net.parim.system.repository.UserRepository;

@Service
public class AccountService {
	
	@Autowired
	private UserRepository userRepository;
	
	public User findUserById(Long id){
		return userRepository.findOne(id);
	}
	
	public User findUserByUsername(String username){
		return userRepository.findUserByUsername(username);
	}
	
	public User checkUser(String username, String password) 
			throws UnknownAccountException, IncorrectCredentialsException{
		User user = checkUserExist(username);
		checkPassword(user.getPassword(), password);
		return user;
	}
	
	public User checkUserExist(String username) 
			throws UnknownAccountException{
		User user = userRepository.findUserByUsername(username);
		if(null==user){
			throw new UnknownAccountException();
		}
		return user;
	}
	
	private void checkPassword(String userPassword, String password) 
			throws IncorrectCredentialsException{
		if(null == userPassword || !userPassword.equals(password)){
			throw new IncorrectCredentialsException();
		}
	}
}
