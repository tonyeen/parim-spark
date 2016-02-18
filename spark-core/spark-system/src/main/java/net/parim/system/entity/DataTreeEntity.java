package net.parim.system.entity;

import java.util.Date;
import java.util.List;

import net.parim.common.persistence.TreeEntity;

public class DataTreeEntity<E> extends TreeEntity<E> {
	private static final long serialVersionUID = 8019120436306066356L;
	
	public static final String DEL_FLAG_NORMAL = "0";
	public static final String DEL_FLAG_DELETE = "1";

	protected User createdBy;
	protected User lastUpdatedBy;
	protected Date createDate;
	protected Date lastUpdateDate;
	protected Boolean isDeleted;
	
	public DataTreeEntity(){
		
	}
	
	public DataTreeEntity(Long id){
		super(id);
	}
	
	public DataTreeEntity(String id){
		super(Long.parseLong(id));
	}
	
	public User getCreatedBy() {
		return createdBy;
	}
	public void setCreatedBy(User createdBy) {
		this.createdBy = createdBy;
	}
	public User getLastUpdatedBy() {
		return lastUpdatedBy;
	}
	public void setLastUpdatedBy(User lastUpdatedBy) {
		this.lastUpdatedBy = lastUpdatedBy;
	}
	public Date getCreateDate() {
		return createDate;
	}
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
	public Date getLastUpdateDate() {
		return lastUpdateDate;
	}
	public void setLastUpdateDate(Date lastUpdateDate) {
		this.lastUpdateDate = lastUpdateDate;
	}
	public Boolean getIsDeleted() {
		return isDeleted;
	}
	public void setIsDeleted(Boolean isDeleted) {
		this.isDeleted = isDeleted;
	}

	@Override
	public E getParent() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void setParent(E parent) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public List<E> getChildren() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void setChildren(List<E> children) {
		// TODO Auto-generated method stub
		
	}
}
