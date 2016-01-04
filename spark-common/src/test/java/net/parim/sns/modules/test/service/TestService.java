package net.parim.sns.modules.test.service;

import net.parim.sns.modules.test.dao.TestDao;
import net.parim.sns.modules.test.entity.Test;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class TestService {
	
	@Autowired
	private TestDao testDao;
	
	public Test getTest(Long id){
		return testDao.get(id);
	}
}
