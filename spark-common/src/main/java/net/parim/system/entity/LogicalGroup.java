package net.parim.system.entity;

import net.parim.common.persistence.DataEntity;

public class LogicalGroup extends DataEntity<LogicalGroup> {
	
	private Condition condition;
	private Site site;
	private String name;
	private Boolean isPublic;
	
	public Condition getCondition() {
		return condition;
	}
	public void setCondition(Condition condition) {
		this.condition = condition;
	}
	public Site getSite() {
		return site;
	}
	public void setSite(Site site) {
		this.site = site;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Boolean getIsPublic() {
		return isPublic;
	}
	public void setIsPublic(Boolean isPublic) {
		this.isPublic = isPublic;
	}
}
