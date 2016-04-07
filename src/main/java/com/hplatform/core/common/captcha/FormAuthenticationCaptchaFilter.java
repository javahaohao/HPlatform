package com.hplatform.core.common.captcha;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.web.filter.authc.FormAuthenticationFilter;
import org.apache.shiro.web.util.WebUtils;

/**
 *
 * @author <a href="http://www.micmiu.com">Michael Sun</a>
 */
public class FormAuthenticationCaptchaFilter extends FormAuthenticationFilter {

	private String captchaParam;

	public void setCaptchaParam(String captchaParam) {
		this.captchaParam = captchaParam;
	}

	public String getCaptchaParam() {
		return captchaParam;
	}

	protected String getCaptcha(ServletRequest request) {

		return WebUtils.getCleanParam(request, getCaptchaParam());

	}

	@Override
	protected boolean executeLogin(ServletRequest request, ServletResponse response)
			throws Exception {
		UsernamePasswordCaptchaToken captchaToken = (UsernamePasswordCaptchaToken) createToken(request, response);
		try {
			doCaptchaValidate(captchaToken);
			return super.executeLogin(request, response);  
		}catch (AuthenticationException e) {  
	        return onLoginFailure(captchaToken, e, request, response);  
	    } 
	}
	// 验证码校验  
    protected void doCaptchaValidate(UsernamePasswordCaptchaToken token) {  
    	//session中的图形码字符串  
    	String captcha = (String) SecurityUtils.getSubject().getSession()
				.getAttribute(CaptchaServlet.KEY_CAPTCHA);
        //比对  
    	if (null == captcha || !captcha.equalsIgnoreCase(token.getCaptcha())) {
			throw new CaptchaException("验证码错误");
		}
    } 
	protected AuthenticationToken createToken(

	ServletRequest request, ServletResponse response) {

		String username = getUsername(request);

		String password = getPassword(request);

		String captcha = getCaptcha(request);

		boolean rememberMe = isRememberMe(request);

		String host = getHost(request);

		return new UsernamePasswordCaptchaToken(username,
				password.toCharArray(), rememberMe, host, captcha);

	}

}