package net.parim.devwork.repository;

import net.parim.devwork.entity.Post;

import org.springframework.data.repository.CrudRepository;

public interface ProjectReleaseListRepository extends CrudRepository<Post, Long> {

}
