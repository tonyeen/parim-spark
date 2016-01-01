package net.parim.sns.modules.prefecture.entity;

import java.util.List;

import net.parim.sns.common.persistence.BaseEntity;

public class Category extends BaseEntity<Category> {
	private String name;
	private Category parent;
	private List<Category> children;
	private Boolean isDefault;
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Category getParent() {
		return parent;
	}
	public void setParent(Category parent) {
		this.parent = parent;
	}
	public List<Category> getChildren() {
		return children;
	}
	public void setChildren(List<Category> children) {
		this.children = children;
	}
	public Boolean getIsDefault() {
		return isDefault;
	}
	public void setIsDefault(Boolean isDefault) {
		this.isDefault = isDefault;
	}
}
