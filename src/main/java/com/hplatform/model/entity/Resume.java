package com.hplatform.model.entity;

import java.math.BigDecimal;

import com.hplatform.core.entity.BaseEntity;

public class Resume extends BaseEntity<Resume> {

	private static final long serialVersionUID = 1L;

	private String userId;//关联人员
	private String teacheStatus;//家教状态
	private String called;//称呼
	private String phone;//联系电话
	private String address;//家教地址
	private String learning;//学习状况
	private String requestSex;//要求性别
	private String requestDiploma;//要求学历
	private String requestExpert;//需要补习科目
	private BigDecimal payroll;//薪资
	private int teacheAge;//教龄
	private String teacheDiploma;//学历
	private String school;//毕业院校
	private String special;//专业
	private String classes;//年级
	private String teacheTime;//教学时间
	private String serviceType;//服务方式
	private String servicePlace;//服务地点
	private String expert;//擅长科目
	private String teacheExperience;//教学经历
	private String introduction;//自我介绍
	private String otherRemark;//其他要求
	
	public Resume(){}
	public Resume(String userId){this.userId=userId;}
	
	public String getTeacheStatus() {
		return teacheStatus;
	}
	public void setTeacheStatus(String teacheStatus) {
		this.teacheStatus = teacheStatus;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getCalled() {
		return called;
	}
	public void setCalled(String called) {
		this.called = called;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getLearning() {
		return learning;
	}
	public void setLearning(String learning) {
		this.learning = learning;
	}
	public String getRequestSex() {
		return requestSex;
	}
	public void setRequestSex(String requestSex) {
		this.requestSex = requestSex;
	}
	public String getRequestDiploma() {
		return requestDiploma;
	}
	public void setRequestDiploma(String requestDiploma) {
		this.requestDiploma = requestDiploma;
	}
	public String getRequestExpert() {
		return requestExpert;
	}
	public void setRequestExpert(String requestExpert) {
		this.requestExpert = requestExpert;
	}
	public String getOtherRemark() {
		return otherRemark;
	}
	public void setOtherRemark(String otherRemark) {
		this.otherRemark = otherRemark;
	}
	public BigDecimal getPayroll() {
		return payroll;
	}
	public void setPayroll(BigDecimal payroll) {
		this.payroll = payroll;
	}
	public int getTeacheAge() {
		return teacheAge;
	}
	public void setTeacheAge(int teacheAge) {
		this.teacheAge = teacheAge;
	}
	public String getTeacheDiploma() {
		return teacheDiploma;
	}
	public void setTeacheDiploma(String teacheDiploma) {
		this.teacheDiploma = teacheDiploma;
	}
	public String getSchool() {
		return school;
	}
	public void setSchool(String school) {
		this.school = school;
	}
	public String getSpecial() {
		return special;
	}
	public void setSpecial(String special) {
		this.special = special;
	}
	public String getClasses() {
		return classes;
	}
	public void setClasses(String classes) {
		this.classes = classes;
	}
	public String getTeacheTime() {
		return teacheTime;
	}
	public void setTeacheTime(String teacheTime) {
		this.teacheTime = teacheTime;
	}
	public String getServiceType() {
		return serviceType;
	}
	public void setServiceType(String serviceType) {
		this.serviceType = serviceType;
	}
	public String getServicePlace() {
		return servicePlace;
	}
	public void setServicePlace(String servicePlace) {
		this.servicePlace = servicePlace;
	}
	public String getExpert() {
		return expert;
	}
	public void setExpert(String expert) {
		this.expert = expert;
	}
	public String getTeacheExperience() {
		return teacheExperience;
	}
	public void setTeacheExperience(String teacheExperience) {
		this.teacheExperience = teacheExperience;
	}
	public String getIntroduction() {
		return introduction;
	}
	public void setIntroduction(String introduction) {
		this.introduction = introduction;
	}
}
