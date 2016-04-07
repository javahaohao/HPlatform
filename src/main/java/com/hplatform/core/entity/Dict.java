package com.hplatform.core.entity;

public class Dict extends BaseEntity<Dict> {

	private static final long serialVersionUID = 1L;
	private String value;
	private String means;
	private String parentId; //父编号
    private String parentIds; //父编号列表
    private Boolean available = Boolean.FALSE;
    
	public String getValue() {
		return value;
	}
	public void setValue(String value) {
		this.value = value;
	}
	public String getMeans() {
		return means;
	}
	public void setMeans(String means) {
		this.means = means;
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
	public Boolean getAvailable() {
		return available;
	}
	public void setAvailable(Boolean available) {
		this.available = available;
	}
	public String getSelfPath(){
    	return makeSelfAsParentIds();
    }
    
    public String makeSelfAsParentIds() {
        return getParentIds() + getId() + "/";
    }
    public boolean isRootNode() {
        return "0".equals(parentId);
    }
}
