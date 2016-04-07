package com.hplatform.core.common.htmlunit;

import java.io.IOException;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

public class JsoupUtil {
	private static Log log = LogFactory.getLog(JsoupUtil.class);
	/**
	 * 按照URL中选择器匹配到的元素
	 * @param url
	 * @param selector
	 * @return
	 */
	public static Elements getElementsByUrl(String url,String selector){
		Document document = null;
		try {
			document = Jsoup.connect(url).timeout(60000).userAgent("Mozilla").maxBodySize(Integer.MAX_VALUE).get();
		} catch (IOException e) {
			log.error("解析Url错误", e);
		}
		return document.select(selector);
	}
	/**
	 * 从element中按匹配器选出元素列表
	 * @param element
	 * @param selector
	 * @return
	 */
	public static Elements getElementBySelector(Element element,String selector){
		return element.select(selector);
	}
}
