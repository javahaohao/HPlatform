package com.hplatform.test.entity;

import com.hplatform.core.entity.BaseEntity;
import java.util.List;

public class ClassInfo extends BaseEntity<ClassInfo>{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String className;
	private String floor;
	private List<StuInfo> stuInfoList;
	public void setClassName(String className){
		this.className=className;
	}
	public String getClassName(){
		return this.className;
	}
	public void setFloor(String floor){
		this.floor=floor;
	}
	public String getFloor(){
		return this.floor;
	}
	public void setStuInfoList(List<StuInfo> stuInfoList){
		this.stuInfoList=stuInfoList;
	}
	public List<StuInfo> getStuInfoList(){
		return this.stuInfoList;
	}
}