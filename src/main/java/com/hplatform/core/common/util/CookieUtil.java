package com.hplatform.core.common.util;

import javax.servlet.http.Cookie;

public class CookieUtil {

	public static void addCookie(String name, String value,int time) {
		Cookie cookies = new Cookie(name, value);
		cookies.setPath("/");
//		cookies.setMaxAge(-1);//设置cookie经过多长秒后被删除。如果0，就说明立即删除。如果是负数就表明当浏览器关闭时自动删除。
		cookies.setMaxAge(time);
		UserUtil.getCurrentResponse().addCookie(cookies);
	}
	public static String getCookieValue(String cookieName) {
		if (cookieName != null) {
        	Cookie cookie = getCookie(cookieName);
        	if(cookie!=null){
        		return cookie.getValue();
        	}
        }
		return "";
	}
	
	public static Cookie getCookie(String cookieName){
		Cookie[] cookies = UserUtil.getCurrentRequest().getCookies();
		Cookie cookie = null;
		try {
			if (cookies != null && cookies.length > 0) {
				for (int i = 0; i < cookies.length; i++) {
					cookie = cookies[i];
					if (cookie.getName().equals(cookieName)) {
						return cookie;
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return cookie;
	}
	
	public static boolean deleteCookie(String cookieName) {
        if (cookieName != null) {
        	Cookie cookie = getCookie(cookieName);
        	if(cookie!=null){
        		cookie.setMaxAge(0);//如果0，就说明立即删除
                cookie.setPath("/");//不要漏掉
                UserUtil.getCurrentResponse().addCookie(cookie);
        		return true;
        	}
        }
        return false;
    }
	public static void main(String[] args){
//		CookieUtil util=new CookieUtil(request,response,-1);
//		util.addCookie("name","value");
//		String value=util.getCookieValue("name");
//		System.out.println("value="+value);
	}
}


