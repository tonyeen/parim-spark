package net.parim.system.entity;

import net.parim.system.persistent.DataEntity;

public class CustomTheme extends DataEntity<CustomTheme> {
	private static final long serialVersionUID = 1L;
	
	private String name;
	private String description;
	private Site site;
	
	public void setName(String name) {
		this.name = name;
	}
	public String getName() {
		return name;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getDescription() {
		return description;
	}
	public void setSite(Site site) {
		this.site = site;
	}
	public Site getSite() {
		return site;
	}
}
