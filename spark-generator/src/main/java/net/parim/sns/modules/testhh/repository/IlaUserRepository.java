package net.parim.sns.modules.testhh.repository;

import net.parim.common.persistence.CurdRepository;
import net.parim.common.persistence.annotation.MyBatisRepository;
import net.parim.sns.modules.testhh.entity.IlaUser;

/**
 * 静静地测试DAO接口
 * @author Tony
 * @version 2016-01-05
 */
@MyBatisRepository
public interface IlaUserRepository extends CurdRepository<IlaUser> {
	
}