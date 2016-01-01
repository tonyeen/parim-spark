package net.parim.system.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import net.parim.system.entity.Office;
import net.parim.system.repository.OfficeRepository;

@Service
public class OfficeService {
	@Autowired
	OfficeRepository officeRepository;
	
	public Office findById(Long id){
		return officeRepository.findOne(id);
	}
	
	public List<Office> findChildren(Long parentId){
		return officeRepository.findByParentId(parentId);
	}
	
	public List<Office> findAll(){
		return officeRepository.findAll();
	}
	
	public List<Office> findAll(Office office){
		return officeRepository.findAll(office);
	}

}
