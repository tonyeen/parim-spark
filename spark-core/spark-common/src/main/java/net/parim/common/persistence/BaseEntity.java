package net.parim.common.persistence;

import java.io.Serializable;

import com.alibaba.druid.sql.dialect.sqlserver.ast.SQLServerColumnDefinition.Identity;

public class BaseEntity<E> implements Serializable {
	private static final long serialVersionUID = -3030974573794962986L;
	
	protected String id;
	
	public BaseEntity(){
		
	}
	
	public BaseEntity(String id){
		this.id = id;
	}
	
	public BaseEntity(Long id){
		this.id = id!=null?id.toString():null;
	}
	
	public BaseEntity(Integer id){
		this.id = id!=null?id.toString():null;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}
	
	public void setId(Long id){
		this.id = id!=null?id.toString():null;
	}
	
	public void setId(Integer id){
		this.id = id!=null?id.toString():null;
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
	
	public boolean getIsNewRecord(){
		return null==id || id.isEmpty();
	}
}
