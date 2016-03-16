package net.parim.devwork.web;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import net.parim.common.web.BaseController;
import net.parim.devwork.entity.Post;
import net.parim.devwork.service.PostService;

@Controller						   
@RequestMapping(value="${adminPath}/devwork/post/")
public class PostController extends BaseController {
	@Value(value="${adminPath}")
	String adminPath;
	
	@Autowired
	private PostService postService;
	
	//列表显示
	@RequestMapping("list")
	public String postList(@PageableDefault Pageable pageable, Post post, Model model){
		Page<Post> posts = postService.findAll(post, pageable);
		model.addAttribute("posts", posts);
		return "admin/devwork/postList";
	}
	//增加、修改跳转方法
	@RequestMapping(value={"properties", "properties/{id}"})
	public String postProperties(Post post, Model model){
		
		if(null != post.getId() && !"".equals(post.getId()))
		{
			Post valuePost = postService.findOne(post.getId());
			post = valuePost;
		}
		model.addAttribute(post);
		return "admin/devwork/postProperties";
	}
	//发布
	@RequestMapping(value={"ajax"})
	@ResponseBody
	public Page<Post> ajaxProperties(Post post, Model model,@PageableDefault Pageable pageable)
	{
		Post valuePost = postService.findOne(post.getId());
		java.sql.Date currentDate = new java.sql.Date(System.currentTimeMillis());
		valuePost.setPublishDate(currentDate);
		valuePost.setDraft(false);
		postService.save(valuePost);
		post = valuePost;
		Page<Post> posts = postService.findAll(new Post(), pageable);
		model.addAttribute("posts", posts);
		return posts;
	}

	@ModelAttribute
	public void getThemeline(@RequestParam(value = "id", defaultValue = "-1") Long id, Model model){
		if(id!=-1){
			Post post = postService.findOne(id);
			model.addAttribute(post);
		}
	}
	//保存
	@RequestMapping(value="save")
	public String savePostProperties(Post post, Model model){
		model.addAttribute(post);
		postService.save(post);
		return "redirect:"+adminPath+"/devwork/post/list";
	}
	//单条、批量删除
	@RequestMapping(value="deleteAll/{ids}")
	public String deletePostProperties(Post post, Model model,@PathVariable(value="ids") String ids){
		List<String> idList = new ArrayList<String>();
		if("".equals(ids) || null == ids)
		{
			String idString = post.getId()+"";
			idList.add(idString);
		}else{
			if(ids.contains(","))
			{
				String[] idArray = ids.split(",");
				
				for(String idString : idArray)
				{
					idList.add(idString);
				}
				//如果单条删除
			}else{
				idList.add(ids);
			}
		}
		postService.deleteAll(idList);
		return "redirect:"+adminPath+"/devwork/post/list";
	}
	//模糊查询
	@RequestMapping(value="findone")
	public String findPost(@PageableDefault Pageable pageable,Post post, Model model){
		Page<Post> posts = postService.findAll(post, pageable);
		model.addAttribute("posts", posts);
		return "admin/devwork/postList";
	}
}
