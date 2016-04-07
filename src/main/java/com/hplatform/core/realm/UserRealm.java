package com.hplatform.core.realm;

import java.util.Date;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.LockedAccountException;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.cache.Cache;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.util.ByteSource;
import org.apache.shiro.util.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;

import com.hplatform.core.common.htmlunit.HtmlUnitUtil;
import com.hplatform.core.common.util.UserUtil;
import com.hplatform.core.entity.Principal;
import com.hplatform.core.entity.User;
import com.hplatform.core.exception.ActivationAccountException;
import com.hplatform.core.exception.CRUDException;
import com.hplatform.core.service.UserService;
import com.hplatform.model.service.ResumeService;

public class UserRealm extends AuthorizingRealm {

	private final transient Log log = LogFactory.getLog(UserRealm.class);
    @Autowired
    private UserService userService;
    @Autowired
    private ResumeService resumeService;

    /**
     * 权限获取
     */
    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {
    	Principal principal = (Principal)principals.getPrimaryPrincipal();

        SimpleAuthorizationInfo authorizationInfo = new SimpleAuthorizationInfo();
        authorizationInfo.setRoles(userService.findRoles(principal.getUser()));
        authorizationInfo.setStringPermissions(userService.findPermissions(principal.getUser()));
        return authorizationInfo;
    }

    /**
     * 身份认证
     */
    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token) throws AuthenticationException {

        String username = (String)token.getPrincipal();

        User user = null;
		try {
			user = userService.findByUsername(username);
		} catch (CRUDException e) {
			log.error("按照用户名验证账号失败！", e);
		}

        if(user == null) {
            throw new UnknownAccountException();//没找到帐号
        }

        if(Boolean.TRUE.equals(user.getLocked())) {
            throw new LockedAccountException(); //帐号锁定
        }
        if(Boolean.FALSE.equals(user.getActivation())) {
        	throw new ActivationAccountException(); //帐号未激活
        }
        
        //交给AuthenticatingRealm使用CredentialsMatcher进行密码匹配，如果觉得人家的不好可以自定义实现
        SimpleAuthenticationInfo authenticationInfo = new SimpleAuthenticationInfo(
                new Principal(user,false), //用户凭证
                user.getPassword(), //密码
                ByteSource.Util.bytes(user.getCredentialsSalt()),//salt=username+salt
                getName()  //realm name
        );
        updateLoginInfo(user);
        return authenticationInfo;
    }
	/**
     * 更新登录信息
     * @throws CRUDException 
     */
    public void updateLoginInfo(User user){
    	try {
			User loginUser = new User();
			loginUser.setId(user.getId());
			loginUser.setLoginIp(HtmlUnitUtil.getIpAddress(UserUtil.getCurrentRequest()));
			loginUser.setLastLogin(new Date());
			userService.updateUser(loginUser);
		} catch (CRUDException e) {
			log.error("更新用户登录信息失败！", e);
		}
    }
    @Override
    public void clearCachedAuthorizationInfo(PrincipalCollection principals) {
        super.clearCachedAuthorizationInfo(principals);
    }

    @Override
    public void clearCachedAuthenticationInfo(PrincipalCollection principals) {
    	if (!CollectionUtils.isEmpty(principals)) {
            Cache<Object, AuthenticationInfo> cache = getAuthenticationCache();
            //cache instance will be non-null if caching is enabled:
            if (cache != null) {
            	Principal key = (Principal)getAuthenticationCacheKey(principals);
                cache.remove(key.getUser().getUsername());
            }
        }
    }

    @Override
    public void clearCache(PrincipalCollection principals) {
        super.clearCache(principals);
    }

    public void clearAllCachedAuthorizationInfo() {
        getAuthorizationCache().clear();
    }

    public void clearAllCachedAuthenticationInfo() {
        getAuthenticationCache().clear();
    }

    public void clearAllCache() {
        clearAllCachedAuthenticationInfo();
        clearAllCachedAuthorizationInfo();
    }

}
