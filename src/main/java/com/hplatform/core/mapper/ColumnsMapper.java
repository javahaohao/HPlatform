package com.hplatform.core.mapper;

import com.hplatform.core.common.annotation.MyBatisMapper;
import com.hplatform.core.entity.ColumnValidate;
import com.hplatform.core.entity.Columns;

import java.util.ArrayList;
import java.util.List;
@MyBatisMapper
public interface ColumnsMapper extends BaseMapper<Columns>{
	public List<Columns> findTableDefaultColumns(Columns columns);
	public ArrayList<Columns> findAllByRelation(Columns columns);
	public ArrayList<ColumnValidate> findAllByValidate(Columns columns);
	public void deleteColumnValidates(Columns columns);
	public void saveColumnValidates(ColumnValidate columnValidate);
}