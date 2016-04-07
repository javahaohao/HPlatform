package com.hplatform.core.entity;

public class MessageGroupUser extends BaseEntity<MessageGroupUser> {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private MessageGroup group;
	private User user;
	private int sequence;
	public MessageGroupUser(){}
	public MessageGroupUser(MessageGroup group,User user){
		this.group = group;
		this.user = user;
	}
	
	public int getSequence() {
		return sequence;
	}
	public void setSequence(int sequence) {
		this.sequence = sequence;
	}
	public MessageGroup getGroup() {
		return group;
	}
	public void setGroup(MessageGroup group) {
		this.group = group;
	}
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
}
