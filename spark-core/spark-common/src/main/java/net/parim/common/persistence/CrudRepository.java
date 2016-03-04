package net.parim.common.persistence;

import java.io.Serializable;
import java.util.List;

import org.springframework.data.domain.Pageable;

public interface CrudRepository<E extends BaseEntity<?>, ID extends Serializable> 
		extends BaseRepository<E, ID> {

	public void insert(E entity);
	
	public void update(E entity);
	
	public void delete(ID id);
	
	public void delete(E entity);
	
	public E findOne(ID id);
	
	public E findOne(E entity);
	
	public List<E> findAll();
	
	public List<E> findAll(E entity);
	
	public List<E> findAll(E entity, Pageable pageable);
}
