package com.hplatform.core.entity;

import java.util.Date;
import java.util.List;

public class News extends BaseEntity<News>{

	private static final long serialVersionUID = 1L;

	private String title;
	private String summary;
	private String content;
	private String newsType;
	private Integer clicks;
	private String source;
	private Boolean top;
	private Boolean hightlight;
	private Boolean checkup;
	private String checkOpinion;
	private Date checkDate;
	private String checkUser;
	private List<Comment> commentList;
	
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getSummary() {
		return summary;
	}
	public void setSummary(String summary) {
		this.summary = summary;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getNewsType() {
		return newsType;
	}
	public void setNewsType(String newsType) {
		this.newsType = newsType;
	}
	public Integer getClicks() {
		return clicks;
	}
	public void setClicks(Integer clicks) {
		this.clicks = clicks;
	}
	public String getSource() {
		return source;
	}
	public void setSource(String source) {
		this.source = source;
	}
	public Boolean getTop() {
		return top;
	}
	public void setTop(Boolean top) {
		this.top = top;
	}
	public Boolean getHightlight() {
		return hightlight;
	}
	public void setHightlight(Boolean hightlight) {
		this.hightlight = hightlight;
	}
	public Boolean getCheckup() {
		return checkup;
	}
	public void setCheckup(Boolean checkup) {
		this.checkup = checkup;
	}
	public String getCheckOpinion() {
		return checkOpinion;
	}
	public void setCheckOpinion(String checkOpinion) {
		this.checkOpinion = checkOpinion;
	}
	public Date getCheckDate() {
		return checkDate;
	}
	public void setCheckDate(Date checkDate) {
		this.checkDate = checkDate;
	}
	public String getCheckUser() {
		return checkUser;
	}
	public void setCheckUser(String checkUser) {
		this.checkUser = checkUser;
	}
	public List<Comment> getCommentList() {
		return commentList;
	}
	public void setCommentList(List<Comment> commentList) {
		this.commentList = commentList;
	}
}
