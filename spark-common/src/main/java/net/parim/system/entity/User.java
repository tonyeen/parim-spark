package net.parim.system.entity;

import java.util.Date;

import net.parim.common.persistence.DataEntity;
import net.parim.common.persistence.OperateUser;

public class User extends DataEntity<User> implements OperateUser {
	
	private String username;
	private String password;
	private String email;
	private UserGroup userGroup;
	private String salt;
	private String firstName;
	private String lastName;
	private String familiarName;
	private Site site;
	private Date startDate;
	private Date endDate;
	private Boolean allowUpdate;
	private Integer totalSessionCount;
	private Long totalSessionTime;
	
	public UserGroup getUserGroup() {
		return userGroup;
	}
	public void setUserGroup(UserGroup userGroup) {
		this.userGroup = userGroup;
	}
	public String getSalt() {
		return salt;
	}
	public void setSalt(String salt) {
		this.salt = salt;
	}
	public String getFirstName() {
		return firstName;
	}
	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}
	public String getLastName() {
		return lastName;
	}
	public void setLastName(String lastName) {
		this.lastName = lastName;
	}
	public String getFamiliarName() {
		return familiarName;
	}
	public void setFamiliarName(String familiarName) {
		this.familiarName = familiarName;
	}
	public Site getSite() {
		return site;
	}
	public void setSite(Site site) {
		this.site = site;
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
	public Boolean getAllowUpdate() {
		return allowUpdate;
	}
	public void setAllowUpdate(Boolean allowUpdate) {
		this.allowUpdate = allowUpdate;
	}
	public Integer getTotalSessionCount() {
		return totalSessionCount;
	}
	public void setTotalSessionCount(Integer totalSessionCount) {
		this.totalSessionCount = totalSessionCount;
	}
	public Long getTotalSessionTime() {
		return totalSessionTime;
	}
	public void setTotalSessionTime(Long totalSessionTime) {
		this.totalSessionTime = totalSessionTime;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	/* (non-Javadoc)
	 * @see net.parim.common.persistence.OperateUser#getName()
	 */
	@Override
	public String getName() {
		return getFirstName() + getLastName();
		//throw new UnsupportedOperationException("Auto-generated method stub");
	}
}
