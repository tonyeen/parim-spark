package net.parim.modules.test.service;

import net.parim.modules.test.dao.TestDao;
import net.parim.modules.test.entity.TestEntity;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class TestService {
	
	@Autowired
	private TestDao testDao;
	
	public TestEntity getTest(Long id){
		return testDao.get(id);
	}
}
