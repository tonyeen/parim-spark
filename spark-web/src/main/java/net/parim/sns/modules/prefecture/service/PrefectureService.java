package net.parim.sns.modules.prefecture.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import net.parim.sns.modules.prefecture.entity.Category;
import net.parim.sns.modules.prefecture.entity.Prefecture;
import net.parim.sns.modules.prefecture.repository.CategoryRepository;
import net.parim.sns.modules.prefecture.repository.PrefectureRepository;

@Service
public class PrefectureService {
	@Autowired
	private PrefectureRepository prefectureRepository;
	
	@Autowired
	private CategoryRepository categoryReponsitory;
	
	public Prefecture findOne(Long id){
		return prefectureRepository.findOne(id);
	}
	
	public void save(Prefecture prefecture){
		if(prefecture.getId() == null || prefecture.getId() <=0){
			prefectureRepository.insert(prefecture);
		}else{
			prefectureRepository.update(prefecture);
		}
		
	}
	
	public List<Prefecture> findAll(Prefecture prefecture){
		return prefectureRepository.findAll();
	}
	
	public Page<Prefecture> findAll(Prefecture prefecture, Pageable pageable){
		return (Page<Prefecture>)prefectureRepository.findAll(prefecture, pageable);
	}

	/**
	 * 精品专区
	 * @param size
	 * @return
	 */
	public Page<Prefecture> getChoicenessList(Prefecture prefecture, Pageable pageable){
		prefecture.setState(net.parim.sns.modules.prefecture.entity.Prefecture.State.EN_APPROVED);
		return (Page<Prefecture>)prefectureRepository.findAll(prefecture, pageable);
	}
	
	/**
	 * 部门专区
	 * @param size
	 * @return
	 */
	public List<Prefecture> getDepartmentalList(int size){
		return prefectureRepository.getDepartmentalList(size);
	}
	
	public List<Category> findAllCategory(){
		return categoryReponsitory.findAll();
	}
}
