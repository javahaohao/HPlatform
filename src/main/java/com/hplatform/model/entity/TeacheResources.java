package com.hplatform.model.entity;

import com.hplatform.core.entity.BaseEntity;

public class TeacheResources extends BaseEntity<TeacheResources>{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String frontCover;
	private String title;
	private String classify;
	private String checkup;
	private String status;
	private int browsers;
	private int collect;
	private String summary;
	private String resources;
	private String description;
	public void setFrontCover(String frontCover){
		this.frontCover=frontCover;
	}
	public String getFrontCover(){
		return this.frontCover;
	}
	public void setTitle(String title){
		this.title=title;
	}
	public String getTitle(){
		return this.title;
	}
	public void setClassify(String classify){
		this.classify=classify;
	}
	public String getClassify(){
		return this.classify;
	}
	public void setCheckup(String checkup){
		this.checkup=checkup;
	}
	public String getCheckup(){
		return this.checkup;
	}
	public void setStatus(String status){
		this.status=status;
	}
	public String getStatus(){
		return this.status;
	}
	public void setBrowsers(int browsers){
		this.browsers=browsers;
	}
	public int getBrowsers(){
		return this.browsers;
	}
	public void setCollect(int collect){
		this.collect=collect;
	}
	public int getCollect(){
		return this.collect;
	}
	public void setSummary(String summary){
		this.summary=summary;
	}
	public String getSummary(){
		return this.summary;
	}
	public void setResources(String resources){
		this.resources=resources;
	}
	public String getResources(){
		return this.resources;
	}
	public void setDescription(String description){
		this.description=description;
	}
	public String getDescription(){
		return this.description;
	}
}