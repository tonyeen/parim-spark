package net.parim.common.persistence;

import java.util.List;

import javax.validation.constraints.NotNull;

import com.fasterxml.jackson.annotation.JsonBackReference;

import net.parim.common.utils.Reflections;

public abstract class TreeEntity<E> extends DataEntity<E> {
	private static final long serialVersionUID = 8924003950923240082L;
	
	protected E parent;
	protected List<E> children;
	protected String name;
	protected Integer sort;
	protected Long childCount;
	
	/**
	 * 父对象，只能通过子类实现，父类实现mybatis无法读取
	 * @return
	 */
	@JsonBackReference
	@NotNull
	public abstract E getParent();

	/**
	 * 父对象，只能通过子类实现，父类实现mybatis无法读取
	 * @return
	 */
	public abstract void setParent(E parent);
	
	public abstract List<E> getChildren();
	public abstract void setChildren(List<E> children);
	
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
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	
	public Long getParentId(){
		Long id = null;
		if (parent != null){
			id = (Long)Reflections.getFieldValue(parent, "id");
		}
		return null!=id ? id : 0;
	}

	public Long getChildCount() {
		return childCount;
	}

	public void setChildCount(Long childCount) {
		this.childCount = childCount;
	}
	
	public Boolean getIsParent(){
		return getChildCount()!=null && getChildCount()>0;
	}
}
