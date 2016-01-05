/**
 * Copyright &copy; 2012-2014 <a href="http://spark.parim.net">Parim Stark Team</a> All rights reserved.
 */
package net.parim.sns.modules.testhh.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import net.parim.common.service.CrudService;
import net.parim.sns.modules.testhh.entity.IlaUser;
import net.parim.sns.modules.testhh.repository.IlaUserRepository;

/**
 * 静静地测试Service
 * @author Tony
 * @version 2016-01-05
 */
@Service
@Transactional(readOnly = true)
public class IlaUserService extends CrudService<IlaUserRepository, IlaUser> {

    @Autowired
    private IlaUserRepository ilaUserRepository;

	public IlaUser findOne(Long id) {
		return super.findOne(id);
	}
	
	public List<IlaUser> findAll(IlaUser ilaUser) {
		return super.findAll(ilaUser);
	}
	
	public Page<IlaUser> findAll(IlaUser ilaUser, Pageable pageable) {
		return super.findAll(ilaUser, pageable);
	}
	
	@Transactional(readOnly = false)
	public void save(IlaUser ilaUser) {
		super.save(ilaUser);
	}
	
	@Transactional(readOnly = false)
	public void delete(IlaUser ilaUser) {
		super.delete(ilaUser);
	}
	
}