package net.parim.system.repository;

import net.parim.common.persistence.TreeRepository;
import net.parim.common.persistence.annotation.MyBatisRepository;
import net.parim.system.entity.Site;

@MyBatisRepository
public interface SiteRepository extends TreeRepository<Site, Long> {

}
