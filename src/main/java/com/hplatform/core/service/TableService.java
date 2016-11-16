package com.hplatform.core.service;

import cn.org.rapid_framework.util.ObjectUtils;
import com.hplatform.core.common.util.ConstantsUtil;
import com.hplatform.core.common.util.FreeMarkerUtil;
import com.hplatform.core.constants.TableConstants;
import com.hplatform.core.entity.Columns;
import com.hplatform.core.entity.Table;
import com.hplatform.core.exception.CRUDException;
import com.hplatform.core.mapper.TableMapper;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@Service
public class TableService extends BaseService<Table, TableMapper> {
	@Autowired
	private ColumnsService columnsService;
	/**
	 * 批量代码生成
	 * @param table
	 * @throws Exception 
	 */
	public void genCodeBatch(Table table) throws Exception {
		List<String> idList = Arrays.asList(table.getId().split(","));
		Table genTable = null;
		for(String id : idList){
			genTable = findOne(new Table(id));
			if(null!=genTable){
				if(Table.RelationType.one_2_more.equals(genTable.getRelationType())) {
					if(CollectionUtils.isNotEmpty(genTable.getChilds()))
						genOneToMore(genTable);
					else
						genOne(genTable);
				}else if(Table.RelationType.more_2_one.equals(genTable.getRelationType())) {
					if(ObjectUtils.isNotEmpty(genTable.getParent())){
						//反向按照一对多进行生成
						genTable.getParent().addChilds(genTable);
						genOneToMore(genTable.getParent());
					}else{
						//如果没有父表则按照单表生成策略生成
						genOne(genTable);
					}
				}else if (Table.RelationType.one.equals(genTable.getRelationType())){
					genOne(genTable);
				}else if (Table.RelationType.one_2_one.equals(genTable.getRelationType())){
					genOneToOne(genTable);
				}
			}

		}
	}

	/**
	 * 生成单表
	 * @param genTable
	 * @throws Exception
	 */
	public void genOne(Table genTable) throws Exception {
		genTable = comTable(genTable);
		genTable.setRelationType(Table.RelationType.one);
		FreeMarkerUtil.genCode(genTable);
	}

	/**
	 * 生成一对一的表结构代码
	 * @param genTable
	 * @throws Exception
	 */
	public void genOneToOne(Table genTable)throws Exception {
		//主表采用一对一模板从表采用多对一模板
		genOneToMore(genTable);
	}
	/**
	 * 生成一对多代码
	 * @param genTable
	 * @throws Exception
	 */
	public void genOneToMore(Table genTable) throws Exception {
		genTable = comTable(genTable);
		FreeMarkerUtil.genCode(genTable);
		genChildCode(genTable);
	}

	/**
	 * 按照关系生成子表代码
	 * @param parent
	 * @throws Exception
	 */
	public void genChildCode(Table parent) throws Exception{
		for(Table child : parent.getChilds()){
			child.setParent(parent);
			child.setRelationType(Table.RelationType.more_2_one);
			FreeMarkerUtil.genCode(child);
		}
	}
	/**
	 * 按照表id组合表与字段的关系
	 * @param genTable
	 * @return
	 */
	public Table comTable(Table genTable)throws CRUDException{
		try {
			Columns columns = new Columns();
			columns.setTableId(genTable.getId());
			columns.setGenFlag(Boolean.TRUE);
			ArrayList<Columns> columnList = columnsService.findByRelation(columns);
			for(Table child:genTable.getChilds()){
				columns.setTableId(child.getId());
				child.setColumnList(columnsService.findByRelation(columns));
			}
			genTable.setColumnList(columnList);
		} catch (CRUDException e) {
			log.error(e);
			throw new CRUDException(e);
		}
		return genTable;
	}
	@Override
	public void save(Table t) throws CRUDException {
		super.save(t);
		if(CollectionUtils.isNotEmpty(t.getChilds())){
			for(Table child : t.getChilds()){
				child.setParent(t);
				child.setStep(TableConstants.GEN_STEP_ONE);
				super.save(child);
			}
		}
	}

	@Override
	public void update(Table t) throws CRUDException {
		super.update(t);
		if(CollectionUtils.isNotEmpty(t.getChilds())){
			for(Table child : t.getChilds()){
				if(StringUtils.isNotBlank(child.getId()))
					super.update(child);
				else
					super.save(child);
			}
		}
	}

	/**
	 * 修改标的生成标识为已完成
	 * @param id
	 * @throws CRUDException
	 */
	public void updateGenComplete(String id) throws CRUDException {
		Table update = new Table(id);
		update.setStatu(ConstantsUtil.get().getDICT_YES_PARENT_ID());
		update.setStep(TableConstants.GEN_STEP_THREE);
		update.setGenFlag(true);
		super.update(update);
	}

	/**
	 * 重置方案生成规则
	 * @param tableId
	 */
	public void resetGenRules(String tableId)throws CRUDException{
		try{
			Table table = new Table(tableId);
			columnsService.resetGenRules(table);
			table.setStep(TableConstants.GEN_STEP_ONE);
			table.setStatu(ConstantsUtil.get().getDICT_NO_PARENT_ID());
			table.setGenFlag(true);
			super.update(table);
		}catch(Exception e){
			log.error(e);
			throw new CRUDException(e);
		}
	}
}
