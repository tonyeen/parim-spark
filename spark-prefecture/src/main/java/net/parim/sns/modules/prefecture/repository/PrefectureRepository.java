package net.parim.sns.modules.prefecture.repository;

import java.util.List;

import net.parim.common.persistence.BaseRepository;
import net.parim.common.persistence.CurdRepository;
import net.parim.common.persistence.annotation.MyBatisReponsitory;
import net.parim.sns.modules.prefecture.entity.Prefecture;

@MyBatisReponsitory
public interface PrefectureRepository extends CurdRepository<Prefecture> {
	/**
	 * 精选专题
	 * @param size
	 * @return
	 */
	public List<Prefecture> getChoicenessList(int size);
	
	/**
	 * 部门专题
	 * @param size
	 * @return
	 */
	public List<Prefecture> getDepartmentalList(int size);
	
	/**
	 * 我的学习专题
	 * @return
	 */
	public List<Prefecture> getPrefecturesByUser();
}
