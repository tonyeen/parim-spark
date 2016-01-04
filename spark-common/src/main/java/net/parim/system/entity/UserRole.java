package net.parim.system.entity;

import net.parim.common.persistence.DataEntity;

public class UserRole extends DataEntity<UserRole> {
	private Site site;
	private User user;
	private UserGroup userGroup;
	private LogicalGroup logicalGroup;
	private Role role;
	private Privilege privilege;
	private String target;
	private Long targetId;
	
	public Site getSite() {
		return site;
	}
	public void setSite(Site site) {
		this.site = site;
	}
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	public UserGroup getUserGroup() {
		return userGroup;
	}
	public void setUserGroup(UserGroup userGroup) {
		this.userGroup = userGroup;
	}
	public LogicalGroup getLogicalGroup() {
		return logicalGroup;
	}
	public void setLogicalGroup(LogicalGroup logicalGroup) {
		this.logicalGroup = logicalGroup;
	}
	public Role getRole() {
		return role;
	}
	public void setRole(Role role) {
		this.role = role;
	}
	public Privilege getPrivilege() {
		return privilege;
	}
	public void setPrivilege(Privilege privilege) {
		this.privilege = privilege;
	}
	public String getTarget() {
		return target;
	}
	public void setTarget(String target) {
		this.target = target;
	}
	public Long getTargetId() {
		return targetId;
	}
	public void setTargetId(Long targetId) {
		this.targetId = targetId;
	}
}
