package net.parim.devwork.repository;

import java.util.List;

import net.parim.common.persistence.CrudRepository;
import net.parim.common.persistence.annotation.MyBatisRepository;
import net.parim.devwork.entity.Post;

@MyBatisRepository
public interface PostRepository extends CrudRepository<Post, Long> {
	public void deleteAll(List<String> idList);
}
