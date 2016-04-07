package com.hplatform.core.entity;

public class Area extends BaseEntity<Area>{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String parentCode;
	private String parentId;
	private String parentIds;
	private int level;
	private String chName;
	private String firstLetter;
	private boolean zxFlag;
	private boolean check;
	
	
	public boolean isCheck() {
		return check;
	}
	public void setCheck(boolean check) {
		this.check = check;
	}
	public boolean isZxFlag() {
		return zxFlag;
	}
	public void setZxFlag(boolean zxFlag) {
		this.zxFlag = zxFlag;
	}
	public String getChName() {
		return chName;
	}
	public void setChName(String chName) {
		this.chName = chName;
	}
	public String getFirstLetter() {
		return firstLetter;
	}
	public void setFirstLetter(String firstLetter) {
		this.firstLetter = firstLetter;
	}
	public String getParentCode() {
		return parentCode;
	}
	public void setParentCode(String parentCode) {
		this.parentCode = parentCode;
	}
	public String getParentId() {
		return parentId;
	}
	public void setParentId(String parentId) {
		this.parentId = parentId;
	}
	public String getParentIds() {
		return parentIds;
	}
	public void setParentIds(String parentIds) {
		this.parentIds = parentIds;
	}
	public int getLevel() {
		return level;
	}
	public void setLevel(int level) {
		this.level = level;
	}
}
