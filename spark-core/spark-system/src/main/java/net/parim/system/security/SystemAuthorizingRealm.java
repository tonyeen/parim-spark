/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package net.parim.system.security;

import java.util.List;

import net.parim.system.entity.Privilege.Type;
import net.parim.system.entity.User;
import net.parim.system.entity.UserRole;
import net.parim.system.service.AccountService;
import net.parim.system.service.PermissionService;

import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.Permission;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.authz.permission.WildcardPermission;
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
	
	@Autowired
	private PermissionService permissionService;

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
			return new SimpleAuthenticationInfo(user, user.getPassword(), getClass().getName());
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
			return authzPermissions(user);
		}
		
		return null;
	}
	
	/**
	 * 给当前的认证对象授权,
	 * TODO：现在能想到两种实现方案
	 * 1.将权限树遍历成string，以stringPermission的形式添加到AuthorizationInfo，占用内存可能太大
	 * 2.用自定Permission的实现，必要时可以扩展SimpleAuthorizationInfo，实现特殊逻辑（动态，数据库或缓存库）的权限验证
	 * 现在第二种方案需要严谨的设计，现在采用第一种方式实现
	 */
	protected AuthorizationInfo authzPermissions(User user){
		SimpleAuthorizationInfo authInfo = new SimpleAuthorizationInfo();
		List<UserRole> userPrivs = permissionService.findUserPrivilegeXref(user);
		if(null!=userPrivs && !userPrivs.isEmpty()){
			for (UserRole userRole : userPrivs) {
				String permission = userRole.getPrivilege().getIdentifier();
				if(userRole.getPrivilege().getType() == Type.resource){
					permission = permission + ":"+userRole.getTargetId();
				}
				authInfo.addStringPermission(permission);
				logger.debug("User "+ user.getId() + user.getUsername() + " is permissed: " + permission);
			}
		}
		logger.debug(authInfo.getStringPermissions().size()+"");
		return authInfo;
	}
	
	
}
