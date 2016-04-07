package com.hplatform.core.common.util;


import org.apache.shiro.cache.Cache;

import com.hplatform.core.common.cache.SpringCacheManagerWrapper;

public class CacheUtil {
	private static SpringCacheManagerWrapper springCacheManagerWrapper = SpringUtils.getBean(SpringCacheManagerWrapper.class);
	/**
	 * 从全局缓存中获取数据
	 * @param cacheName
	 * @param key
	 * @param clz
	 * @return
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public static <T> T getGlobalCacheByKey(String cacheName,String key,Class<T> clz){
		Cache cache = getCache(cacheName);
		if(isNotEmpty(cache))
			return ((T)cache.get(key));
		else
			return null;
	}
	/**
	 * 
	 * @param cacheName
	 * @param key
	 * @param object
	 */
	@SuppressWarnings("unchecked")
	public static void putGlobalCache(String cacheName,String key,Object value){
		getCache(cacheName).put(key, value);
	}
	/**
	 * 按照缓存key删除缓存
	 * @param cacheName
	 * @param key
	 */
	@SuppressWarnings("unchecked")
	public static void removeGlobalCache(String cacheName,String key){
		getCache(cacheName).remove(key);
	}
	/**
	 * 按照缓存名称清空缓存
	 * @param cacheName
	 */
	public static void clearGlobalCache(String cacheName){
		getCache(cacheName).clear();
	}
	/**
	 * 获取缓存大小
	 * @param cacheName
	 * @return
	 */
	public static int getGlobalCacheSize(String cacheName){
		return getCache(cacheName).size();
	}
	/**
	 * 按照缓存名称获取缓存
	 * @param cacheName
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public static Cache getCache(String cacheName){
		return springCacheManagerWrapper.getCache(cacheName);
	}
	/**
	 * 判断缓存不为空
	 * @param cache
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public static boolean isNotEmpty(Cache cache){
		return cache.size()>0;
	}
	/**
	 * 判断缓存不为空
	 * @param cacheName
	 * @return
	 */
	public static boolean isNotEmpty(String cacheName){
		return springCacheManagerWrapper.getCache(cacheName).size()>0;
	}
}
