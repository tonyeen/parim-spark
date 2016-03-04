package net.parim.common.service;

import java.io.Serializable;
import java.util.List;

import net.parim.common.persistence.BaseEntity;
import net.parim.common.persistence.CrudRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.transaction.annotation.Transactional;


/**
 * Service基类
 * @author YinTao
 * @version 2014-04-26
 */
@Transactional(readOnly = true)
public abstract class CrudService<R extends CrudRepository<T, ID>, 
			T extends BaseEntity<?>, 
			ID extends Serializable>
		extends BaseService {
	
	/**
	 * 持久层对象
	 */
	@Autowired
	protected R repository;
	
	/**
	 * 获取单条数据
	 * @param id
	 * @return
	 */
	public T findOne(ID id) {
		return repository.findOne(id);
	}
	
	/**
	 * 获取单条数据
	 * @param entity
	 * @return
	 */
	public T findOne(T entity) {
		return repository.findOne(entity);
	}
	
	/**
	 * 查询列表数据
	 * @param entity
	 * @return
	 */
	public List<T> findAll(T entity) {
		return repository.findAll(entity);
	}
	
	/**
	 * 查询分页数据
	 * @param page 分页对象
	 * @param entity
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Page<T> findAll(T entity, Pageable pageable) {
		return (Page<T>)repository.findAll(entity, pageable);
	}

	/**
	 * 保存数据（插入或更新）
	 * @param entity
	 */
	@Transactional(readOnly = false)
	public void save(T entity) {
		if (entity.isNewRecord()){
			//entity.preInsert();
			repository.insert(entity);
		}else{
			//entity.preUpdate();
			repository.update(entity);
		}
	}
	
	/**
	 * 删除数据
	 * @param entity
	 */
	@Transactional(readOnly = false)
	public void delete(T entity) {
		repository.delete(entity);
	}

}
