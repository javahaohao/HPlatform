package com.hplatform.core.common.util;

import java.util.HashMap;
import java.util.Map;

public class JSPlugins {
	private static Map<String, String> plugins = new HashMap<String, String>();
	static{
		plugins.put("jqui", "jqui");//jquery-ui插件
		plugins.put("fullcalendar", "fullcalendar");//fullcalendar日历插件
		plugins.put("select2", "select2");//select2下拉选择插件
		plugins.put("editable", "editable");//editable表编辑插件
		plugins.put("jqgrid", "jqgrid");//jqgrid列表插件
		plugins.put("dropzone", "dropzone");//dropzone上传插件
		plugins.put("jbox", "jbox");//jbox弹出框/提示插件
		plugins.put("ztree", "ztree");//ztree树插件
		plugins.put("template", "template");//template腾讯模板引擎插件
		plugins.put("dataTables", "dataTables");//dataTables列表插件
		plugins.put("validate", "validate");//jquery validate验证插件
		plugins.put("flot", "flot");//jquery flot图表插件
		plugins.put("easypiechart", "easypiechart");//jquery easy-pie-chart图表插件
		plugins.put("typeahead", "typeahead");//jquery typeahead填充数据插件
		plugins.put("wysiwyg", "wysiwyg");//jquery wysiwyg富文本编辑插件
		plugins.put("sparkline", "sparkline");//jquery sparkline线型图表插件
		plugins.put("datetime", "datetime");//jquery date-time日期插件
		plugins.put("colorpicker", "colorpicker");//bootstrap-colorpicker颜色选择插件
		plugins.put("knob", "knob");//jquery.knob图表旋转插件
		plugins.put("maskedinput", "maskedinput");//jquery.maskedinput输入框格式插件
	}
	public static Map<String, String> getJsPlugins(){
		return plugins;
	}
}
