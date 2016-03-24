package net.parim.system.persistent;

import java.util.Date;

import net.parim.common.persistence.BaseEntity;
import net.parim.system.entity.User;

public class DataEntity<E extends BaseEntity<?>> 
		extends BaseEntity<E> {
	
	private static final long serialVersionUID = 1L;
	
	public static final String DEL_FLAG_NORMAL = "0";
	public static final String DEL_FLAG_DELETE = "1";

	protected User createdBy;
	protected User lastUpdatedBy;
	protected Date createDate;
	protected Date lastUpdateDate;
	protected Boolean isDeleted;
	
	public DataEntity(){
		
	}
	
	public DataEntity(Long id){
		super(id);
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
}
