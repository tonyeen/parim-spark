/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package net.parim.system.security;

import net.parim.system.entity.User;
import net.parim.system.service.AccountService;

import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * 系统安全认证实现类
 * @author ThinkGem
 * @version 2014-7-5
 */
@Service
//@DependsOn({"userDao","roleDao","menuDao"})
public class SystemAuthorizingRealm extends AuthorizingRealm {
	
	private Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired
	private AccountService accountService;

	/**
	 * 授权查询回调函数, 进行鉴权但缓存中无用户的授权信息时调用
	 */
	@Override
	protected AuthenticationInfo doGetAuthenticationInfo(
			AuthenticationToken paramAuthenticationToken)
			throws AuthenticationException {
		UsernamePasswordToken authcToken = (UsernamePasswordToken)paramAuthenticationToken;
		
		if(logger.isDebugEnabled()){
			logger.debug("Login submit, active session size: {}, username: {}", 0, authcToken.getUsername());
		}
		
		// 校验用户名密码
		User user = accountService.findUserByUsername(authcToken.getUsername());
		if (user != null) {
			return new SimpleAuthenticationInfo(user, user.getPassword(), getName());
		} else {
			return null;
		}
	}

	/**
	 * 认证回调函数, 登录时调用
	 */
	@Override
	protected AuthorizationInfo doGetAuthorizationInfo(
			PrincipalCollection paramPrincipalCollection) {
		User user = (User) getAvailablePrincipal(paramPrincipalCollection);
		
		//User user = accountService.findUserByUsername(username);
		if(user != null){
			SimpleAuthorizationInfo authInfo = new SimpleAuthorizationInfo();
			authInfo.addStringPermission("user");
			authInfo.addRole("supperAdmin");
			return authInfo;
		}
		
		return null;
	}
}
