package net.parim.sns.modules.sys.repository;

import net.parim.common.persistence.CurdRepository;
import net.parim.common.persistence.annotation.MyBatisReponsitory;
import net.parim.sns.modules.sys.entity.Dict;

@MyBatisReponsitory
public interface DictRepository extends CurdRepository<Dict> {

}
