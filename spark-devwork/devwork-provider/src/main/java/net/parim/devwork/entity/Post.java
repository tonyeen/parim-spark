package net.parim.devwork.entity;

import java.sql.Date;

import net.parim.system.entity.DataEntity;

public class Post extends DataEntity<Post> {

	private static final long serialVersionUID = 1L;
	
	private String title;
	private String category;
	private Boolean broadcast;
	private Boolean draft;
	private String publicSlug;
	private Date publishDate;
	private String rawContent;
	private String renderedContent;
	private String renderedSummary;
	
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public Boolean getBroadcast() {
		return broadcast;
	}
	public void setBroadcast(Boolean broadcast) {
		this.broadcast = broadcast;
	}
	public Boolean getDraft() {
		return draft;
	}
	public void setDraft(Boolean draft) {
		this.draft = draft;
	}
	public String getPublicSlug() {
		return publicSlug;
	}
	public void setPublicSlug(String publicSlug) {
		this.publicSlug = publicSlug;
	}
	public Date getPublishDate() {
		return publishDate;
	}
	public void setPublishDate(Date publishDate) {
		this.publishDate = publishDate;
	}
	public String getRawContent() {
		return rawContent;
	}
	public void setRawContent(String rawContent) {
		this.rawContent = rawContent;
	}
	public String getRenderedContent() {
		return renderedContent;
	}
	public void setRenderedContent(String renderedContent) {
		this.renderedContent = renderedContent;
	}
	public String getRenderedSummary() {
		return renderedSummary;
	}
	public void setRenderedSummary(String renderedSummary) {
		this.renderedSummary = renderedSummary;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	
}
