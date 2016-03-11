package net.parim.devwork.entity;

import net.parim.system.entity.DataEntity;

public class ProjectRepository extends DataEntity<ProjectRepository> {

	private static final long serialVersionUID = 1L;
	
	private String name;
	private String Url;
	private Boolean snapshotsEnable;
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getUrl() {
		return Url;
	}
	public void setUrl(String url) {
		Url = url;
	}
	
	public Boolean getSnapshotsEnable() {
		return snapshotsEnable;
	}
	public void setSnapshotsEnable(Boolean snapshotsEnable) {
		this.snapshotsEnable = snapshotsEnable;
	}
}
