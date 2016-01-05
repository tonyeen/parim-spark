package net.parim.sns.modules.prefecture.repository;

import net.parim.common.persistence.CurdRepository;
import net.parim.common.persistence.annotation.MyBatisRepository;
import net.parim.sns.modules.prefecture.entity.Category;

@MyBatisRepository
public interface CategoryRepository extends CurdRepository<Category> {

}
