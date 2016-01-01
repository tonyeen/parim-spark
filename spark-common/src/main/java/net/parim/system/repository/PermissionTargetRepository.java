package net.parim.system.repository;

import java.util.List;

import net.parim.common.persistence.BaseRepository;
import net.parim.common.persistence.annotation.MyBatisReponsitory;
import net.parim.system.entity.PermissionTarget;
import net.parim.system.entity.User;
import net.parim.system.entity.PermissionTarget.ObjectType;

@MyBatisReponsitory
public interface PermissionTargetRepository extends BaseRepository<PermissionTarget> {
	
	public List<PermissionTarget> findRoots(User user, List<ObjectType> objectTypes);
	
	public List<PermissionTarget> findChildren(PermissionTarget permissionTarget, List<ObjectType> objectTypes);
}
