package net.parim.sns.modules.sys.repository;

import java.util.List;

import net.parim.common.persistence.BaseRepository;
import net.parim.common.persistence.annotation.MyBatisReponsitory;
import net.parim.sns.modules.sys.entity.PermissionTarget;
import net.parim.sns.modules.sys.entity.PermissionTarget.ObjectType;
import net.parim.sns.modules.sys.entity.User;

@MyBatisReponsitory
public interface PermissionTargetRepository extends BaseRepository<PermissionTarget> {
	
	public List<PermissionTarget> findRoots(User user, List<ObjectType> objectTypes);
	
	public List<PermissionTarget> findChildren(PermissionTarget permissionTarget, List<ObjectType> objectTypes);
}
