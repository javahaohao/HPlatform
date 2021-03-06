package com.hplatform.core.entity;

import java.util.ArrayList;
import java.util.List;

import cn.org.rapid_framework.util.ObjectUtils;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang3.StringUtils;

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
	private String tableAlias;//别名
	private String foreignKey;//外键
	private Boolean genFlag;//是否生成
	private String labelName;//被选择时label显示字段
	private ArrayList<Columns> columnList;
	private List<Tags> tagList;

	private Integer step;

	private String genType;
	
	//父表
	private Table parent;
	//子表
	private List<Table> childs;
	private RelationType relationType;
	
	public static enum RelationType{
		one("单表","one", true),one_2_one("一对一","one_2_one", true),one_2_more("一对多","one_2_more", true),more_2_one("多对一","more_2_one", false);
		private final String info;
		private final String value;
		private final boolean show;
        private RelationType(String info, String value, boolean show) {
            this.info = info;
            this.value = value;
			this.show = show;
		}

        public String getInfo() {
            return info;
        }

		public String getValue() {
			return value;
		}

		public boolean isShow() {
			return show;
		}
	}
	
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
	public ArrayList<Columns> getColumnList() {
		return columnList;
	}
	public void setColumnList(ArrayList<Columns> columnList) {
		this.columnList = columnList;
	}
	/**
	 * 获取用斜线分开的包路径
	 * @return
	 */
	public String getSplitPkg(){
		return getPkg().replace(".","/");
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
	public Table getParent() {
		return parent;
	}
	public void setParent(Table parent) {
		this.parent = parent;
	}
	public List<Table> getChilds() {
		return childs;
	}
	public void setChilds(List<Table> childs) {
		this.childs = childs;
	}
	public RelationType getRelationType() {
		return relationType;
	}
	public void setRelationType(RelationType relationType) {
		this.relationType = relationType;
	}
	public Boolean getGenFlag() {
		return genFlag;
	}
	public void setGenFlag(Boolean genFlag) {
		this.genFlag = genFlag;
	}
	public String getTableAlias() {
		return tableAlias;
	}
	public void setTableAlias(String tableAlias) {
		this.tableAlias = tableAlias;
	}
	public String getForeignKey() {
		return foreignKey;
	}
	public void setForeignKey(String foreignKey) {
		this.foreignKey = foreignKey;
	}
	public String getLabelName() {
		return labelName;
	}
	public void setLabelName(String labelName) {
		this.labelName = labelName;
	}

	public Integer getStep() {
		return step;
	}

	public void setStep(Integer step) {
		this.step = step;
	}

	public String getGenType() {
		return genType;
	}

	public void setGenType(String genType) {
		this.genType = genType;
	}

	/**
	 * 获取数据库字段对应的java属性名
	 * @param column
	 * @return
	 */
	public String getJavaColumnName(String column){
		if(StringUtils.isNotBlank(column)){
			for(Columns c : getColumnList()){
				if(column.equals(c.getColumnName()))
					return c.getPropertiesName();
			}
		}
		return column;
	}
	/**
	 * 获取显示字段的java字段名
	 * @return
	 */
	public String getJavaLableName(){
		return getJavaColumnName(labelName);
	}
	public String getJavaForeignKey(){
		if(ObjectUtils.isNotEmpty(parent))
			return getJavaColumnName(parent.getForeignKey());
		else
			return null;
	}

	/**
	 * 增加子类
	 * @param table
	 */
	public void addChilds(Table table){
		if(CollectionUtils.isEmpty(childs))
			childs = new ArrayList<Table>();
		childs.add(table);
	}
}
