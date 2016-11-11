package com.hplatform.test.entity;

import com.hplatform.core.entity.BaseEntity;
import java.util.List;

public class StuInfo extends BaseEntity<StuInfo>{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String clsId;
	private String stuName;
	private int age;
	private String sex;
	private ClassInfo classInfo;
	public void setClsId(String clsId){
		this.clsId=clsId;
	}
	public String getClsId(){
		return this.clsId;
	}
	public void setStuName(String stuName){
		this.stuName=stuName;
	}
	public String getStuName(){
		return this.stuName;
	}
	public void setAge(int age){
		this.age=age;
	}
	public int getAge(){
		return this.age;
	}
	public void setSex(String sex){
		this.sex=sex;
	}
	public String getSex(){
		return this.sex;
	}
	public void setClassInfo(ClassInfo classInfo){
		this.classInfo=classInfo;
	}
	public ClassInfo getClassInfo(){
		return this.classInfo;
	}
}