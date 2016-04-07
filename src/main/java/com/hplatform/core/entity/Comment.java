package com.hplatform.core.entity;


public class Comment extends BaseEntity<Comment>{

	private static final long serialVersionUID = 1L;
	
	private String supperId;
	private String supperid;
	private String content;
	private String parentId;
    private String parentIds; //回复路径
    private User user;
	public String getSupperId() {
		return supperId;
	}
	public void setSupperId(String supperId) {
		this.supperId = supperId;
	}
	public String getSupperid() {
		return supperid;
	}
	public void setSupperid(String supperid) {
		this.supperid = supperid;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
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
	public String getSelfPath(){
    	return makeSelfAsParentIds();
    }
    
    public String makeSelfAsParentIds() {
        return getParentIds() + getId() + "/";
    }
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
}
