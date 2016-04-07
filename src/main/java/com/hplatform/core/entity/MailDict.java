package com.hplatform.core.entity;


public class MailDict extends BaseEntity<MailDict> {

	private static final long serialVersionUID = 1L;
	
	private String type;
	private String smtp;
	private int smtpPort;
	private String pop3;
	private int pop3Port;
	private String imap;
	private int imapPort;
	
	
	public String getImap() {
		return imap;
	}
	public void setImap(String imap) {
		this.imap = imap;
	}
	public int getImapPort() {
		return imapPort;
	}
	public void setImapPort(int imapPort) {
		this.imapPort = imapPort;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getSmtp() {
		return smtp;
	}
	public void setSmtp(String smtp) {
		this.smtp = smtp;
	}
	public int getSmtpPort() {
		return smtpPort;
	}
	public void setSmtpPort(int smtpPort) {
		this.smtpPort = smtpPort;
	}
	public String getPop3() {
		return pop3;
	}
	public void setPop3(String pop3) {
		this.pop3 = pop3;
	}
	public int getPop3Port() {
		return pop3Port;
	}
	public void setPop3Port(int pop3Port) {
		this.pop3Port = pop3Port;
	}
}
