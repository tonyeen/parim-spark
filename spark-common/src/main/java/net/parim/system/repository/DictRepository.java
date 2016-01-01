package net.parim.system.repository;

import net.parim.common.persistence.CurdRepository;
import net.parim.common.persistence.annotation.MyBatisReponsitory;
import net.parim.system.entity.Dict;

@MyBatisReponsitory
public interface DictRepository extends CurdRepository<Dict> {

}
