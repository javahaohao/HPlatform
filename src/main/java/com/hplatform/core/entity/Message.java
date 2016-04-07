package com.hplatform.core.entity;

import java.util.ArrayList;
import java.util.List;

import com.hplatform.core.common.util.ConstantsUtil;

public class Message extends BaseEntity<Message> {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private String msg;
	private User sender;
	private User receiver;
	private MessageGroup group;
	private String msgStatus=ConstantsUtil.get().TRUE;
	private String msgType;
	private String event = ConstantsUtil.get().EVENT_TALK;
	private List<Message> msgs = new ArrayList<Message>();
	private List<String> sendIds;
	
	
	public User getSender() {
		return sender;
	}
	public void setSender(User sender) {
		this.sender = sender;
	}
	public User getReceiver() {
		return receiver;
	}
	public void setReceiver(User receiver) {
		this.receiver = receiver;
	}
	public List<Message> getMsgs() {
		return msgs;
	}
	public String getMsgStatus() {
		return msgStatus;
	}
	public void setMsgStatus(String msgStatus) {
		this.msgStatus = msgStatus;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	public String getMsgType() {
		return msgType;
	}
	public void setMsgType(String msgType) {
		this.msgType = msgType;
	}
	public String getEvent() {
		return event;
	}
	public void setEvent(String event) {
		this.event = event;
	}
	public List<String> getSendIds() {
		return sendIds;
	}
	public void setSendIds(List<String> sendIds) {
		this.sendIds = sendIds;
	}
	public MessageGroup getGroup() {
		return group;
	}
	public void setGroup(MessageGroup group) {
		this.group = group;
	}
}
