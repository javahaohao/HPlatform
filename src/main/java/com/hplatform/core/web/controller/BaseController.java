package com.hplatform.core.web.controller;

import com.hplatform.core.common.formbindconvert.DateConvertPropertyEditor;
import com.hplatform.core.common.util.PropertiesUtil;
import org.springframework.web.bind.ServletRequestDataBinder;
import org.springframework.web.bind.annotation.InitBinder;

import javax.servlet.http.HttpServletRequest;
import java.util.Date;

public abstract class BaseController {
	@InitBinder
    protected void initBinder(HttpServletRequest request, ServletRequestDataBinder binder) throws Exception {
		binder.registerCustomEditor(Date.class, new DateConvertPropertyEditor());
    }
	/**
	 * 获取admin的请求路径
	 * @param path
	 * @return
	 */
	public String getAdminUrlPath(String path){
		return String.format("redirect:%s%s", new Object[]{PropertiesUtil.getAdminPath(),path});
	}
	/**
	 * 获取site的请求路径
	 * @param path
	 * @return
	 */
	public String getSiteUrlPath(String path){
		return String.format("redirect:%s%s", new Object[]{PropertiesUtil.getSitePath(),path});
	}
}
