package com.hplatform.core.entity;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.StringUtils;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;


public class Columns extends BaseEntity<Columns>{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String tableId;
	private String tableName;
	private String columnName;
	private String columnType;
	private Integer columnLength;
	private String columnKey;
	private String dataType;
	private String plugin;
	private String propertiesName;
	private String propertiesType;
	private String comments;
	private String nullAble;
	private boolean genFlag;
	private boolean hideFlag;
	private boolean sortFlag;
	private int sequence;
	private List<ColumnElement> columnElements;
	private ArrayList<ColumnValidate> columnValidates;

	public ArrayList<ColumnValidate> getColumnValidates() {
		return columnValidates;
	}
	public void setColumnValidates(ArrayList<ColumnValidate> columnValidates) {
		this.columnValidates = columnValidates;
	}
	public List<ColumnElement> getColumnElements() {
		return columnElements;
	}
	public void setColumnElements(List<ColumnElement> columnElements) {
		this.columnElements = columnElements;
	}
	public boolean getSortFlag() {
		return sortFlag;
	}
	public void setSortFlag(boolean sortFlag) {
		this.sortFlag = sortFlag;
	}
	public String getPlugin() {
		return plugin;
	}
	public void setPlugin(String plugin) {
		this.plugin = plugin;
	}
	public int getSequence() {
		return sequence;
	}
	public void setSequence(int sequence) {
		this.sequence = sequence;
	}
	public boolean getHideFlag() {
		return hideFlag;
	}
	public void setHideFlag(boolean hideFlag) {
		this.hideFlag = hideFlag;
	}
	public boolean getGenFlag() {
		return genFlag;
	}
	public void setGenFlag(boolean genFlag) {
		this.genFlag = genFlag;
	}
	public String getDataType() {
		return dataType;
	}
	public void setDataType(String dataType) {
		this.dataType = dataType;
	}
	public String getTableName() {
		return tableName;
	}
	public void setTableName(String tableName) {
		this.tableName = tableName;
	}
	public String getColumnType() {
		return columnType;
	}
	public void setColumnType(String columnType) {
		this.columnType = columnType;
	}
	public String getTableId() {
		return tableId;
	}
	public void setTableId(String tableId) {
		this.tableId = tableId;
	}
	public String getColumnName() {
		return columnName;
	}
	public void setColumnName(String columnName) {
		this.columnName = columnName;
	}
	public String getPropertiesName() {
		return propertiesName;
	}
	public void setPropertiesName(String propertiesName) {
		this.propertiesName = propertiesName;
	}
	public String getPropertiesType() {
		return propertiesType;
	}
	public void setPropertiesType(String propertiesType) {
		this.propertiesType = propertiesType;
	}
	public String getComments() {
		return comments;
	}
	public void setComments(String comments) {
		this.comments = comments;
	}
	public String getColumnKey() {
		return columnKey;
	}
	public void setColumnKey(String columnKey) {
		this.columnKey = columnKey;
	}
	public Integer getColumnLength() {
		return columnLength;
	}
	public void setColumnLength(Integer columnLength) {
		this.columnLength = columnLength;
	}
	public String getNullAble() {
		return nullAble;
	}
	public void setNullAble(String nullAble) {
		this.nullAble = nullAble;
	}

	/**
	 * 判断当前字段是否是主键
	 * @return
	 */
	public boolean isPk(){
		if(StringUtils.isNotBlank(columnKey))
			return "PRI".equals(columnKey);
		return false;
	}
}