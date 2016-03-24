package net.parim.system.entity;

import java.util.List;

import net.parim.system.persistent.DataEntity;

public class Role extends DataEntity<Role> {

	private static final long serialVersionUID = 1L;
	private String name;
	private Site site;
	private String targets;
	private Boolean isSupperuser;
	
	private List<Privilege> privileges;
	
	public List<Privilege> getPrivileges() {
		return privileges;
	}
	public void setPrivileges(List<Privilege> privileges) {
		this.privileges = privileges;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Site getSite() {
		return site;
	}
	public void setSite(Site site) {
		this.site = site;
	}
	public String getTargets() {
		return targets;
	}
	public void setTargets(String targets) {
		this.targets = targets;
	}
	public Boolean getIsSupperuser() {
		return isSupperuser;
	}
	public void setIsSupperuser(Boolean isSuperuser) {
		this.isSupperuser = isSuperuser;
	}
}
