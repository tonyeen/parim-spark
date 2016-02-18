package net.parim.system.entity;

import java.util.List;

public class UserGroup extends DataTreeEntity<UserGroup>{
	private String name;
	private Boolean isRoot;
	private Long customThemeId;
	private Long mobileThemeId;
	
	private Site site;
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Boolean getIsRoot() {
		return isRoot;
	}
	public void setIsRoot(Boolean isRoot) {
		this.isRoot = isRoot;
	}
	public Long getCustomThemeId() {
		return customThemeId;
	}
	public void setCustomThemeId(Long customThemeId) {
		this.customThemeId = customThemeId;
	}
	public Long getMobileThemeId() {
		return mobileThemeId;
	}
	public void setMobileThemeId(Long mobileThemeId) {
		this.mobileThemeId = mobileThemeId;
	}
	public Site getSite() {
		return site;
	}
	public void setSite(Site site) {
		this.site = site;
	}
	@Override
	public UserGroup getParent() {
		return parent;
	}
	@Override
	public void setParent(UserGroup parent) {
		this.parent = parent;
	}
	@Override
	public List<UserGroup> getChildren() {
		return children;
	}
	@Override
	public void setChildren(List<UserGroup> children) {
		this.children = children;
	}
}
