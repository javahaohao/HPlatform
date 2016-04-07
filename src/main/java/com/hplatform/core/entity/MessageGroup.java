package com.hplatform.core.entity;

public class MessageGroup extends BaseEntity<MessageGroup> {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String group;
	private String pic;
	private String groupRemark;
	private String userIds;
	
	public String getGroupRemark() {
		return groupRemark;
	}
	public void setGroupRemark(String groupRemark) {
		this.groupRemark = groupRemark;
	}
	public String getGroup() {
		return group;
	}
	public void setGroup(String group) {
		this.group = group;
	}
	public String getPic() {
		return pic;
	}
	public void setPic(String pic) {
		this.pic = pic;
	}
	public String getUserIds() {
		return userIds;
	}
	public void setUserIds(String userIds) {
		this.userIds = userIds;
	}
}
