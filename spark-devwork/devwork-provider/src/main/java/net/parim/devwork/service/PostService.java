package net.parim.devwork.service;

import java.util.List;

import org.springframework.stereotype.Service;

import net.parim.common.service.CrudService;
import net.parim.devwork.entity.Post;
import net.parim.devwork.repository.PostRepository;

@Service
public class PostService extends CrudService<PostRepository, Post, Long> {
	//删除方法（包含多条删除和单条删除）
	public void deleteAll(List<String> idList){
		repository.deleteAll(idList);
	};
}
	
