package net.parim.sns.modules.prefecture.entity;

import java.util.Date;

import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotBlank;

import net.parim.common.persistence.BaseEntity;

public class Prefecture extends BaseEntity<Prefecture> {
	@NotBlank(message="{prefecture.name.not.blank}")
	private String name;
	@Length(min=10, max= 1000, message="{prefecture.intro.length.between}")
	private String intro;
	private Category category;
	private String thumbnails;
	private Date startDate;
	private Date endDate;
	private String staticUrl;
	private Boolean isPublish;
	private Boolean isChoice;
	private State state;
	
	
	
	public String getName() {
		return name;
	}



	public void setName(String name) {
		this.name = name;
	}



	public String getIntro() {
		return intro;
	}



	public void setIntro(String intro) {
		this.intro = intro;
	}



	public Category getCategory() {
		return category;
	}



	public void setCategory(Category category) {
		this.category = category;
	}



	public String getThumbnails() {
		return thumbnails;
	}



	public void setThumbnails(String thumbnails) {
		this.thumbnails = thumbnails;
	}



	public Date getStartDate() {
		return startDate;
	}



	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}



	public Date getEndDate() {
		return endDate;
	}



	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}



	public String getStaticUrl() {
		return staticUrl;
	}



	public void setStaticUrl(String staticUrl) {
		this.staticUrl = staticUrl;
	}



	public Boolean getIsPublish() {
		return isPublish;
	}



	public void setIsPublish(Boolean isPublish) {
		this.isPublish = isPublish;
	}



	public Boolean getIsChoice() {
		return isChoice;
	}



	public void setIsChoice(Boolean isChoice) {
		this.isChoice = isChoice;
	}



	public State getState() {
		return state;
	}



	public void setState(State state) {
		this.state = state;
	}



	public enum State{
		IN_APPROVE, //审批中
		DIS_APPROVED, //审批被拒绝
		EN_APPROVED	//审批通过
	}
}
