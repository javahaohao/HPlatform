package com.hplatform.core.common.util;

import java.io.File;
import java.io.IOException;
import java.io.StringWriter;
import java.util.HashMap;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.hplatform.core.entity.Table;

import freemarker.template.Configuration;
import freemarker.template.DefaultObjectWrapper;
import freemarker.template.Template;
import freemarker.template.TemplateExceptionHandler;

public class FreeMarkerUtil {
    private final transient Log log = LogFactory.getLog(FreeMarkerUtil.class);
	/**
	  * 定义FreeMarker Configuration对象config
	  */
	 private Configuration config = null;
	 
	 /**
	  * 编码
	  */
	 private String encoding = "UTF-8";
	 
	 /**
	  * FreeMarkerUtil对象FREEMARKER
	  */
	 private static final FreeMarkerUtil FREEMARKER = new FreeMarkerUtil();
	 
	 /**
	  * 获取当前freemarker实例
	  * @return
	  */
	 public static FreeMarkerUtil getInstance(){
		 return FREEMARKER;
	 }
	 
	 /**
	  * 构造方法
	  * 
	  * @throws IOException
	  */
	 private FreeMarkerUtil() {
		try {
			config = new Configuration();
			config.setClassForTemplateLoading(FreeMarkerUtil.class, "../template");;
			config.setTemplateExceptionHandler(TemplateExceptionHandler.HTML_DEBUG_HANDLER);
			config.setDefaultEncoding(encoding);
			config.setObjectWrapper(new DefaultObjectWrapper());
		} catch (Exception e) {
			log.error("初始化模板工具类失败！", e);
		}
	}
	 /**
	  * 输出到字符串
	  * 
	  * @param ftlFile
	  *            模板文件(相对根目录的绝对路径，以/开头)
	  * @param data
	  *            数据Map
	  * @return 结果字符串
	  */
	public String getHtmlString(String ftlFile, Map data) {
		StringWriter writer = null;
		String result = "";
		try {
			Template template = config.getTemplate(ftlFile);
			template.setEncoding(encoding);
			writer = new StringWriter();
			template.process(data, writer);
			result = writer.toString();
		} catch (Exception e) {
			log.error("生成静态HTML页面失败！", e);
		} finally {
			// 关闭write
			try {
				if (writer != null) {
					writer.flush();
					writer.close();
				}
			} catch (Exception ex) {
				log.error("关闭HTML页面流失败！", ex);
			}
		}
		return result;
	}
	public static void genCode(Table table) throws Exception{
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("table", table);
		Map<String, String> tmpMap = new HashMap<String, String>();
		tmpMap.put(String.format("src/main/resources/mapper/%s/%sMapper.xml", new Object[]{table.getBumodel(),table.getDomainName()}),"mappersql.ftl" );
		tmpMap.put(String.format("src/main/java/%s/%s/mapper/%sMapper.java", new Object[]{table.getPkg().replace(".","/"),table.getBumodel(),table.getDomainName()}),"mapper.ftl" );
		tmpMap.put(String.format("src/main/java/%s/%s/service/%sService.java", new Object[]{table.getPkg().replace(".","/"),table.getBumodel(),table.getDomainName()}),"service.ftl" );
		tmpMap.put(String.format("src/main/java/%s/%s/web/controller/%sController.java", new Object[]{table.getPkg().replace(".","/"),table.getBumodel(),table.getDomainName()}),ConstantsUtil.get().DICT_FG_JQGRID_ID.equals(table.getFgType())?"controllerjqgrid.ftl":"controller.ftl" );
		tmpMap.put(String.format("src/main/java/%s/%s/entity/%s.java", new Object[]{table.getPkg().replace(".","/"),table.getBumodel(),table.getDomainName()}),"domain.ftl" );
		tmpMap.put(String.format("src/main/java/%s/%s/constants/%sConstants.java", new Object[]{table.getPkg().replace(".","/"),table.getBumodel(),table.getDomainName()}),"constants.ftl" );
		tmpMap.put(String.format("src/main/webapp/WEB-INF/jsp/%s/%s/list.jsp", new Object[]{table.getBumodel(),StringUtils.lowerCase(table.getDomainName())}), ConstantsUtil.get().DICT_FG_JQGRID_ID.equals(table.getFgType())?"listjqgrid.ftl":"list.ftl" );
		tmpMap.put(String.format("src/main/webapp/WEB-INF/jsp/%s/%s/edit.jsp", new Object[]{table.getBumodel(),StringUtils.lowerCase(table.getDomainName())}),"edit.ftl" );
		for(String tmp : tmpMap.keySet()){
			FileUtil.printTxtToFile(StringUtils.join(new Object[]{FileUtil.getProjectPath(),File.separator,tmp}), FreeMarkerUtil.getInstance().getHtmlString(tmpMap.get(tmp), map));
		}
	}
}
