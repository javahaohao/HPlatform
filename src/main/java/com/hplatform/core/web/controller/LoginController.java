package com.hplatform.core.web.controller;

import java.util.concurrent.atomic.AtomicInteger;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.authc.ExcessiveAttemptsException;
import org.apache.shiro.authc.IncorrectCredentialsException;
import org.apache.shiro.authc.LockedAccountException;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.cache.Cache;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.hplatform.core.common.cache.SpringCacheManagerWrapper;
import com.hplatform.core.common.captcha.CaptchaException;
import com.hplatform.core.common.util.ConstantsUtil;
import com.hplatform.core.common.util.SpringUtils;
import com.hplatform.core.common.util.UserUtil;
import com.hplatform.core.constants.Constants;
import com.hplatform.core.exception.ActivationAccountException;
import com.hplatform.core.exception.CRUDException;
import com.hplatform.core.service.UserService;

@Controller
public class LoginController extends BaseController {
	@Autowired
	private UserService userService;
	private Cache<String, AtomicInteger> passwordRetryCache = SpringUtils
			.getBean(SpringCacheManagerWrapper.class).getCache(
					Constants.PASSWORDRETRY_CACHE);

	@RequestMapping(value = "${adminPath}/login")
	public String showLoginForm(HttpServletRequest req, Model model)
			throws CRUDException {
		String exceptionClassName = (String) req
				.getAttribute("shiroLoginFailure");
		String error = null;
		if(StringUtils.isBlank(exceptionClassName)&&UserUtil.isLogin()){
			return getAdminUrlPath("/");
		}
		if (CaptchaException.class.getName().equals(exceptionClassName)) {
			error = "验证码输入有误！";
		} else if (UnknownAccountException.class.getName().equals(exceptionClassName)) {
			error = "用户名/密码错误！";
		} else if (IncorrectCredentialsException.class.getName().equals(
				exceptionClassName)) {
			error = "用户名/密码错误！";
			model.addAttribute(
					"accLoginCount",
					ConstantsUtil.get().RETRY_LOGIN_COUNT
							- passwordRetryCache.get(req.getParameter("username")).get());
		} else if (LockedAccountException.class.getName().equals(
				exceptionClassName)) {
			error = "您得账号已被锁定！请与管理员联系。";
		} else if (ExcessiveAttemptsException.class.getName().equals(
				exceptionClassName)) {
			error = "您的密码5次输入失败！已被锁定。请与管理员联系。";
			userService.lockUser(req.getParameter("username"));
		}else if (ActivationAccountException.class.getName().equals(
				exceptionClassName)) {
			error = "您的账号未激活";
			model.addAttribute("showActivation", true);
		} else if (exceptionClassName != null) {
			error = "其他错误：" + exceptionClassName;
		}
		model.addAttribute("msg", error);
		return "login";
	}

}
