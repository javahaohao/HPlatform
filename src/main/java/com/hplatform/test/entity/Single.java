package com.hplatform.test.entity;

import com.hplatform.core.entity.BaseEntity;

public class Single extends BaseEntity<Single>{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String testOne;
	private int testTwo;
	private java.math.BigDecimal testThree;
	public void setTestOne(String testOne){
		this.testOne=testOne;
	}
	public String getTestOne(){
		return this.testOne;
	}
	public void setTestTwo(int testTwo){
		this.testTwo=testTwo;
	}
	public int getTestTwo(){
		return this.testTwo;
	}
	public void setTestThree(java.math.BigDecimal testThree){
		this.testThree=testThree;
	}
	public java.math.BigDecimal getTestThree(){
		return this.testThree;
	}
}