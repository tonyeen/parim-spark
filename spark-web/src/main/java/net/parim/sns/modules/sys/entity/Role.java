package net.parim.sns.modules.sys.entity;

import java.util.List;

import net.parim.sns.common.persistence.DataEntity;

public class Role extends DataEntity<Role> {
	private String name;
	private Site site;
	private String targets;
	private Boolean isSuperuser;
	
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
	public Boolean getIsSuperuser() {
		return isSuperuser;
	}
	public void setIsSuperuser(Boolean isSuperuser) {
		this.isSuperuser = isSuperuser;
	}
}
