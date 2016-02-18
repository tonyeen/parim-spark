package net.parim.modules.test.entity;

import net.parim.common.persistence.BaseEntity;

public class Test extends BaseEntity {
	private String username;
	
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
}
