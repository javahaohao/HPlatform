package com.hplatform.core.entity;


public class MailUser extends BaseEntity<MailUser> {

	private static final long serialVersionUID = 1L;
	
	private MailDict mailDict;
	private User user;
	private String mailAccount;
	private String mailPassword;
	private String backupFlag;
	
	public MailUser() {
		
	}
	public String getBackupFlag() {
		return backupFlag;
	}
	public void setBackupFlag(String backupFlag) {
		this.backupFlag = backupFlag;
	}
	public MailDict getMailDict() {
		return mailDict;
	}
	public void setMailDict(MailDict mailDict) {
		this.mailDict = mailDict;
	}
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	public String getMailAccount() {
		return mailAccount;
	}
	public void setMailAccount(String mailAccount) {
		this.mailAccount = mailAccount;
	}
	public String getMailPassword() {
		return mailPassword;
	}
	public void setMailPassword(String mailPassword) {
		this.mailPassword = mailPassword;
	}
	
}
