package net.parim.system.entity;

import java.util.List;

import net.parim.system.persistent.TreeEntity;

public class UserGroup extends TreeEntity<UserGroup>{
	
	private static final long serialVersionUID = 1L;
	//private String name;
	private String shortName;
	private String description;
	private CustomTheme customTheme;
	
	
	private Site site;
	
	
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
	public void setShortName(String shortName) {
		this.shortName = shortName;
	}
	public String getShortName() {
		return shortName;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getDescription() {
		return description;
	}
	public void setCustomTheme(CustomTheme customTheme) {
		this.customTheme = customTheme;
	}
	public CustomTheme getCustomTheme() {
		return customTheme;
	}
}
