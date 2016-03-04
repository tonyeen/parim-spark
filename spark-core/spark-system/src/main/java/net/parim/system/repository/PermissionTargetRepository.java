package net.parim.system.repository;

import java.util.List;

import net.parim.common.persistence.BaseRepository;
import net.parim.common.persistence.annotation.MyBatisRepository;
import net.parim.system.entity.PermissionTarget;
import net.parim.system.entity.User;
import net.parim.system.entity.PermissionTarget.ObjectType;

@MyBatisRepository
public interface PermissionTargetRepository extends BaseRepository<PermissionTarget, Long> {
	
	public List<PermissionTarget> findRoots(User user, List<ObjectType> objectTypes);
	
	public List<PermissionTarget> findChildren(PermissionTarget permissionTarget, List<ObjectType> objectTypes);
	
	public List<PermissionTarget> findAllChildren(Long parentId);
}
