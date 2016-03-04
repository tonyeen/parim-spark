package net.parim.system.security;

import net.parim.common.security.PasswordHelper;

import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authc.credential.SimpleCredentialsMatcher;

public class CustomCredentialsMatcher extends SimpleCredentialsMatcher {

	@Override
	public boolean doCredentialsMatch(AuthenticationToken authcToken,
			AuthenticationInfo info) {
		boolean isMatch;
		String salt = null;
		if ((info instanceof SimpleAuthenticationInfo)) {
			salt =new String(((SimpleAuthenticationInfo) info).getCredentialsSalt().getBytes());

		}
		Object tokenCredentials = PasswordHelper.entryptPassword(String.valueOf(((UsernamePasswordToken)authcToken)
				.getPassword()), salt);
		Object accountCredentials = getCredentials(info);
		
		isMatch = equals(tokenCredentials, accountCredentials);
		return isMatch;
	}
}
