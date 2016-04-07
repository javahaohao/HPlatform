package com.hplatform.core.entity;

import java.util.Date;

public class Mail extends BaseEntity<Mail>{

	private static final long serialVersionUID = 1L;
	private MailUser mailUser;
	private String subject;
	private Date sentdate;
	private String replysign;
	private String hasRead;
	private String containAttachment;
	private String form;
	private String to;
	private String cc;//抄送
	private String bc;//暗送
	private String messageid;
	private String content;
	private String contentype;
	private String attachmentIds;
	
	public String getAttachmentIds() {
		return attachmentIds;
	}
	public void setAttachmentIds(String attachmentIds) {
		this.attachmentIds = attachmentIds;
	}
	public String getCc() {
		return cc;
	}
	public void setCc(String cc) {
		this.cc = cc;
	}
	public String getBc() {
		return bc;
	}
	public void setBc(String bc) {
		this.bc = bc;
	}
	public MailUser getMailUser() {
		return mailUser;
	}
	public void setMailUser(MailUser mailUser) {
		this.mailUser = mailUser;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public Date getSentdate() {
		return sentdate;
	}
	public void setSentdate(Date sentdate) {
		this.sentdate = sentdate;
	}
	public String getReplysign() {
		return replysign;
	}
	public void setReplysign(String replysign) {
		this.replysign = replysign;
	}
	public String getHasRead() {
		return hasRead;
	}
	public void setHasRead(String hasRead) {
		this.hasRead = hasRead;
	}
	public String getContainAttachment() {
		return containAttachment;
	}
	public void setContainAttachment(String containAttachment) {
		this.containAttachment = containAttachment;
	}
	public String getForm() {
		return form;
	}
	public void setForm(String form) {
		this.form = form;
	}
	public String getTo() {
		return to;
	}
	public void setTo(String to) {
		this.to = to;
	}
	public String getMessageid() {
		return messageid;
	}
	public void setMessageid(String messageid) {
		this.messageid = messageid;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getContentype() {
		return contentype;
	}
	public void setContentype(String contentype) {
		this.contentype = contentype;
	}
	
}
