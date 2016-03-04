package net.parim.common.persistence;

import java.io.Serializable;

public abstract class BaseEntity<E extends BaseEntity<?>> 
		implements Serializable {
	
	private static final long serialVersionUID = 1L;
	
	protected Long id;
	
	public BaseEntity(){
		
	}
	
	public BaseEntity(Long id){
		this.id = id;
	}
	
	public Long getId(){
		return id;
	}
	
	public void setId(Long id){
		this.id = id;
	}

	public boolean isNewRecord(){
		return null==id || id.longValue()<=0;
	}
}
