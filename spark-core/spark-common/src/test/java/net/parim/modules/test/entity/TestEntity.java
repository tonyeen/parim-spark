package net.parim.modules.test.entity;

import net.parim.common.persistence.BaseEntity;

public class TestEntity extends BaseEntity<Object> {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String username;
	
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
}
