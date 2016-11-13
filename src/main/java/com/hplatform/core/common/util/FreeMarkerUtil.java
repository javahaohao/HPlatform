package com.hplatform.core.common.util;

import cn.org.rapid_framework.util.ObjectUtils;
import com.hplatform.core.common.freemarkertmp.IsELFun;
import com.hplatform.core.common.freemarkertmp.TrimELFun;
import com.hplatform.core.constants.TableConstants;
import com.hplatform.core.entity.Table;
import com.hplatform.core.service.TableService;
import freemarker.template.Configuration;
import freemarker.template.DefaultObjectWrapper;
import freemarker.template.Template;
import freemarker.template.TemplateExceptionHandler;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import java.io.File;
import java.io.IOException;
import java.io.StringWriter;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedHashMap;
import java.util.Map;

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
	/**
	 * 风格类型映射标示
	 */
	public static Map<String,String> fgTypeMaps = new LinkedHashMap<String, String>(){
		/**
		 * 
		 */
		private static final long serialVersionUID = 1L;

		{
			//默认datables标示为空
			put(ConstantsUtil.get().DICT_FG_DATATABLES_ID,"");
			put(ConstantsUtil.get().DICT_FG_JQGRID_ID,"_jqgrid");
		}
	};
	
	/**
	 * 生成类型映射标示
	 */
	public static Map<Table.RelationType,String> genTypeMaps = new LinkedHashMap<Table.RelationType, String>(){
		/**
		 * 
		 */
		private static final long serialVersionUID = 1L;

		{
			put(Table.RelationType.one,"");
			put(Table.RelationType.one_2_one,"one2one_");
			put(Table.RelationType.one_2_more,"one2more_");
			put(Table.RelationType.more_2_one,"more2one_");
		}
	};
	
	public static void genCode(Table table) throws Exception{
		if(ObjectUtils.isNotEmpty(table.getGenFlag())&&table.getGenFlag()) {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("table", table);
			map.put("trimEL", new TrimELFun());
			map.put("isEL", new IsELFun());
            map.put("excludeColumns",new HashSet<String>(){{
                add("createDate");
                add("updateDate");
                add("createUser");
                add("updateUser");
            }});
			Map<String, String> tmpMap = new HashMap<String, String>();
			tmpMap.put(String.format("src/main/resources/mapper/%s/%sMapper.xml", table.getBumodel(), table.getDomainName())
					, String.format("%smappersql.ftl", genTypeMaps.get(table.getRelationType())));
			tmpMap.put(String.format("src/main/java/%s/%s/mapper/%sMapper.java", table.getSplitPkg(), table.getBumodel(), table.getDomainName())
					, "mapper.ftl");
			tmpMap.put(String.format("src/main/java/%s/%s/service/%sService.java", table.getSplitPkg(), table.getBumodel(), table.getDomainName())
					, "service.ftl");
			tmpMap.put(String.format("src/main/java/%s/%s/web/controller/%sController.java", table.getSplitPkg(), table.getBumodel(), table.getDomainName())
					, String.format("%scontroller%s.ftl", genTypeMaps.get(table.getRelationType()), fgTypeMaps.get(table.getFgType())));
			tmpMap.put(String.format("src/main/java/%s/%s/entity/%s.java", table.getSplitPkg(), table.getBumodel(), table.getDomainName())
					, String.format("%sdomain.ftl", genTypeMaps.get(table.getRelationType())));
			tmpMap.put(String.format("src/main/java/%s/%s/constants/%sConstants.java", table.getSplitPkg(), table.getBumodel(), table.getDomainName())
					, "constants.ftl");
			tmpMap.put(String.format("src/main/webapp/WEB-INF/jsp/%s/%s/list.jsp", table.getBumodel(), StringUtils.lowerCase(table.getDomainName()))
					, String.format("%slist%s.ftl", genTypeMaps.get(table.getRelationType()), fgTypeMaps.get(table.getFgType())));
			tmpMap.put(String.format("src/main/webapp/WEB-INF/jsp/%s/%s/edit.jsp", table.getBumodel(), StringUtils.lowerCase(table.getDomainName()))
					, String.format("%sedit.ftl", genTypeMaps.get(table.getRelationType())));
			for (String tmp : tmpMap.keySet()) {
				FileUtil.printTxtToFile(StringUtils.join(FileUtil.getProjectPath(), File.separator, tmp), FreeMarkerUtil.getInstance().getHtmlString(tmpMap.get(tmp), map));
//			FileUtil.printTxtToFile(StringUtils.join("f:/gen",File.separator,tmp), FreeMarkerUtil.getInstance().getHtmlString(tmpMap.get(tmp), map));
			}
			//更新表为已经生成代码状态
			SpringUtils.getBean(TableService.class).updateGenComplete(table.getId());
		}
	}
}
