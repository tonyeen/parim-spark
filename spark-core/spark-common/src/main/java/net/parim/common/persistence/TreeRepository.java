package net.parim.common.persistence;

import java.io.Serializable;
import java.util.List;

public interface TreeRepository<E extends TreeEntity<?>, ID extends Serializable> 
		extends CrudRepository<E, ID> {
	
	//public List<?> findAllRoots(E entity);
	
	public List<?> findAllRoots(E entity, OperateUser user);
	
	public List<?> findChildren(E entity);
	
	/**
	 * 查找所有的子节点
	 * @param entity
	 * @return
	 */
	public List<?> findAllChildren(E entity);
	
	/**
	 * 查找所有的上级节点
	 * @param entity
	 * @return
	 */
	public List<?> findAllParents(E entity); 
	
}
