package com.hplatform.core.entity;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.SecurityUtils;

import com.fasterxml.jackson.annotation.JsonIgnore;

/**
 * 授权用户信息
 */
public class Principal extends BaseEntity<Principal> {

	private static final long serialVersionUID = 1L;
	
	private User user;
	private boolean mobileLogin;
	
	private Map<String, Object> cacheMap;
	
	private HttpServletResponse response;
	

	public HttpServletResponse getResponse() {
		return response;
	}

	public void setResponse(HttpServletResponse response) {
		this.response = response;
	}
	public Principal(){}
	public Principal(User user, boolean mobileLogin) {
		this.user = user;
		this.mobileLogin = mobileLogin;
	}

	public User getUser() {
		return user;
	}


	public boolean isMobileLogin() {
		return mobileLogin;
	}

	@JsonIgnore
	public Map<String, Object> getCacheMap() {
		if (cacheMap==null){
			cacheMap = new HashMap<String, Object>();
		}
		return cacheMap;
	}
	/**
	 * 从当前用户凭证中按照key获取缓存数据
	 * @param key
	 * @param clz
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public <T> T getValueFromCacheMap(String key,Class<T> clz){
		Map<String, Object> cacheMap = getCacheMap();
		return (T)cacheMap.get(key);
	}
	/**
	 * 往当前用户凭证缓存中放入数据
	 * @param key
	 * @param value
	 */
	public void putInCacheMap(String key,Object value){
		getCacheMap().put(key, value);
	}

	/**
	 * 获取SESSIONID
	 */
	public String getSessionid() {
		try{
			return (String) SecurityUtils.getSubject().getSession().getId();
		}catch (Exception e) {
			return "";
		}
	}

}
