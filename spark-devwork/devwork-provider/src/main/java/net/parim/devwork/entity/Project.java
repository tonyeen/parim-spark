package net.parim.devwork.entity;

import net.parim.system.entity.DataEntity;

public class Project extends DataEntity<Project> {

	private static final long serialVersionUID = 1L;
	
	private String name;
	private String repoUrl;
	private String category;
	private String siteUrl;
	private Boolean isAggregator;
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getRepoUrl() {
		return repoUrl;
	}
	public void setRepoUrl(String repoUrl) {
		this.repoUrl = repoUrl;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getSiteUrl() {
		return siteUrl;
	}
	public void setSiteUrl(String siteUrl) {
		this.siteUrl = siteUrl;
	}
	public Boolean getIsAggregator() {
		return isAggregator;
	}
	public void setIsAggregator(Boolean isAggregator) {
		this.isAggregator = isAggregator;
	}
}
