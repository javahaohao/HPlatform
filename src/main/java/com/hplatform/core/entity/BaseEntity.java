package com.hplatform.core.entity;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import cn.org.rapid_framework.util.ObjectUtils;

import com.hplatform.core.common.util.IDUtil;
import com.hplatform.core.common.util.UserUtil;
import com.hplatform.core.web.taglib.Functions;

public class BaseEntity<T> implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	protected String id;
	
	protected String name;//名称

	protected String code;//编码
	
	protected int sequence;//排序

	protected Date createDate;//创建时间

	protected Date updateDate;//创建时间
	
	protected String createUser;//创建人帐号ID
	protected String createUserName;//创建人帐号Name
	
	protected String updateUser;//修改人帐号
	protected String updateUserName;//修改人帐号Name

	protected String deleteFlag;//删除标志 
	
	protected String useAble;//是否可用

	/**
	 * 将本身copy一份
	 */
	public void copySelf(){
		preInsert();
	}
	/**
	 * 插入前初始方法
	 */
	public void preInsert(){
		this.id = IDUtil.createUUID();
		this.createUser = UserUtil.getCurrentUserId();
		this.createDate = new Date();
	}
	/**
	 * 修改前的初始方法
	 */
	public void preUpdate(){
		this.updateUser = UserUtil.getCurrentUserId();
		this.updateDate = new Date();
	}
	
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public int getSequence() {
		return sequence;
	}

	public void setSequence(int sequence) {
		this.sequence = sequence;
	}

	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public Date getUpdateDate() {
		return updateDate;
	}

	public void setUpdateDate(Date updateDate) {
		this.updateDate = updateDate;
	}

	public String getCreateUser() {
		return createUser;
	}

	public void setCreateUser(String createUser) {
		this.createUser = createUser;
	}

	public String getUpdateUser() {
		return updateUser;
	}

	public void setUpdateUser(String updateUser) {
		this.updateUser = updateUser;
	}

	public String getDeleteFlag() {
		return deleteFlag;
	}

	public void setDeleteFlag(String deleteFlag) {
		this.deleteFlag = deleteFlag;
	}

	public String getUseAble() {
		return useAble;
	}

	public void setUseAble(String useAble) {
		this.useAble = useAble;
	}

	public List<String> getIdList() {
		return idList;
	}

	public void setIdList(List<String> idList) {
		this.idList = idList;
	}

	protected List<String> idList;

	public String getCreateUserName() {
		User user = Functions.getUserById(this.getCreateUser());
		if(ObjectUtils.isNotEmpty(user))
			return user.getUsername();
		else
			return "";
	}
	public String getUpdateUserName() {
		User user = Functions.getUserById(this.getUpdateUser());
		if(ObjectUtils.isNotEmpty(user))
			return user.getUsername();
		else
			return "";
	}
}
