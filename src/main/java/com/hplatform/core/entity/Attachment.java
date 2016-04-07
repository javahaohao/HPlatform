package com.hplatform.core.entity;

import java.io.File;
import java.util.Date;


public class Attachment extends BaseEntity<Attachment>{
	
	private static final long serialVersionUID = -8261513525798087125L;
	
	//附件标题
	private String title;

    //附件存放路径（例如：C:\Program Files\Java\jre6\Welcom.html）
    private String path;
    
    //附件扩展类型
	private String ext;
	
	//关联表的id(来自多个表)
	private String superId;
	
	//真实文件名
	private String realName;
	
	//上传文件大小
	private Long size;
	
	//上传文件大小
	private Long chunkSize;

	//mime类型
	private String type;

	//文件sha1值，用于判断文件相等
	private String sha1;
	//文件md5值
	private String md5;
	
	//webuploader-start
	private int chunkIndex;
    private String userId="hao";
    private int chunks;
    private int chunk;
    private Date lastModifiedDate;
	public int getChunkIndex() {
		return chunkIndex;
	}

	public void setChunkIndex(int chunkIndex) {
		this.chunkIndex = chunkIndex;
	}

	public String getUserId() {
		return userId;
	}

	public int getChunks() {
		return chunks;
	}

	public void setChunks(int chunks) {
		this.chunks = chunks;
	}

	public int getChunk() {
		return chunk;
	}

	public void setChunk(int chunk) {
		this.chunk = chunk;
	}

	public Date getLastModifiedDate() {
		return lastModifiedDate;
	}

	public void setLastModifiedDate(Date lastModifiedDate) {
		this.lastModifiedDate = lastModifiedDate;
	}

	public String getExt() {
		return ext;
	}

	public void setExt(String ext) {
		this.ext = ext;
	}
	//webuploader-end
	
	
	public Long getChunkSize() {
		return chunkSize;
	}

	public void setChunkSize(Long chunkSize) {
		this.chunkSize = chunkSize;
	}

	public String getFileFullPath(){
		return String.format("%s%s", new Object[]{getPath(),getRealName()});
	}
	
	public Long getSize() {
		return size;
	}

	public void setSize(Long size) {
		this.size = size;
	}

	public String getSha1() {
		return sha1;
	}

	public void setSha1(String sha1) {
		this.sha1 = sha1;
	}

	public String getRealName() {
		return realName;
	}

	public void setRealName(String realName) {
		this.realName = realName;
	}


	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getPath() {
		return path;
	}
	public File getFile(){
		return new File(this.path+this.realName);
	}
	public void setPath(String path) {
		this.path = path;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getSuperId() {
		return superId;
	}

	public void setSuperId(String superId) {
		this.superId = superId;
	}

	public String getMd5() {
		return md5;
	}

	public void setMd5(String md5) {
		this.md5 = md5;
	}
}
