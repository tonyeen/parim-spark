package net.parim.sns.modules.testhh.entity;

import org.hibernate.validator.constraints.Length;
import javax.validation.constraints.NotNull;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import net.parim.system.entity.User;

import net.parim.common.persistence.DataEntity;

/**
 * 静静地测试Entity
 * @author Tony
 * @version 2016-01-05
 */
public class IlaUser extends DataEntity<IlaUser> {
	
	private static final long serialVersionUID = 1L;
	private String email;		// email
	private Long userGroup;		// user_group_id
	private String username;		// username
	private String password;		// password
	private String salt;		// salt
	private String firstName;		// first_name
	private String lastName;		// last_name
	private String familiarName;		// familiar_name
	private Long siteId;		// site_id
	private Date startDate;		// start_date
	private Date endDate;		// end_date
	private String allowUpdate;		// allow_update
	private String totalSessionCount;		// total_session_count
	private Long totalSessionTime;		// total_session_time
	private User createdBy;		// created_by
	private User lastUpdatedBy;		// last_updated_by
	private Date lastUpdateDate;		// last_update_date
	
	public IlaUser() {
		super();
	}

	public IlaUser(String id){
		super(id);
	}

	@Length(min=1, max=200, message="email长度必须介于 1 和 200 之间")
	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}
	
	public Long getUserGroup() {
		return userGroup;
	}

	public void setUserGroup(Long userGroup) {
		this.userGroup = userGroup;
	}
	
	@Length(min=1, max=200, message="username长度必须介于 1 和 200 之间")
	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}
	
	@Length(min=1, max=200, message="password长度必须介于 1 和 200 之间")
	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}
	
	@Length(min=1, max=32, message="salt长度必须介于 1 和 32 之间")
	public String getSalt() {
		return salt;
	}

	public void setSalt(String salt) {
		this.salt = salt;
	}
	
	@Length(min=1, max=200, message="first_name长度必须介于 1 和 200 之间")
	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}
	
	@Length(min=1, max=200, message="last_name长度必须介于 1 和 200 之间")
	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}
	
	@Length(min=0, max=200, message="familiar_name长度必须介于 0 和 200 之间")
	public String getFamiliarName() {
		return familiarName;
	}

	public void setFamiliarName(String familiarName) {
		this.familiarName = familiarName;
	}
	
	@NotNull(message="site_id不能为空")
	public Long getSiteId() {
		return siteId;
	}

	public void setSiteId(Long siteId) {
		this.siteId = siteId;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getStartDate() {
		return startDate;
	}

	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getEndDate() {
		return endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}
	
	@Length(min=0, max=1, message="allow_update长度必须介于 0 和 1 之间")
	public String getAllowUpdate() {
		return allowUpdate;
	}

	public void setAllowUpdate(String allowUpdate) {
		this.allowUpdate = allowUpdate;
	}
	
	@Length(min=0, max=11, message="total_session_count长度必须介于 0 和 11 之间")
	public String getTotalSessionCount() {
		return totalSessionCount;
	}

	public void setTotalSessionCount(String totalSessionCount) {
		this.totalSessionCount = totalSessionCount;
	}
	
	public Long getTotalSessionTime() {
		return totalSessionTime;
	}

	public void setTotalSessionTime(Long totalSessionTime) {
		this.totalSessionTime = totalSessionTime;
	}
	
	@NotNull(message="created_by不能为空")
	public User getCreatedBy() {
		return createdBy;
	}

	public void setCreatedBy(User createdBy) {
		this.createdBy = createdBy;
	}
	
	@NotNull(message="last_updated_by不能为空")
	public User getLastUpdatedBy() {
		return lastUpdatedBy;
	}

	public void setLastUpdatedBy(User lastUpdatedBy) {
		this.lastUpdatedBy = lastUpdatedBy;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@NotNull(message="last_update_date不能为空")
	public Date getLastUpdateDate() {
		return lastUpdateDate;
	}

	public void setLastUpdateDate(Date lastUpdateDate) {
		this.lastUpdateDate = lastUpdateDate;
	}
	
}