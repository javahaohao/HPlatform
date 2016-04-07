package com.hplatform.core.entity;

import com.hplatform.core.entity.BaseEntity;

public class Element extends BaseEntity<Element>{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String tagId;
	private String elementName;
	private String required;
	private String remark;
	private String description;
	private String defaultVal;
	
	public String getRequired() {
		return required;
	}
	public void setRequired(String required) {
		this.required = required;
	}
	public String getDefaultVal() {
		return defaultVal;
	}
	public void setDefaultVal(String defaultVal) {
		this.defaultVal = defaultVal;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public void setTagId(String tagId){
		this.tagId=tagId;
	}
	public String getTagId(){
		return this.tagId;
	}
	public void setElementName(String elementName){
		this.elementName=elementName;
	}
	public String getElementName(){
		return this.elementName;
	}
	public void setRemark(String remark){
		this.remark=remark;
	}
	public String getRemark(){
		return this.remark;
	}
}