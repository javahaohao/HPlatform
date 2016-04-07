package com.hplatform.core.entity;

import java.util.List;
import java.util.Map;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.google.common.collect.Maps;
import com.hplatform.core.common.util.PropertiesUtil;
import com.hplatform.core.common.util.UserUtil;

public class Page<T> extends PageInfo<T> {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	/**
	 * 其他数据
	 */
	private Map<String, Object> otherData;

	public Page() {
		super();
	}

	public Page(List<T> list) {
		super(list);
	}

	public static void setPageFromRequest() {
		HttpServletRequest request = UserUtil.getCurrentRequest();
		if(request!=null){
			String pageSizeStr = request.getParameter("pageSize");
			pageSizeStr = StringUtils.isBlank(pageSizeStr)?"-1":pageSizeStr;
			Integer pageSize = Integer.valueOf(pageSizeStr);
			if(pageSize!=-1){
				PageHelper.startPage(Integer.valueOf(request.getParameter("pageNum")),
						pageSize,
						checkOrderBy(request.getParameter("orderBy"),request.getParameter("sord")));
			}else{
				PageHelper.startPage(1, Integer.valueOf(PropertiesUtil.getProperty("page_size")));
			}
		}else{
			PageHelper.startPage(1,Integer.valueOf(PropertiesUtil.getProperty("page_size")));
		}
	}

	public Map<String, Object> getOtherData() {
		return otherData;
	}

	public void setOtherData(Map<String, Object> otherData) {
		this.otherData = otherData;
	}
	public static String checkOrderBy(String orderBy,String sord) {
		if(StringUtils.isNotBlank(orderBy)){
			String reg = "(?:')|(?:--)|(/\\*(?:.|[\\n\\r])*?\\*/)|(\\b(select|update|and|or|delete|insert|trancate|char|into|substr|ascii|declare|exec|count|master|into|drop|execute)\\b)";
			Pattern sqlPattern = Pattern.compile(reg, 2);
			if (sqlPattern.matcher(orderBy).find()) {
				return "";
			}
		}else{
			return "";
		}
		if(StringUtils.isBlank(sord)){
			sord="asc";
		}
		return String.format("%s %s", new Object[]{orderBy,sord});
	}

	public void putOtherData(String key, Object val) {
		if (this.otherData == null) {
			this.otherData = Maps.newHashMap();
		}
		this.otherData.put(key, val);
	}
}
