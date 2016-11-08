package com.hplatform.core.service;

import java.util.Arrays;
import java.util.List;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hplatform.core.common.util.FreeMarkerUtil;
import com.hplatform.core.entity.Columns;
import com.hplatform.core.entity.Table;
import com.hplatform.core.exception.CRUDException;
import com.hplatform.core.mapper.ColumnsMapper;
import com.hplatform.core.mapper.TableMapper;

@Service
public class TableService extends BaseService<Table, TableMapper> {
	@Autowired
	private ColumnsMapper columnsMapper;
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
	 * @param table
	 * @throws Exception 
	 */
	public void genChildCode(Table parent) throws Exception{
		for(Table child : parent.getChilds()){
			if(child.getGenFlag()){
				child.setParent(parent);
				child.setRelationType(Table.RelationType.more_2_one);
				FreeMarkerUtil.genCode(child);
			}
		}
	}
	/**
	 * 按照表id组合表与字段的关系
	 * @param id
	 * @return
	 */
	public Table comTable(String id){
		Table genTable = null;
		try {
			genTable = findOne(new Table(id));
			Columns columns = new Columns();
			columns.setTableId(id);
			columns.setGenFlag(Boolean.TRUE);
			List<Columns> columnList = columnsMapper.findAllByRelation(columns);
			for(Table child:genTable.getChilds()){
				columns.setTableId(child.getId());
				child.setColumnList(columnsMapper.findAllByRelation(columns));
			}
			genTable.setColumnList(columnList);
		} catch (CRUDException e) {
			log.error(e);
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
	
}
