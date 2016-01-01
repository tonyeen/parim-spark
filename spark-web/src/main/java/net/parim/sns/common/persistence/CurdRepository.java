package net.parim.sns.common.persistence;

import java.util.List;

import org.springframework.data.domain.Pageable;

public interface CurdRepository<E extends BaseEntity<?>> extends BaseRepository<E> {

	public void insert(E entity);
	
	public void update(E entity);
	
	public void delete(Long id);
	
	public void delete(E entity);
	
	public E findOne(Long id);
	
	public List<E> findAll();
	
	public List<E> findAll(E entity);
	
	public List<E> findAll(E entity, Pageable pageable);
}
