package net.parim.system.entity;

import java.util.List;

import javax.validation.constraints.DecimalMin;

import net.parim.common.persistence.TreeEntity;

import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotBlank;

public class Menu extends TreeEntity<Menu> {
	private static final long serialVersionUID = 1L;
	//private Menu parent;
	@NotBlank(message="{menu.name.not.be.blank}")
	@Length(min=2, max=6, message="{menu.name.length.between}")
	private String name;
	private String identifier;
	@DecimalMin(value="0", message="{menu.sort.not.be.empty}")
	private Integer sort;
	//@URL(message="")
	private String url;
	private String target;
	private String icon;
	private Boolean isShow = true;
	private String permission;
	
	public Menu getParent() {
		return parent;
	}
	public void setParent(Menu parent) {
		this.parent = parent;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Integer getSort() {
		return sort;
	}
	public void setSort(Integer sort) {
		this.sort = sort;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getTarget() {
		return target;
	}
	public void setTarget(String target) {
		this.target = target;
	}
	public String getIcon() {
		return icon;
	}
	public void setIcon(String icon) {
		this.icon = icon;
	}
	public Boolean getIsShow() {
		return isShow;
	}
	public void setIsShow(Boolean isShow) {
		this.isShow = isShow;
	}
	public String getPermission() {
		return permission;
	}
	public void setPermission(String permission) {
		this.permission = permission;
	}
	
	@Override
	public List<Menu> getChildren() {
		// TODO Auto-generated method stub
		return null;
	}
	@Override
	public void setChildren(List<Menu> children) {
		// TODO Auto-generated method stub
		
	}
	public String getIdentifier() {
		return identifier;
	}
	public void setIdentifier(String identifier) {
		this.identifier = identifier;
	}
}
