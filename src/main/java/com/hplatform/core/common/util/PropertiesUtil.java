package com.hplatform.core.common.util;

import java.util.Properties;

public class PropertiesUtil {
	/**
	 * 属性文件加载对象
	 */
	private static Properties properties = FileUtil.readPropertiesUtil("resources.properties", FileUtil.CLASSPATH);
	
	/**
	 * 从reources.xml中获取值
	 * @param key
	 * @return
	 */
	public static String getProperty(String key){
		return properties.getProperty(key);
	}
	/**
	 * 获取管理员后台访问路径
	 * @return
	 */
	public static String getAdminPath(){
		return getProperty("adminPath");
	}
	/**
	 * 获取前台访问路径
	 * @return
	 */
	public static String getSitePath(){
		return getProperty("sitePath");
	}
}
