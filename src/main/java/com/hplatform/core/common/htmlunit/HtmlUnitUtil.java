package com.hplatform.core.common.htmlunit;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONObject;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.gargoylesoftware.htmlunit.html.HtmlPage;
import com.hplatform.core.common.domain.IpInfo;

public class HtmlUnitUtil {
	private static Log log = LogFactory.getLog(HtmlUnitUtil.class);
	/**
	 * 调用淘宝IP地址库获取客户端信息
	 * @return
	 */
	public static IpInfo getIpInfo(String ip){
		ip = (StringUtils.isBlank(ip)||"0:0:0:0:0:0:0:1".equals(ip))?"myip":ip;
		try {
			HtmlPage page = WebClientPool.getClient().getPage(String.format("http://ip.taobao.com/service/getIpInfo2.php?ip=%s", new Object[]{ip}));
			JSONObject jsonObject = JSONObject.fromObject(page.getWebResponse().getContentAsString());
			if(null!=jsonObject){
				JSONObject data = jsonObject.getJSONObject("data");
				return (IpInfo)JSONObject.toBean(data, IpInfo.class);
			}
		} catch (Exception e) {
			log.error("获取外网IP地址失败！", e);
			return getIpInfo(ip);
		}
		return null;
	}
	/**
	 * 按照url地址获取网页内容
	 * @param url
	 * @return
	 */
	public static String getWebResponse(String url){
		try {
			return WebClientPool.getClient().getPage(url).getWebResponse().getContentAsString();
		} catch (Exception e) {
			log.error("获取网页内容失败！", e);
		}
		return null;
	}
	/**
	 * 获取client的IP地址
	 * @param request
	 * @return
	 */
	public static String getIpAddress(HttpServletRequest request){
		String ip = request.getHeader("x-forwarded-for");
		if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("WL-Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getRemoteAddr();
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("http_client_ip");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("HTTP_X_FORWARDED_FOR");
		}
		// 如果是多级代理，那么取第一个ip为客户ip
		if (ip != null && ip.indexOf(",") != -1) {
			ip = ip.substring(ip.lastIndexOf(",") + 1, ip.length()).trim();
		}
		return ip;
	}
	public static void main(String[] args) {
		System.out.println(StringUtils.substring("370100", 0, 4));
	}
}
