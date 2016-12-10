package com.hplatform.core.common.mybatis;

import java.io.IOException;
import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

import com.hplatform.core.entity.BaseEntity;
import org.apache.ibatis.builder.xml.XMLMapperBuilder;
import org.apache.ibatis.executor.ErrorContext;
import org.apache.ibatis.session.Configuration;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.type.TypeAliasRegistry;
import org.springframework.beans.BeansException;
import org.springframework.beans.factory.DisposableBean;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.context.ConfigurableApplicationContext;
import org.springframework.core.NestedIOException;
import org.springframework.core.io.Resource;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;
import org.springframework.core.io.support.ResourcePatternResolver;
import org.springframework.util.StringUtils;

public class MybatisDynamicLoader implements DisposableBean, InitializingBean, ApplicationContextAware {

	private ConfigurableApplicationContext context = null;
	private transient String basePackage = null;
	private HashMap<String, String> fileMapping = new HashMap<String, String>();
	private Scanner scanner = null;
	private ScheduledExecutorService service = null;
    private final List<String> changeMapers = new ArrayList<String>();
	private Configuration configuration;
	private SqlSessionFactory sqlSessionFactory;

	public Configuration getConfiguration(){
		if(null==configuration)
			configuration = getSqlSessionFactory().getConfiguration();
		return configuration;
	}
	public SqlSessionFactory getSqlSessionFactory(){
		if(null==sqlSessionFactory)
			sqlSessionFactory = context.getBean(SqlSessionFactory.class);
		return sqlSessionFactory;
	}
	@Override
	public void setApplicationContext(ApplicationContext applicationContext) throws BeansException {
		this.context = (ConfigurableApplicationContext) applicationContext;

	}

	@Override
	public void afterPropertiesSet() throws Exception {
		try {
			service = Executors.newScheduledThreadPool(1);
			// 获取xml所在包
			BasePackageMapperScannerConfigurer config = context.getBean(BasePackageMapperScannerConfigurer.class);
			basePackage = config.getBasePackage();
			// 触发文件监听事件
			scanner = new Scanner();
			scanner.scan();
			service.scheduleAtFixedRate(new Task(), 5, 5, TimeUnit.SECONDS);

		} catch (Exception e1) {
			e1.printStackTrace();
		}

	}

	class Task implements Runnable {
		@Override
		public void run() {
			try {
				if (scanner.isChanged()) {
					System.out.println(changeMapers.toString()+"文件改变,重新加载.");
					scanner.reloadXML();
					System.out.println("-------------Mapper.xml加载完毕---------------------");
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

	}

	@SuppressWarnings({ "rawtypes" })
	class Scanner {
		private String[] basePackages;
		private static final String XML_RESOURCE_PATTERN = ResourcePatternResolver.CLASSPATH_ALL_URL_PREFIX + "**/*Mapper.xml";
		private ResourcePatternResolver resourcePatternResolver = new PathMatchingResourcePatternResolver();

		public Scanner() {
			basePackages = StringUtils.tokenizeToStringArray(MybatisDynamicLoader.this.basePackage,
					ConfigurableApplicationContext.CONFIG_LOCATION_DELIMITERS);
		}

		public Resource[] getResource(String basePackage, String pattern) throws IOException {
//			String packageSearchPath = ResourcePatternResolver.CLASSPATH_ALL_URL_PREFIX
//					+ ClassUtils.convertClassNameToResourcePath(context.getEnvironment().resolveRequiredPlaceholders(
//							basePackage)) + "/" + pattern;
			
			return resourcePatternResolver.getResources(pattern);
		}

		public void reloadXML() throws Exception {
			// 移除加载项
			removeConfig(getConfiguration());
			// 重新扫描加载
			for (String basePackage : basePackages) {
				Resource[] resources = getResource(basePackage, XML_RESOURCE_PATTERN);
				if (resources != null) {
					for (int i = 0; i < resources.length; i++) {
						if (resources[i] == null) {
							continue;
						}
						try {
							XMLMapperBuilder xmlMapperBuilder = new XMLMapperBuilder(resources[i].getInputStream(),
									getConfiguration(), resources[i].toString(), getConfiguration().getSqlFragments());
							xmlMapperBuilder.parse();
						} catch (Exception e) {
							throw new NestedIOException("Failed to parse mapping resource: '" + resources[i] + "'", e);
						} finally {
							ErrorContext.instance().reset();
						}
					}
				}
			}

		}

		private void removeConfig(Configuration configuration) throws Exception {
			Class<?> classConfig = configuration.getClass();
			clearMap(classConfig, configuration, "mappedStatements");
			clearMap(classConfig, configuration, "caches");
			clearMap(classConfig, configuration, "resultMaps");
			clearMap(classConfig, configuration, "parameterMaps");
			clearMap(classConfig, configuration, "keyGenerators");
			clearMap(classConfig, configuration, "sqlFragments");

			clearSet(classConfig, configuration, "loadedResources");

		}

		private void clearMap(Class<?> classConfig, Configuration configuration, String fieldName) throws Exception {
			Field field = classConfig.getDeclaredField(fieldName);
			field.setAccessible(true);
			Map mapConfig = (Map) field.get(configuration);
			mapConfig.clear();
		}

		private void clearSet(Class<?> classConfig, Configuration configuration, String fieldName) throws Exception {
			Field field = classConfig.getDeclaredField(fieldName);
			field.setAccessible(true);
			Set setConfig = (Set) field.get(configuration);
			setConfig.clear();
		}

		public void scan() throws IOException {
			if (!fileMapping.isEmpty()) {
				return;
			}
			for (String basePackage : basePackages) {
				Resource[] resources = getResource(basePackage, XML_RESOURCE_PATTERN);
				if (resources != null) {
					for (int i = 0; i < resources.length; i++) {
						String multi_key = getValue(resources[i]);
						fileMapping.put(resources[i].getFilename(), multi_key);
					}
				}
			}
		}

		private String getValue(Resource resource) throws IOException {
			String contentLength = String.valueOf((resource.contentLength()));
			String lastModified = String.valueOf((resource.lastModified()));
			return new StringBuilder(contentLength).append(lastModified).toString();
		}

		public boolean isChanged() throws IOException {
			boolean isChanged = false;
			changeMapers.clear();
			for (String basePackage : basePackages) {
				Resource[] resources = getResource(basePackage, XML_RESOURCE_PATTERN);
				if (resources != null) {
					for (int i = 0; i < resources.length; i++) {
						String name = resources[i].getFilename();
						String value = fileMapping.get(name);
						String multi_key = getValue(resources[i]);
						if (!multi_key.equals(value)) {
							changeMapers.add(name);
							isChanged = true;
							fileMapping.put(name, multi_key);
						}
					}
				}
			}
			return isChanged;
		}
	}

	@Override
	public void destroy() throws Exception {
		if (service != null) {
			service.shutdownNow();
		}
	}

	/**
	 * 按照扫描路径注册实体类别名
	 * @param packageToScan
	 */
	public void registTypeAliases(String packageToScan){
		TypeAliasRegistry aliasRegistry = getConfiguration().getTypeAliasRegistry();
		aliasRegistry.registerAlias(packageToScan, BaseEntity.class);
	}

	/**
	 * 按照类型注册实体类名(该种方式注册的别名是小写的别名，这也许是mybatis的bug)
	 * @param type
	 */
	public void registTypeAliases(Class<?> type){
		TypeAliasRegistry aliasRegistry = getConfiguration().getTypeAliasRegistry();
		aliasRegistry.registerAlias(type.getSimpleName(),type);
	}
}
