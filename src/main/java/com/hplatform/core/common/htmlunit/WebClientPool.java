package com.hplatform.core.common.htmlunit;

import org.apache.commons.pool.impl.GenericObjectPool;
import org.apache.commons.pool.impl.GenericObjectPool.Config;

import com.gargoylesoftware.htmlunit.WebClient;

public class WebClientPool {
	private GenericObjectPool<WebClient> pool;
	private static final WebClientPool webClientPool = new WebClientPool();

	public WebClientPool() {
		Config config = new Config();
		config.maxActive = 100;
		config.maxIdle = 10;
		config.maxWait = 120000;
		config.whenExhaustedAction = GenericObjectPool.WHEN_EXHAUSTED_GROW;
		WebClientFactory factory = new WebClientFactory();
		pool = new GenericObjectPool<WebClient>(factory, config) ;
	}
	public WebClientPool(Config config) {
		WebClientFactory factory = new WebClientFactory();
		pool = new GenericObjectPool<WebClient>(factory, config) ;
	}

	public WebClient getWebClient() throws Exception {
		return pool.borrowObject();
	}
	/**
	 * 获取单例的webClientPool实例
	 * @return
	 */
	public static WebClientPool getInstance(){
		return webClientPool;
	}
	/**
	 * 获取webclient
	 * @return
	 */
	public static WebClient getClient(){
		try {
			return webClientPool.getWebClient();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
