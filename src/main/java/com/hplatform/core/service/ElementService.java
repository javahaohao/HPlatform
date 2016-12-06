package com.hplatform.core.service;

import com.hplatform.core.common.util.ConstantsUtil;
import com.hplatform.core.entity.ColumnElement;
import com.hplatform.core.entity.Columns;
import com.hplatform.core.entity.Element;
import com.hplatform.core.entity.Tags;
import com.hplatform.core.exception.CRUDException;
import com.hplatform.core.mapper.ElementMapper;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ElementService extends BaseService<Element, ElementMapper> {
	/**
	 * 查询所有标签元素
	 * @param element
	 * @return
	 * @throws CRUDException
	 */
	public List<Element> findAll(Element element) throws CRUDException {
		try {
			return m.findAll(element);
		}catch (Exception e){
			log.error(e);
			throw new CRUDException(e);
		}
	}
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
	 * @param columns
	 * @throws CRUDException
	 */
	public void saveTagElements(Columns columns) throws CRUDException {
		m.deleteColumnElements(columns.getId());
		if(CollectionUtils.isNotEmpty(columns.getColumnElements()))
			for(ColumnElement columnElement : columns.getColumnElements()){
				columnElement.preInsert();
				columnElement.setColumnId(columns.getId());
				m.saveColumnElements(columnElement);
			}
		else{
			//如果没有手动配置标签属性，则引用标签必填项属性
			Element query = new Element();
			query.setTagId(columns.getPlugin());
			query.setRequired(ConstantsUtil.get().DICT_YES_PARENT_ID);
			List<Element> requireElements = m.findAll(query);
			ColumnElement save = null;
			for (Element element : requireElements){
				save = new ColumnElement();
				save.preInsert();
				save.setColumnId(columns.getId());
				save.setElementId(element.getId());
				save.setElementValue(element.getDefaultVal());
				m.saveColumnElements(save);
			}
		}
	}

}