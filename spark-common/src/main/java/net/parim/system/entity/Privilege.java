package net.parim.system.entity;

import net.parim.common.persistence.DataEntity;

public class Privilege extends DataEntity<Privilege> {
	private String identifier;
	private String name;
	private String targets;
	private String userType;
	private Type type;
	
	public String getIdentifier() {
		return identifier;
	}
	public void setIdentifier(String identifier) {
		this.identifier = identifier;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getTargets() {
		return targets;
	}
	public void setTargets(String targets) {
		this.targets = targets;
	}
	public String getUserType() {
		return userType;
	}
	public void setUserType(String userType) {
		this.userType = userType;
	}
	
	public enum Type{
		system,
		resource
	}

	public Type getType() {
		return type;
	}
	public void setType(Type type) {
		this.type = type;
	}
}
