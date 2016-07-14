package com.hplatform.core.common.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * 时间格式化中文移动端格式
 * @author pangweixin
 * @date 2016-07-14
 */
public class RelativeDateFormatUtils {

	private static final long ONE_SECOND = 1000L;
	private static final long ONE_MINITE = ONE_SECOND*60L;
	private static final long ONE_HOUR   = ONE_MINITE*60L;
	private static final long ONE_DAY    = ONE_HOUR*24L;
	private static final long ONE_MONTH  = ONE_DAY*30L;
	
    private static final String ONE_SECOND_AGO 		= "秒前";
    private static final String ONE_MINUTE_AGO 		= "分钟前";
    private static final String ONE_HOUR_AGO 		= "小时前";
    private static final String ONE_DAY_YESTERDAY 	= "昨天";
    private static final String ONE_DAY_AGO 		= "天前";
    private static final String ONE_MONTH_AGO 		= "月前";
    private static final String ONE_YEAR_AGO 		= "年前";
    
    public static String formatDate(String fmtDate){
    	
    	SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    	
    	try {
			Date formateDate = format.parse(fmtDate);
			return formatDate(formateDate);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
    	return null;
    }
    	  
    public static String formatDate(Date fmtDate){
    	long intervalTime = new Date().getTime()-fmtDate.getTime();
    	//如果小于一分钟
    	if(intervalTime < ONE_MINITE){
    		long seconds = toSeconds(intervalTime);
    		return (seconds<=0?"1":seconds)+ONE_SECOND_AGO;
    	}
    	//如果小于一小时
    	if(intervalTime < ONE_HOUR){
    		long minites = toMinites(intervalTime);
    		return (minites<=0?"1":minites)+ONE_MINUTE_AGO;
    	}
    	//如果小于一小时
    	if(intervalTime < ONE_DAY){
    		long hours = toHours(intervalTime);
    		return (hours<=0?"1":hours)+ONE_HOUR_AGO;
    	}
    	//如果小于两天
    	if(intervalTime < 2 * ONE_DAY){
    		return ONE_DAY_YESTERDAY;
    	}
    	//如果小于一个月
    	if(intervalTime < 30 * ONE_DAY){
    		long days = toDays(intervalTime);
    		return (days<=0?"1":days)+ONE_DAY_AGO;
    	}
    	//如果小于一年
    	if(intervalTime < 12 * ONE_MONTH){
    		long months = toMonths(intervalTime);
    		return (months<=0?"1":months)+ONE_MONTH_AGO;
    	} else{
    		long years = toYears(intervalTime);
    		return (years<=0?"1":years)+ONE_YEAR_AGO;
    	}
    	
    }


	private static long toYears(long intervalTime) {
		return toMonths(intervalTime)/12L;
	}

	private static long toMonths(long intervalTime) {
		return toDays(intervalTime)/30L;
	}

	private static long toDays(long intervalTime) {
		return toHours(intervalTime)/24L;
	}
	
	private static long toHours(long intervalTime) {
		return toMinites(intervalTime)/60L;
	}

	private static long toMinites(long intervalTime) {
		
		return toSeconds(intervalTime)/60L;
	}

	private static long toSeconds(long intervalTime) {
		
		return intervalTime/ONE_SECOND;
	}
	
	public static void main(String[] args) throws ParseException {
		
		Date currentDate = new Date();
		
		Date secondsAgo = new Date(currentDate.getTime()-12*RelativeDateFormatUtils.ONE_SECOND);
		System.out.println(RelativeDateFormatUtils.formatDate(secondsAgo));
		
		Date minitesAgo = new Date(currentDate.getTime()-12*RelativeDateFormatUtils.ONE_MINITE);
		System.out.println(RelativeDateFormatUtils.formatDate(minitesAgo));
		
		Date hoursAgo = new Date(currentDate.getTime()-12*RelativeDateFormatUtils.ONE_HOUR);
		System.out.println(RelativeDateFormatUtils.formatDate(hoursAgo));
		
		Date yesterDayAgo = new Date(currentDate.getTime()-25*RelativeDateFormatUtils.ONE_HOUR);
		System.out.println(RelativeDateFormatUtils.formatDate(yesterDayAgo));
		
		Date lostsDaysAgo = new Date(currentDate.getTime()-15*RelativeDateFormatUtils.ONE_DAY);
		System.out.println(RelativeDateFormatUtils.formatDate(lostsDaysAgo));
		
		Date monthsAgo = new Date(currentDate.getTime()-4*RelativeDateFormatUtils.ONE_MONTH);
		System.out.println(RelativeDateFormatUtils.formatDate(monthsAgo));
		
		Date yearsAgo = new Date(currentDate.getTime()-15*RelativeDateFormatUtils.ONE_MONTH);
		System.out.println(RelativeDateFormatUtils.formatDate(yearsAgo));
	}
}
