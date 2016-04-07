package com.hplatform.core.entity;

import java.util.List;

public class Table extends BaseEntity<Table>{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String bumodel;
	private String pkg;
	private String domainName;
	private String statu;
	private String comments;
	private String tableName;
	private String fgType;//风格
	private List<Columns> columnList;
	private List<Tags> tagList;
	public Table(){}
	public Table(String id){this.id=id;}
	
	
	public String getFgType() {
		return fgType;
	}
	public void setFgType(String fgType) {
		this.fgType = fgType;
	}
	public List<Tags> getTagList() {
		return tagList;
	}
	public void setTagList(List<Tags> tagList) {
		this.tagList = tagList;
	}
	public String getBumodel() {
		return bumodel;
	}
	public void setBumodel(String bumodel) {
		this.bumodel = bumodel;
	}
	public List<Columns> getColumnList() {
		return columnList;
	}
	public void setColumnList(List<Columns> columnList) {
		this.columnList = columnList;
	}
	public String getPkg() {
		return pkg;
	}
	public void setPkg(String pkg) {
		this.pkg = pkg;
	}
	public String getDomainName() {
		return domainName;
	}
	public void setDomainName(String domainName) {
		this.domainName = domainName;
	}
	public String getStatu() {
		return statu;
	}
	public void setStatu(String statu) {
		this.statu = statu;
	}
	public String getComments() {
		return comments;
	}
	public void setComments(String comments) {
		this.comments = comments;
	}
	public String getTableName() {
		return tableName;
	}
	public void setTableName(String tableName) {
		this.tableName = tableName;
	}
}
