/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package net.parim.sns.modules.gen.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import net.parim.common.service.BaseService;
import net.parim.common.utils.StringUtils;
import net.parim.sns.modules.gen.dao.GenSchemeDao;
import net.parim.sns.modules.gen.dao.GenTableColumnDao;
import net.parim.sns.modules.gen.dao.GenTableDao;
import net.parim.sns.modules.gen.entity.GenConfig;
import net.parim.sns.modules.gen.entity.GenScheme;
import net.parim.sns.modules.gen.entity.GenTable;
import net.parim.sns.modules.gen.entity.GenTableColumn;
import net.parim.sns.modules.gen.entity.GenTemplate;
import net.parim.sns.modules.gen.util.GenUtils;

/**
 * 生成方案Service
 * @author ThinkGem
 * @version 2013-10-15
 */
@Service
@Transactional(readOnly = true)
public class GenSchemeService extends BaseService {

	@Autowired
	private GenSchemeDao genSchemeDao;
//	@Autowired
//	private GenTemplateDao genTemplateDao;
	@Autowired
	private GenTableDao genTableDao;
	@Autowired
	private GenTableColumnDao genTableColumnDao;
	
	public GenScheme get(Long id) {
		return genSchemeDao.findOne(id);
	}
	
	public Page<GenScheme> find(GenScheme genScheme, Pageable pageable) {
		GenUtils.getTemplatePath();
		return (Page<GenScheme>)genSchemeDao.findAll(genScheme, pageable);
	}
	
	@Transactional(readOnly = false)
	public String save(GenScheme genScheme) {
		if (StringUtils.isBlank(genScheme.getId())){
			//genScheme.preInsert();
			genSchemeDao.insert(genScheme);
		}else{
			//genScheme.preUpdate();
			genSchemeDao.update(genScheme);
		}
		// 生成代码
		/*if ("1".equals(genScheme.getFlag())){
			return generateCode(genScheme);
		}*/
		return "";
	}
	
	@Transactional(readOnly = false)
	public void delete(GenScheme genScheme) {
		genSchemeDao.delete(genScheme);
	}
	
	public String generateCode(GenScheme genScheme){

		StringBuilder result = new StringBuilder();
		
		// 查询主表及字段列
		GenTable genTable = genTableDao.findOne(genScheme.getGenTable().getId());
		genTable.setColumnList(genTableColumnDao.findAll(new GenTableColumn(new GenTable(genTable.getId()))));
		
		// 获取所有代码模板
		GenConfig config = GenUtils.getConfig();
		
		// 获取模板列表
		List<GenTemplate> templateList = GenUtils.getTemplateList(config, genScheme.getCategory(), false);
		List<GenTemplate> childTableTemplateList = GenUtils.getTemplateList(config, genScheme.getCategory(), true);
		
		// 如果有子表模板，则需要获取子表列表
		if (childTableTemplateList.size() > 0){
			GenTable parentTable = new GenTable();
			parentTable.setParentTable(genTable.getName());
			genTable.setChildList(genTableDao.findAll(parentTable));
		}
		
		// 生成子表模板代码
		for (GenTable childTable : genTable.getChildList()){
			childTable.setParent(genTable);
			childTable.setColumnList(genTableColumnDao.findAll(new GenTableColumn(new GenTable(childTable.getId()))));
			genScheme.setGenTable(childTable);
			Map<String, Object> childTableModel = GenUtils.getDataModel(genScheme);
			for (GenTemplate tpl : childTableTemplateList){
				result.append(GenUtils.generateToFile(tpl, childTableModel, genScheme.getReplaceFile(), genScheme.getProjectDir()));
			}
		}
		
		// 生成主表模板代码
		genScheme.setGenTable(genTable);
		Map<String, Object> model = GenUtils.getDataModel(genScheme);
		for (GenTemplate tpl : templateList){
			result.append(GenUtils.generateToFile(tpl, model, genScheme.getReplaceFile(), genScheme.getProjectDir()));
		}
		return result.toString();
	}
}
