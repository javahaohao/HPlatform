package com.hplatform.test.entity;

import com.hplatform.core.entity.BaseEntity;
import java.util.List;

public class Member extends BaseEntity<Member>{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String memberName;
	private int age;
	private int height;
	private String sex;
	private MemberInfo memberInfo;
	public void setMemberName(String memberName){
		this.memberName=memberName;
	}
	public String getMemberName(){
		return this.memberName;
	}
	public void setAge(int age){
		this.age=age;
	}
	public int getAge(){
		return this.age;
	}
	public void setHeight(int height){
		this.height=height;
	}
	public int getHeight(){
		return this.height;
	}
	public void setSex(String sex){
		this.sex=sex;
	}
	public String getSex(){
		return this.sex;
	}
	public void setMemberInfo(MemberInfo memberInfo){
		this.memberInfo=memberInfo;
	}
	public MemberInfo getMemberInfo(){
		return this.memberInfo;
	}
}