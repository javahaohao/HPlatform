package com.hplatform.core.common.util;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.mgt.RealmSecurityManager;
import org.apache.shiro.subject.Subject;
import org.sitemesh.webapp.contentfilter.HttpServletRequestFilterable;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import cn.org.rapid_framework.util.ObjectUtils;

import com.hplatform.core.entity.Principal;
import com.hplatform.core.entity.User;
import com.hplatform.core.realm.UserRealm;
import com.hplatform.core.service.UserService;

public class UserUtil {
	private static final transient Log log = LogFactory.getLog(UserUtil.class);
	private static HttpServletRequest currentRequest;
	/**
	 * 获取当前用户凭证
	 * @return
	 */
	@SuppressWarnings("null")
	public static Principal getCurrentPrincipal(){
		Principal principal = null;
		Subject subject = SecurityUtils.getSubject();
		if(subject==null){
			subject.logout();
		}
		return (null == (principal = (Principal)subject.getPrincipal()))?new Principal():principal;
	}
	/**
	 * 获取当前用户的ID
	 * @return
	 */
	public static String getCurrentUserId(){
		Principal principal = getCurrentPrincipal();
		if(principal==null||principal.getUser()==null)
			return null;
		return principal.getUser().getId();
	}
	/**
	 * 获取userRealm实例
	 * @return
	 */
	public static UserRealm getUserRealm(){
		RealmSecurityManager securityManager =  
			      (RealmSecurityManager) SecurityUtils.getSecurityManager();  
	    UserRealm userRealm = (UserRealm)securityManager.getRealms().iterator().next(); 
	    return userRealm;
	}
	/**
	 * 清空当前账号操作缓存
	 */
	public static void clearAuthorizationInfo(){
		getUserRealm().clearCachedAuthorizationInfo(SecurityUtils.getSubject().getPrincipals());
	}
	/**
	 * 清空当前账号身份缓存
	 */
	public static void clearAuthenticationInfo(){
		getUserRealm().clearCachedAuthenticationInfo(SecurityUtils.getSubject().getPrincipals());
	}
	/**
	 * 手动设置当前httpservletrequest
	 */
	public static void setCurrentRequest(HttpServletRequest request){
		currentRequest = request;
	}
	public static HttpServletResponse getCurrentResponse(){
		return getCurrentPrincipal().getResponse();
	}
	/**
	 * 获取当前request
	 * @return
	 */
	public static HttpServletRequest getCurrentRequest(){
		try {
			HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest(); 
			if(request instanceof HttpServletRequestFilterable && ObjectUtils.isNotEmpty(currentRequest))
				return currentRequest;
			return request;
		} catch (Exception e) {
			return null;
		}
	}
	/**
	 * 从当前Request对象中按照key获取参数值
	 * @param key
	 * @return
	 */
	public static String getParamFromRequest(String key){
		HttpServletRequest request = getCurrentRequest();
		String result = request.getParameter(key);
		if(StringUtils.isNotBlank(result))
			return result;
		else
			return "";
	}
	/**
	 * 获取管理员账户
	 * @return
	 */
	public static User getAdmin(){
		User user = new User();
		user.setId(ConstantsUtil.get().ADMIN_ID);
		try {
			user = SpringUtils.getBean(UserService.class).findOne(user);
		} catch (Exception e) {
			log.error("获取admin账号失败！", e);
		}
		return user;
	}
	/**
	 * 判断当前用户是否是教员
	 * @return
	 */
	public static boolean isTeacher(){
		if(SecurityUtils.getSubject().hasRole(ConstantsUtil.get().ROLE_REGISTER_TEACHER_ROLE)){
			return true;
		}else{
			return false;
		}
	}
	/**
	 * 判断当前用户是否是学员
	 * @return
	 */
	public static boolean isStudent(){
		if(SecurityUtils.getSubject().hasRole(ConstantsUtil.get().ROLE_REGISTER_STUDENT_ROLE)){
			return true;
		}else{
			return false;
		}
	}
}
