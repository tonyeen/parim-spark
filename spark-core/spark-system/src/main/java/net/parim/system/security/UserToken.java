package net.parim.system.security;

import net.parim.system.entity.User;

public class UserToken extends User {
	User user ;

	public UserToken(){}
	
	public UserToken(User user){
		this.user = user;
	}
	
	public boolean isAdmin(){
		return false;
	}
	
	//@Override
	public String getName(){
		return user.getFirstName();
	}
}
