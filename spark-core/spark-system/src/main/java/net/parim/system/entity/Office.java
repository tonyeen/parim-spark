package net.parim.system.entity;

import java.util.List;

import net.parim.common.persistence.BaseEntity;

public class Office extends BaseEntity<Office> {
	private static final long serialVersionUID = 1L;
	private String name;
	private Integer sort;
	private String code;
	private String type;
	private Integer grade;
	private String parentIds;
	private String remarks;
	public String getRemarks() {
		return remarks;
	}
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	private Office parent;
	private List<Office> chidren;
	
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
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public Integer getGrade() {
		return grade;
	}
	public void setGrade(Integer grade) {
		this.grade = grade;
	}
	public String getParentIds() {
		return parentIds;
	}
	public void setParentIds(String parentIds) {
		this.parentIds = parentIds;
	}
	public Office getParent() {
		return parent;
	}
	public void setParent(Office parent) {
		this.parent = parent;
	}
	public List<Office> getChidren() {
		return chidren;
	}
	public void setChidren(List<Office> chidren) {
		this.chidren = chidren;
	}
}
