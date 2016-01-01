package net.parim.system.repository;

import net.parim.common.persistence.CurdRepository;
import net.parim.common.persistence.annotation.MyBatisReponsitory;
import net.parim.system.entity.Menu;

@MyBatisReponsitory
public interface MenuRepository extends CurdRepository<Menu> {

}
