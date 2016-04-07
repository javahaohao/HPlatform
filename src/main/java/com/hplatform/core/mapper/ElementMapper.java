package com.hplatform.core.mapper;

import java.util.List;

import com.hplatform.core.common.annotation.MyBatisMapper;
import com.hplatform.core.entity.ColumnElement;
import com.hplatform.core.entity.Element;
import com.hplatform.core.mapper.BaseMapper;
@MyBatisMapper
public interface ElementMapper extends BaseMapper<Element>{
	public void deleteEntityByTagId(String tagId);
	public List<ColumnElement> findColumnElements(ColumnElement columnElement);
	public void deleteColumnElements(String columnId);
	public void saveColumnElements(ColumnElement columnElement);
}