package com.hplatform.core.service;

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
			genTable = comTable(id);
			FreeMarkerUtil.genCode(genTable);
			if(Table.RelationType.one_2_more.equals(genTable.getRelationType()))
				genChildCode(genTable);
		}
	}
	/**
	 * 生成子表代码
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
	 * @param id
	 * @return
	 */
	public Table comTable(String id)throws CRUDException{
		Table genTable = null;
		try {
			genTable = findOne(new Table(id));
			Columns columns = new Columns();
			columns.setTableId(id);
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
