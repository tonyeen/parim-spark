package net.parim.devwork.entity;

import net.parim.system.entity.DataEntity;

public class ProjectReleaseList extends DataEntity<ProjectReleaseList> {

	private static final long serialVersionUID = 1L;
	
	private Long projectId;
	private String versionName;
	private String reponsitoryId;
	private String apiDocUrl;
	private String artifactId;
	private String groupId;
	private Boolean isCurrent;
	private String refDocUrl;
	private ReleaseStatus releaseStatus;

	public Long getProjectId() {
		return projectId;
	}

	public void setProjectId(Long projectId) {
		this.projectId = projectId;
	}

	public String getVersionName() {
		return versionName;
	}

	public void setVersionName(String versionName) {
		this.versionName = versionName;
	}

	public String getReponsitoryId() {
		return reponsitoryId;
	}

	public void setReponsitoryId(String reponsitoryId) {
		this.reponsitoryId = reponsitoryId;
	}

	public String getApiDocUrl() {
		return apiDocUrl;
	}

	public void setApiDocUrl(String apiDocUrl) {
		this.apiDocUrl = apiDocUrl;
	}

	public String getArtifactId() {
		return artifactId;
	}

	public void setArtifactId(String artifactId) {
		this.artifactId = artifactId;
	}

	public String getGroupId() {
		return groupId;
	}

	public void setGroupId(String groupId) {
		this.groupId = groupId;
	}

	public Boolean getIsCurrent() {
		return isCurrent;
	}

	public void setIsCurrent(Boolean isCurrent) {
		this.isCurrent = isCurrent;
	}

	public String getRefDocUrl() {
		return refDocUrl;
	}

	public void setRefDocUrl(String refDocUrl) {
		this.refDocUrl = refDocUrl;
	}

	public ReleaseStatus getReleaseStatus() {
		return releaseStatus;
	}

	public void setReleaseStatus(ReleaseStatus releaseStatus) {
		this.releaseStatus = releaseStatus;
	}
	
	enum ReleaseStatus {
		SNAPSHOTS,
		RELEASE
	}

}
