package com.hplatform.core.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import cn.org.rapid_framework.util.ObjectUtils;

import com.hplatform.core.common.util.ConstantsUtil;
import com.hplatform.core.common.util.StringUtils;
import com.hplatform.core.entity.ColumnValidate;
import com.hplatform.core.entity.Columns;
import com.hplatform.core.entity.Table;
import com.hplatform.core.exception.CRUDException;
import com.hplatform.core.mapper.ColumnsMapper;
import com.hplatform.core.mapper.TableMapper;
@Service
public class ColumnsService extends BaseService<Columns, ColumnsMapper> {
	@Autowired
	private TableMapper tableMapper;
	@Autowired
	private ElementService elementService;
	/**
	 * 查询所有信息
	 * @param attachment
	 * @return
	 * @throws CRUDException
	 */
	public List<Columns> findAllByRelation(Columns columns) throws CRUDException{
		try{
			List<Columns> columnList = m.findAllByRelation(columns);
			if(CollectionUtils.isEmpty(columnList)){
				columnList = findTableDefaultColumns(columns);
			}
			return columnList;
		}catch(Exception e){
			log.error(e);
			throw new CRUDException(e);
		}
	}
	/**
	 * 查询默认表的默认字段
	 * @param columns
	 * @return
	 */
	public List<Columns> findTableDefaultColumns(Columns columns){
		Table table = tableMapper.findOne(new Table(columns.getTableId()));
		columns.setTableName(table.getTableName());
		List<Columns> columnsList = m.findTableDefaultColumns(columns);
		for(Columns column : columnsList){
			column.setPropertiesName(StringUtils.getHumpStr(column.getColumnName()));
			column.setPropertiesType(ConstantsUtil.get().getMysqlDataType(column.getDataType()));
		}
		return columnsList;
	}
	/**
	 * 查询一条数据
	 * @param columns
	 * @return
	 * @throws CRUDException
	 */
	public Columns findOne(Columns columns) throws CRUDException{
		try{
			return super.findOne(columns);
		}catch(Exception e){
			log.error(e);
			throw new CRUDException(e);
		}
	}
	/**
	 * 修改生成列规则
	 * @param columns
	 * @throws CRUDException
	 */
	public void editColumns(List<Columns> columnList) throws CRUDException{
		for(Columns columns : columnList){
			if(org.apache.commons.lang3.StringUtils.isBlank(columns.getId()))
				save(columns);
			else
				update(columns);
			elementService.saveTagElements(columns);
			saveColumnValidates(columns);
		}
	}
	/**
	 * 保存验证规则
	 * @param columns
	 */
	public void saveColumnValidates(Columns columns){
		m.deleteColumnValidates(columns);
		if(ObjectUtils.isNotEmpty(columns)&&ObjectUtils.isNotEmpty(columns.getColumnValidates())){
			for(ColumnValidate columnValidate : columns.getColumnValidates()){
				if(!org.apache.commons.lang3.StringUtils.isBlank(columnValidate.getValidateVal())){
					columnValidate.setColumnId(columns.getId());
					columnValidate.preInsert();
					m.saveColumnValidates(columnValidate);
				}
			}
		}
	}
}