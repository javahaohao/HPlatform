package com.hplatform.core.common.filter;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

import org.apache.shiro.web.filter.PathMatchingFilter;

import cn.org.rapid_framework.util.ObjectUtils;

import com.hplatform.core.common.util.UserUtil;
import com.hplatform.core.constants.Constants;
import com.hplatform.core.entity.Principal;

public class SysUserFilter extends PathMatchingFilter {

    @Override
    protected boolean onPreHandle(ServletRequest request, ServletResponse response, Object mappedValue) throws Exception {

    	Principal principal = UserUtil.getCurrentPrincipal();
    	if(ObjectUtils.isNotEmpty(principal))
    		request.setAttribute(Constants.CURRENT_USER, principal.getUser());
        return true;
    }
}
