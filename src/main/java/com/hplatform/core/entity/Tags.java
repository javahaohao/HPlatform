package com.hplatform.core.entity;

import java.util.List;

import com.hplatform.core.entity.BaseEntity;

public class Tags extends BaseEntity<Tags>{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String tagName;
	private String remark;
	private String status;
	private List<Element> elements;
	
	
	public List<Element> getElements() {
		return elements;
	}
	public void setElements(List<Element> elements) {
		this.elements = elements;
	}
	public void setTagName(String tagName){
		this.tagName=tagName;
	}
	public String getTagName(){
		return this.tagName;
	}
	public void setRemark(String remark){
		this.remark=remark;
	}
	public String getRemark(){
		return this.remark;
	}
	public void setStatus(String status){
		this.status=status;
	}
	public String getStatus(){
		return this.status;
	}
}