package net.parim.system.persistent;

import java.util.List;

import javax.validation.constraints.NotNull;

import net.parim.common.utils.Reflections;

import com.fasterxml.jackson.annotation.JsonBackReference;

public abstract class TreeEntity<E extends TreeEntity<?>> 
		extends DataEntity<E> {
	
	private static final long serialVersionUID = 1L;
	
	protected E parent;
	protected List<E> children;
	protected String name;
	protected Integer sort;
	protected Long childCount;
	
	public TreeEntity() {
		super();
	}
	
	public TreeEntity(Long id) {
		super(id);
	}
	
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
	
	public Long getParentId(){
		Long id = null;
		if (parent != null){
			id = (Long)Reflections.getFieldValue(parent, "id");
		}
		return (id==null) ? 0L : id;
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
