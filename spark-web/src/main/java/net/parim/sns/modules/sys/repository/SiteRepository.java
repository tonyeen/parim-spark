package net.parim.sns.modules.sys.repository;

import net.parim.sns.common.persistence.TreeRepository;
import net.parim.sns.common.persistence.annotation.MyBatisReponsitory;
import net.parim.sns.modules.sys.entity.Site;

@MyBatisReponsitory
public interface SiteRepository extends TreeRepository<Site> {

}
