package com.hplatform.core.constants;

import com.hplatform.core.common.util.ConstantsUtil;
import com.hplatform.core.common.util.SpringUtils;
import com.hplatform.core.common.util.StringUtils;
import com.hplatform.core.entity.ColumnElement;
import com.hplatform.core.entity.Columns;
import com.hplatform.core.entity.Element;
import com.hplatform.core.exception.CRUDException;
import com.hplatform.core.service.ElementService;

import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;

public class ColumnsConstants {
	public static final String LIST = "core/columns/columnslist";
	public static final String EDIT = "core/columns/columnsedit";

	//INFOMATION_SCHEMA表的column_key类型
	//主键
	public static final String COLUMN_KEYS_PRI="PRI";
	//唯一
	public static final String COLUMN_KEYS_UNI="UNI";
	//可以重复
	public static final String COLUMN_KEYS_MUL="MUL";
	//外键
	public static final String COLUMN_KEYS_FK="FK";
	//input类型
	public static final String TAG_TYPE_INPUT="input";

	//默认生成列
	public static final List<String> dcs = new ArrayList<String>();
	public static final List<Columns> defaultsColumns = new LinkedList<Columns>(){
		{
			add(getColumn("id","CHAR",32,"主键id",COLUMN_KEYS_PRI,TagsConstants.DEFAULT_HIDDEN_TAGS_MVCHIDDEN));
			add(getColumn("create_user","char",32,"创建人",null,TagsConstants.DEFAULT_INPUT_TAGS));
			add(getColumn("create_date","datetime",null,"创建时间",null,TagsConstants.DEFAULT_INPUT_TAGS));
			add(getColumn("update_user","char",32,"修改人",null,TagsConstants.DEFAULT_INPUT_TAGS));
			add(getColumn("update_date","datetime",null,"修改时间",null,TagsConstants.DEFAULT_INPUT_TAGS));
			dcs.add("id");
			dcs.add("create_user");
			dcs.add("create_date");
			dcs.add("update_user");
			dcs.add("update_date");
		}
	};

	/**
	 * 获取默认字段配置
	 * @param name
	 * @param type
	 * @param length
	 * @param comments
	 * @param key
	 * @param plugin
	 * @return
	 */
	public static Columns getColumn(String name,String type,Integer length,String comments,String key,String plugin){
		Columns columns = new Columns();
		columns.setColumnName(name);
		if(null!=length)
			columns.setColumnType(String.format("%s(%s)",type,length));
		else
			columns.setColumnType(type);
		columns.setColumnLength(length);
		columns.setColumnKey(key);
		columns.setDataType(type);
		columns.setPlugin(plugin);
		columns.setPropertiesName(StringUtils.getHumpStr(columns.getColumnName()));
		columns.setPropertiesType(ConstantsUtil.get().getMysqlDataType(columns.getDataType()));
		columns.setComments(comments);
		columns.setNullAble(COLUMN_KEYS_PRI.equals(key)?ConstantsUtil.get().NO:ConstantsUtil.get().YES);
		columns.setGenFlag(true);
		columns.setHideFlag(COLUMN_KEYS_PRI.equals(key)?true:false);
		columns.setSortFlag(true);
		columns.setColumnElements(getPluginElements(plugin));
		return columns;
	}

	/**
	 * 按照字段列插件id获取必填属性配置
	 * @param plugin
	 * @return
	 */
	public static List<ColumnElement> getPluginElements(String plugin){
		List<ColumnElement> columnElementList = new ArrayList<ColumnElement>();
		//如果没有手动配置标签属性，则引用标签必填项属性
		Element query = new Element();
		query.setTagId(plugin);
		query.setRequired(ConstantsUtil.get().DICT_YES_PARENT_ID);
		List<Element> requireElements = null;
		try {
			requireElements = SpringUtils.getBean(ElementService.class).findAll(query);
		} catch (CRUDException e) {
			e.printStackTrace();
		}
		ColumnElement save = null;
		for (Element element : requireElements){
			save = new ColumnElement();
			save.setElementId(element.getId());
			save.setElementValue(element.getDefaultVal());
			columnElementList.add(save);
		}
		return columnElementList;
	}
}
