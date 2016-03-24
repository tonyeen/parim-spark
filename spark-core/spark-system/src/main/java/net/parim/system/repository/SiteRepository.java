package net.parim.system.repository;

import net.parim.common.persistence.annotation.MyBatisRepository;
import net.parim.system.entity.Site;
import net.parim.system.persistent.TreeRepository;

@MyBatisRepository
public interface SiteRepository extends TreeRepository<Site, Long> {

}
