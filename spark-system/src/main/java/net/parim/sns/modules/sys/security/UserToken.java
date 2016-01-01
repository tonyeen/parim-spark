package net.parim.sns.modules.sys.security;

import net.parim.sns.modules.sys.entity.User;

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
