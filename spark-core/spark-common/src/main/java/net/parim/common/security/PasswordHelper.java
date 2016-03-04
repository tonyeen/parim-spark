package net.parim.common.security;

import javax.xml.bind.DatatypeConverter;


import net.parim.common.utils.Encodes;

public class PasswordHelper {
	public static final String HASH_ALGORITHM = "MD5";
	public static final int HASH_INTERATIONS = 1;
	public static final int SALT_SIZE = 22;
	
	public static String generateSalt(){
		byte[] salt = Digests.generateSalt(SALT_SIZE);
		return Encodes.encodeHex(salt);
	}
	
	/**
	 * 通过随机生成的22位salt并经过1次 md5 hash生成安全的密码，
	 */
	public static String entryptPassword(String plainPassword,String salt) {
		byte[] hashPassword = Digests.md5(String.valueOf(plainPassword).concat(
				String.valueOf(salt)).getBytes());
		return DatatypeConverter.printBase64Binary(hashPassword);
	}
	
	/**
	 * 验证密码
	 * @param plainPassword 明文密码
	 * @param salt 盐
	 * @param password 密文密码
	 * @return 验证成功返回true
	 */
	public static boolean validatePassword(String plainPassword, String salt, String password) {
		return password.equals(entryptPassword(plainPassword,salt));
	}
	
	public static void main(String[] args){
		
		String pwd = "admin";
		String salt = "8o6b0dbbQJDkp9mWDjqeeO";
		System.out.println(entryptPassword(pwd,salt));
		System.out.println(validatePassword(pwd, salt, "dy6r5MtDqRBboP8VI7RWCA=="));
	}
}
