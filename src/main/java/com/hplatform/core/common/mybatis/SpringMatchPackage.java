package com.hplatform.core.common.mybatis;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.core.io.Resource;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;
import org.springframework.core.io.support.ResourcePatternResolver;
import org.springframework.core.type.classreading.CachingMetadataReaderFactory;
import org.springframework.core.type.classreading.MetadataReader;
import org.springframework.core.type.classreading.MetadataReaderFactory;
import org.springframework.util.ClassUtils;

public class SpringMatchPackage {

	private static final transient Log log = LogFactory.getLog(SpringMatchPackage.class);
	
	static final String DEFAULT_RESOURCE_PATTERN = "**/*.class";
	
	public static String[] getMatchPackage(String matchPath){
		String[] pathArray = null;
		ResourcePatternResolver resolver = (ResourcePatternResolver) new PathMatchingResourcePatternResolver();
        MetadataReaderFactory metadataReaderFactory = new CachingMetadataReaderFactory(resolver);
        matchPath = ResourcePatternResolver.CLASSPATH_ALL_URL_PREFIX +
                ClassUtils.convertClassNameToResourcePath(matchPath) + "/" + DEFAULT_RESOURCE_PATTERN;

        //将加载多个绝对匹配的所有Resource
        //将首先通过ClassLoader.getResource("META-INF")加载非模式路径部分
        //然后进行遍历模式匹配
        try {
            List<String> result = new ArrayList<String>();
            Resource[] resources =  resolver.getResources(matchPath);
            if(resources != null && resources.length > 0){
                MetadataReader metadataReader = null;
                for(Resource resource : resources){
                    if(resource.isReadable()){
                        metadataReader =  metadataReaderFactory.getMetadataReader(resource);
                        try {
                            result.add(Class.forName(metadataReader.getClassMetadata().getClassName()).getPackage().getName());
                        } catch (ClassNotFoundException e) {
                        	log.error(e);
                        }
                    }
                }
            }
            if(result.size() > 0) {
            	pathArray = result.toArray(new String[]{});
            }else{
            	log.error(matchPath+"，未找到任何包");
            }
        } catch (IOException e) {
        	log.error(e);
        }
        return pathArray;
	}

}
