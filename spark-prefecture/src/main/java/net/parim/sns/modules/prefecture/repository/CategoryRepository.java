package net.parim.sns.modules.prefecture.repository;

import net.parim.common.persistence.CurdRepository;
import net.parim.common.persistence.annotation.MyBatisReponsitory;
import net.parim.sns.modules.prefecture.entity.Category;

@MyBatisReponsitory
public interface CategoryRepository extends CurdRepository<Category> {

}
