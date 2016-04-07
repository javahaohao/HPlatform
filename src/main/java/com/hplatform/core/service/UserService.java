package com.hplatform.core.service;

import java.util.Arrays;
import java.util.Collections;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import cn.org.rapid_framework.util.ObjectUtils;

import com.hplatform.core.common.captcha.CaptchaUtil;
import com.hplatform.core.common.mail.MailUtil;
import com.hplatform.core.common.util.CacheUtil;
import com.hplatform.core.common.util.ConstantsUtil;
import com.hplatform.core.common.util.FileUtil;
import com.hplatform.core.common.util.FreeMarkerUtil;
import com.hplatform.core.common.util.IDUtil;
import com.hplatform.core.common.util.PropertiesUtil;
import com.hplatform.core.common.util.UserUtil;
import com.hplatform.core.constants.Constants;
import com.hplatform.core.entity.Attachment;
import com.hplatform.core.entity.User;
import com.hplatform.core.exception.CRUDException;
import com.hplatform.core.mapper.UserMapper;

@Service
public class UserService extends BaseService<User, UserMapper> {

    @Autowired
    private PasswordHelper passwordHelper;
    @Autowired
    private RoleService roleService;
    @Autowired
    private CaptchaUtil captchaUtil;

    /**
     * 创建用户
     * @param user
     * @throws CRUDException 
     */
    @CacheEvict(value={Constants.CACHE_USER_K_V},allEntries=true,beforeInvocation=true)
    public void createUser(User user) throws CRUDException {
        try{
        	//加密密码
            passwordHelper.encryptPassword(user);
            user.preInsert();
            m.addEntity(user);
    	}catch(Exception e){
			log.error(e);
			throw new CRUDException(e);
		}
    }

    @CacheEvict(value={Constants.CACHE_USER_K_V},allEntries=true,beforeInvocation=true)
    public void updateUser(User user) throws CRUDException {
        try{
        	user.preUpdate();
        	if(!StringUtils.isNotBlank(user.getId())){
        		user.setId(UserUtil.getCurrentUserId());
        	}
            m.updateEntity(user);
    	}catch(Exception e){
			log.error(e);
			throw new CRUDException(e);
		}
    }
    /**
     * 修改用户头像
     * @param user
     * @param file
     * @throws CRUDException
     */
    public Attachment updateUserHeaderPic(Attachment attachment,User user,MultipartFile file) throws CRUDException {
        try{
        	attachment = FileUtil.upload(attachment,file);
        	user.setHeadPic(attachment.getId());
        	updateUser(user);
        	return attachment;
    	}catch(Exception e){
			log.error(e);
			throw new CRUDException(e);
		}
    }
    @CacheEvict(value={Constants.CACHE_USER_K_V},allEntries=true,beforeInvocation=true)
    public void deleteUser(User user) throws CRUDException {
    	try{
    		m.deleteEntity(user);
    	}catch(Exception e){
			log.error(e);
			throw new CRUDException(e);
		}
    }
    @CacheEvict(value={Constants.CACHE_USER_K_V},allEntries=true,beforeInvocation=true)
    public void deleteBatchEntity(User user) throws CRUDException {
        try{
        	user.setIdList(Arrays.asList(user.getId().split(",")));
			m.deleteBatchEntity(user);
		}catch(Exception e){
			log.error(e);
			throw new CRUDException(e);
		}
    }
    /**
     * 修改密码
     * @param userId
     * @param newPassword
     * @throws CRUDException 
     */
    @CacheEvict(value={Constants.CACHE_USER_K_V},allEntries=true,beforeInvocation=true)
    public void updatePassword(User user) throws CRUDException {
        try{
        	user.preUpdate();
            passwordHelper.encryptPassword(user);
            m.updatePassword(user);
		}catch(Exception e){
			log.error(e);
			throw new CRUDException(e);
		}
    }

    @Cacheable(value=Constants.CACHE_USER_K_V,key="#user.id")
    public User findOne(User user) throws CRUDException {
        try{
        	return m.findOne(user);
		}catch(Exception e){
			log.error(e);
			throw new CRUDException(e);
		}
    }

    /**
     * 根据用户名查找用户
     * @param username
     * @return
     * @throws CRUDException 
     */
    public User findByUsername(String username) throws CRUDException {
        try{
        	User paramUser = new User();
        	if(username==null||"".equals(username)){
        		return paramUser;
        	}
        	paramUser.setUsername(username);
            return m.findOne(paramUser);
		}catch(Exception e){
			log.error(e);
			throw new CRUDException(e);
		}
    }

    /**
     * 根据用户名查找其角色
     * @param username
     * @return
     */
    @SuppressWarnings("unchecked")
    public Set<String> findRoles(User user) {
        if(user == null) {
            return Collections.EMPTY_SET;
        }
        return roleService.findRoles(user.getRoleIds().toArray(new String[0]));
    }

    /**
     * 根据用户名查找其权限
     * @param username
     * @return
     */
    @SuppressWarnings("unchecked")
	public Set<String> findPermissions(User user) {
        if(user == null) {
            return Collections.EMPTY_SET;
        }
        return roleService.findPermissions(user.getRoleIds().toArray(new String[0]));
    }
    //注册用户代码-start
    /**
     * 注册用户
     * @param user
     * @throws CRUDException
     */
    public void registerUser(User user) throws CRUDException{
    	try{
    		user.setOrganizationId(ConstantsUtil.get().ORGANIZATION_REGISTER_ID);
    		createUser(user);
		}catch(Exception e){
			log.error(e);
			throw new CRUDException(e);
		}
    }
    /**
     * 检测注册用户的信息
     * @param user
     * @return
     * @throws CRUDException 
     */
	public User registerCheckInfo(User user) throws CRUDException {
		try{
    		return m.registerCheckInfo(user);
		}catch(Exception e){
			log.error(e);
			throw new CRUDException(e);
		}
	}
	/**
	 * 将验证码发送到指定邮箱
	 * @param email
	 * @return
	 * @throws CRUDException 
	 */
	public boolean sendRegisterEmailCheckCode(String email) throws CRUDException{
		boolean sendFlag = true;
		try {
			Map<String, String> map = new HashMap<String, String>();
			String code = captchaUtil.getRandomCode();
			map.put("emailCode", code);
			MailUtil.sendRegisterEMailCheckCode(FreeMarkerUtil.getInstance().getHtmlString(ConstantsUtil.get().TEMPLATE_EMAIL_CODE_CHECK, map), email);
			CacheUtil.putGlobalCache(Constants.VERIFIED_CACHE, email, code);
		} catch (Exception e) {
			log.error(e);
			sendFlag = false;
			throw new CRUDException(e);
		}
		return sendFlag;
	}
	/**
	 * 根据传入的Email和code信息验证邮箱信息
	 * @param email
	 * @param checkCode
	 * @return
	 */
	public boolean checkRegisterEmailCode(String email,String checkCode){
		String code = CacheUtil.getGlobalCacheByKey(Constants.VERIFIED_CACHE, email, String.class);
		if(StringUtils.isNotBlank(code)&&StringUtils.isNotBlank(checkCode)&&checkCode.toUpperCase().equals(code)){
			User user = new User();
			user.setActivation(Boolean.TRUE);
			user.setEmail(email);
			try {
				updateActivation(user);
			} catch (CRUDException e) {
				log.error(e);
			}
			return true;
		}else{
			return false;
		}
	}
	/**
	 * 更改账户激活状态
	 * @param user
	 * @throws CRUDException
	 */
	@CacheEvict(value={Constants.CACHE_USER_K_V},allEntries=true,beforeInvocation=true)
	public void updateActivation(User user) throws CRUDException{
		try {
			m.activationUser(user);
		} catch (Exception e) {
			log.error(e);
			throw new CRUDException(e);
		}
	}
	//注册用户-end
	//找回密码-start
	/**
	 * 给当时注册的用户账户邮箱发送重置密码的验证码
	 * @param email
	 * @return
	 * @throws CRUDException 
	 */
	public boolean sendRestPwdEmailCheckCode(String email) throws CRUDException{
		boolean sendFlag = true;
		try {
			User userParam = new User();
			userParam.setUsername(email);
			User user = m.registerCheckInfo(userParam);
			if(ObjectUtils.isNotEmpty(user)){
				String code =IDUtil.createUUID();
				CacheUtil.putGlobalCache(Constants.REST_PWD_CACHE, code,user);
				Map<String, String> map = new HashMap<String, String>();
				map.put("url",String.format("%s/admin/user/register/getUserByEmailCode?code=%s", new Object[]{PropertiesUtil.getProperty("domail_url"),code}));
				MailUtil.sendRegisterEMailCheckCode(FreeMarkerUtil.getInstance().getHtmlString(ConstantsUtil.get().TEMPLATE_RESET_PWD, map), email);
			}else{
				sendFlag = false;
			}
		} catch (Exception e) {
			log.error(e);
			sendFlag = false;
			throw new CRUDException(e);
		}
		return sendFlag;
	}
	/**
	 * 根据邮箱中发送的验证码获取缓存中User对象进行重置密码操作
	 * @param checkCode
	 * @return
	 */
	public User getUserByEmailCode(String checkCode){
		User user = CacheUtil.getGlobalCacheByKey(Constants.REST_PWD_CACHE, checkCode, User.class);
		if(ObjectUtils.isEmpty(user)){
			user = new User();
		}
		return user;
	}
	/**
	 * 验证原始密码输入是否正确
	 * @param user
	 * @return
	 * @throws CRUDException
	 */
	public User confirmOldPwd(User user) throws CRUDException{
		try{
			passwordHelper.encryptPassword(user);
			return m.confirmOldPwd(user);
		}catch(Exception e){
			log.error(e);
			throw new CRUDException(e);
		}
	}
	//找回密码-end
	/**
	 * 按照用户名锁定用户
	 * @throws CRUDException 
	 */
	public void lockUser(String username) throws CRUDException{
		try{
			User user = new User();
			user.setUsername(username);
			user.setLocked(Boolean.TRUE);
			m.lockUser(user);
		}catch(Exception e){
			log.error(e);
			throw new CRUDException(e);
		}
	}
}
