package net.parim.system.entity;

import java.util.List;

import net.parim.common.persistence.TreeEntity;

public class PermissionTarget extends TreeEntity<PermissionTarget>{
	
	private static final long serialVersionUID = 1L;
	
	protected ObjectType objectType;

	@Override
	public PermissionTarget getParent() {
		// TODO Auto-generated method stub
		return parent;
	}

	@Override
	public void setParent(PermissionTarget parent) {
		this.parent = parent;
	}

	@Override
	public List<PermissionTarget> getChildren() {
		return children;
	}

	@Override
	public void setChildren(List<PermissionTarget> children) {
		this.children = children;
	}
	
	public enum ObjectType{
		S, O, U;
	}

	public ObjectType getObjectType() {
		return objectType;
	}

	public void setObjectType(ObjectType objectType) {
		this.objectType = objectType;
	}
}
