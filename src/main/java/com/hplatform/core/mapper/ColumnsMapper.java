package com.hplatform.core.mapper;

import java.util.List;

import com.hplatform.core.common.annotation.MyBatisMapper;
import com.hplatform.core.entity.ColumnValidate;
import com.hplatform.core.entity.Columns;
@MyBatisMapper
public interface ColumnsMapper extends BaseMapper<Columns>{
	public List<Columns> findTableDefaultColumns(Columns columns);
	public List<Columns> findAllByRelation(Columns columns);
	public void deleteColumnValidates(Columns columns);
	public void saveColumnValidates(ColumnValidate columnValidate);
}