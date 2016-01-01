package net.parim.sns.modules.sys.repository;

import net.parim.common.persistence.TreeRepository;
import net.parim.common.persistence.annotation.MyBatisReponsitory;
import net.parim.sns.modules.sys.entity.Site;

@MyBatisReponsitory
public interface SiteRepository extends TreeRepository<Site> {

}
