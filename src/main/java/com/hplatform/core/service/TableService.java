package com.hplatform.core.service;

import java.util.Arrays;
import java.util.List;

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
			try {
				genTable = findOne(new Table(id));
				Columns columns = new Columns();
				columns.setTableId(table.getId());
				columns.setGenFlag(Boolean.TRUE);
				List<Columns> columnList = columnsMapper.findAllByRelation(columns);
				genTable.setColumnList(columnList);
				FreeMarkerUtil.genCode(genTable);
			} catch (CRUDException e) {
				log.error(e);
			}
		}
	}
}
