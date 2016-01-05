package net.parim.sns.modules.gen.service;

import net.parim.sns.common.test.SpringTransactionalContextTests;
import net.parim.sns.modules.gen.entity.GenScheme;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

public class GenSchemeServiceTest extends SpringTransactionalContextTests {

	@Autowired
	GenSchemeService service;
	
	@Test
	public void testGenerateCode(){
		GenScheme genScheme = service.get(1L);
		genScheme.setProjectDir("D:\\workspace\\eclipse\\parim-spark\\spark-generator");
		genScheme.setReplaceFile(true);
		service.generateCode(genScheme);
	}
	
}
