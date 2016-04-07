package com.hplatform.core.service;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import com.hplatform.core.entity.ColumnElement;
import com.hplatform.core.entity.Columns;
import com.hplatform.core.entity.Element;
import com.hplatform.core.entity.Tags;
import com.hplatform.core.exception.CRUDException;
import com.hplatform.core.mapper.ElementMapper;
@Service
public class ElementService extends BaseService<Element, ElementMapper> {
	/**
	 * 定义标签元素
	 * @param tags
	 * @throws CRUDException 
	 */
	public void editElement(Tags tags) throws CRUDException {
		for(Element element : tags.getElements()){
			element.setTagId(tags.getId());
			if(!StringUtils.isBlank(element.getElementName()))
				if(StringUtils.isBlank(element.getId()))
					save(element);
				else
					update(element);
		}
	}
	/**
	 * 保存标签元素值
	 * @param tags
	 * @throws CRUDException
	 */
	public void saveTagElements(Columns columns) throws CRUDException {
		if(!CollectionUtils.isEmpty(columns.getColumnElements())){
			m.deleteColumnElements(columns.getId());
			for(ColumnElement columnElement : columns.getColumnElements()){
				columnElement.preInsert();
				columnElement.setColumnId(columns.getId());
				m.saveColumnElements(columnElement);
			}
		}
	}
}