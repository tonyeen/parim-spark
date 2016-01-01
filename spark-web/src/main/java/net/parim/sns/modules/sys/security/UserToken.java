package net.parim.sns.modules.sys.security;

import net.parim.sns.modules.sys.entity.User;

import org.apache.shiro.authc.UsernamePasswordToken;
import org.hamcrest.core.Is;

public class UserToken extends User {
	User user ;

	public UserToken(){}
	
	public UserToken(User user){
		this.user = user;
	}
	
	public boolean isAdmin(){
		return false;
	}
	
	public String getName(){
		return user.getFirstName();
	}
}
