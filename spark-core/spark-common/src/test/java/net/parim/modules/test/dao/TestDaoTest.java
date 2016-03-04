package net.parim.modules.test.dao;

import org.junit.Assert;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import net.parim.common.test.SpringTransactionalContextTests;

public class TestDaoTest extends SpringTransactionalContextTests {
	
	@Autowired
	private TestDao testDao;

	@Test
	public void testGet() {
		//net.parim.modules.test.entity.TestEntity testModel = testDao.get(44075L);
		//Assert.assertNotNull(testModel);
		//Assert.assertEquals(44075L, testModel.getId().longValue());
		//Assert.assertEquals("parim", testModel.getUsername());
	}
}
