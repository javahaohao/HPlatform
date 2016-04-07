package com.hplatform.core.common.filter;

import java.io.IOException;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

import org.apache.shiro.web.filter.authc.AnonymousFilter;

public class AnonFilter extends AnonymousFilter {

	@Override
	public void doFilterInternal(ServletRequest request,
			ServletResponse response, FilterChain chain)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		super.doFilterInternal(request, response, chain);
	}

	@Override
	protected boolean onPreHandle(ServletRequest request,
			ServletResponse response, Object mappedValue) {
		// TODO Auto-generated method stub
		return super.onPreHandle(request, response, mappedValue);
	}

	@Override
	protected void executeChain(ServletRequest request,
			ServletResponse response, FilterChain chain) throws Exception {
		// TODO Auto-generated method stub
		super.executeChain(request, response, chain);
	}

	@Override
	public void afterCompletion(ServletRequest request,
			ServletResponse response, Exception exception) throws Exception {
		// TODO Auto-generated method stub
		super.afterCompletion(request, response, exception);
	}
	
}
