package net.parim.sns.modules.prefecture.repository;

import net.parim.sns.common.persistence.CurdRepository;
import net.parim.sns.common.persistence.annotation.MyBatisReponsitory;
import net.parim.sns.modules.prefecture.entity.Category;

@MyBatisReponsitory
public interface CategoryRepository extends CurdRepository<Category> {

}
