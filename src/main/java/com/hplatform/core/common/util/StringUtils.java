package com.hplatform.core.common.util;

public class StringUtils {
	/**
	 * 获取str的驼峰写法
	 * @param str
	 * @return
	 */
	public static String getHumpStr(String str){
		String strArray[]=null;
		String result=null;
		if(str.indexOf("_")>0){
			StringBuffer sb = new StringBuffer();
			strArray = str.split("_");
			for(int i=0;i<strArray.length;i++)
				if(i==0)
					sb.append(strArray[i]);
				else
					sb.append(uperFirst(strArray[i]));
			result = sb.toString();
		}else
			result = str;
		return result;
	}
	public static String uperFirst(String c){
		String firstChar = c.substring(0, 1);
		return String.format("%s%s",new Object[]{firstChar.toUpperCase(),c.substring(1, c.length())});
	}
}
