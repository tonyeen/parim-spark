package net.parim.system.entity;

import java.util.List;

import net.parim.common.persistence.BaseEntity;

public class TreeXref extends BaseEntity<TreeXref> {
	protected String childId;
	protected String parentId;
	protected Long distance;
	protected Long countPath;
	protected String childObjectType;
	protected String parentObjectType;
	protected Long childCount;
	protected String treeType;
	
	
	/*public T getParent(){
		return null;
	}
	public Long getId(){
		return null;
	}
	public List<T> getChildren(){
		return null;
	}*/
	//public List<?> getParents();
	//public String getTargetType();
	
	public String getChildId() {
		return childId;
	}
	public void setChildId(String childId) {
		this.childId = childId;
	}
	public String getParentId() {
		return parentId;
	}
	public void setParentId(String parentId) {
		this.parentId = parentId;
	}
	public Long getDistance() {
		return distance;
	}
	public void setDistance(Long distance) {
		this.distance = distance;
	}
	public Long getCountPath() {
		return countPath;
	}
	public void setCountPath(Long countPath) {
		this.countPath = countPath;
	}
	public String getChildObjectType() {
		return childObjectType;
	}
	public void setChildObjectType(String childObjectType) {
		this.childObjectType = childObjectType;
	}
	public String getParentObjectType() {
		return parentObjectType;
	}
	public void setParentObjectType(String parentObjectType) {
		this.parentObjectType = parentObjectType;
	}
	public Long getChildCount() {
		return childCount;
	}
	public void setChildCount(Long childCount) {
		this.childCount = childCount;
	}
	public String getTreeType() {
		return treeType;
	}
	public void setTreeType(String treeType) {
		this.treeType = treeType;
	}
}
