package net.parim.system.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import net.parim.system.entity.Dict;
import net.parim.system.repository.DictRepository;

@Service
public class DictService {
	
	@Autowired
	DictRepository dictRepository;
	
	public void save(Dict dict){
		if(dict.isNewRecord()){
			dictRepository.insert(dict);
		}else{
			dictRepository.update(dict);
		}
	}
	
	public Dict findOne(Long id){
		return dictRepository.findOne(id);
	}
	
	public void delete(Long id)
	{
		dictRepository.delete(id);
	}
	
	public List<Dict> findAll(){
		
		return dictRepository.findAll();
	}
	
	public Page<Dict> findAll(Dict dict, Pageable pageable){
		
		return (Page<Dict>)dictRepository.findAll(dict, pageable);
	}
}
