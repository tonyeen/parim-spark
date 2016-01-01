package net.parim.sns.common.persistence;

import java.io.Serializable;

public class BaseEntity<E> implements Serializable {
	private static final long serialVersionUID = -3030974573794962986L;
	
	protected Long id;
	
	public BaseEntity(){
		
	}
	
	public BaseEntity(Long id){
		this.id = id;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}
	
	protected String dbName = "mysql";
	public String getDbName() {
		return dbName;
	}
	public void setDbName(String dbName) {
		this.dbName = dbName;
	}
	private String delFlag="0";
	public String getDelFlag() {
		return delFlag;
	}
	public void setDelFlag(String delFlag) {
		this.delFlag = delFlag;
	}
	private String remarks;
	public String getRemarks() {
		return remarks;
	}
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
}
