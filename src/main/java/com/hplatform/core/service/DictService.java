package com.hplatform.core.service;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Service;

import com.hplatform.core.common.util.FileUtil;
import com.hplatform.core.common.util.IDUtil;
import com.hplatform.core.common.util.PingYinUtil;
import com.hplatform.core.constants.Constants;
import com.hplatform.core.entity.Dict;
import com.hplatform.core.exception.CRUDException;
import com.hplatform.core.mapper.DictMapper;

/**
 * <p>User: JavaHao
 * <p>Date: 14-2-14
 * <p>Version: 1.0
 */
@Service

public class DictService extends BaseService<Dict, DictMapper> {

    @CacheEvict(value={Constants.CACHE_DICT,Constants.CACHE_DICT_K_V,Constants.CACHE_DICT_PARENT},allEntries=true,beforeInvocation=true)
    public void createDict(Dict dict) throws CRUDException {
    	super.save(dict);
    }

    @CacheEvict(value={Constants.CACHE_DICT,Constants.CACHE_DICT_K_V,Constants.CACHE_DICT_PARENT},allEntries=true,beforeInvocation=true)
    public void updateDict(Dict dict) throws CRUDException {
    	dict.preUpdate();
        move(dict);
        m.updateEntity(dict);
    }

    @CacheEvict(value={Constants.CACHE_DICT,Constants.CACHE_DICT_K_V,Constants.CACHE_DICT_PARENT},allEntries=true,beforeInvocation=true)
    public void deleteDict(String resourceId) throws CRUDException {
    	Dict dict = new Dict();
    	dict.setId(resourceId);
    	Dict result = super.findOne(dict);
    	super.delete(dict);
        m.deleteEntityByParent(result);
    }

    @Cacheable(value=Constants.CACHE_DICT_K_V)
    public Dict findOne(String resourceId) throws CRUDException {
    	Dict dict = new Dict();
    	dict.setId(resourceId);
        return super.findOne(dict);
    }

    @Cacheable(value=Constants.CACHE_DICT)
    public List<Dict> findAll() throws CRUDException {
        return super.findAll(new Dict());
    }
    /**
     * 按照字典ID查询子节点
     * @param dictId
     * @return
     */
    @Cacheable(value=Constants.CACHE_DICT_PARENT,key="#dictId")
    public List<Dict> findChildDictById(String dictId) {
    	return m.findChildDictById(dictId);
    }
    @CacheEvict(value={Constants.CACHE_RESOURCE,Constants.CACHE_RESOURCE_K_V},allEntries=true,beforeInvocation=true)
    public void move(Dict dict) throws CRUDException {
    	Dict source = super.findOne(dict);
    	if(!source.getParentIds().equals(dict.getParentIds())){
    		Map<String, String> paramMap = new HashMap<String, String>();
        	paramMap.put("source", source.getSelfPath());
        	paramMap.put("target", dict.getSelfPath());
        	m.move(paramMap);
    	}
    }
    public static void main(String[] args) throws CRUDException{
    	ApplicationContext ac = new ClassPathXmlApplicationContext(
				"spring-config.xml");
    	DictService dic = ac.getBean(DictService.class);
    	List<String> result = FileUtil.readTxt("g:/1.txt");
    	for(String txt : result){
    		Dict dict = new Dict();
    		dict.setId(IDUtil.createUUID());
    		dict.setName(txt);
    		dict.setValue(PingYinUtil.getPingYin(txt));
    		dict.setMeans(txt);
    		dict.setParentId("ebc9c83fb9f1433a9c2df8a7d107d24f");
    		dict.setParentIds("0/1/3cefee9bf1634039b69c578064b3e644/ebc9c83fb9f1433a9c2df8a7d107d24f/");
    		dict.setAvailable(true);
    		dict.setCreateUser("1");
    		dict.setCreateDate(new Date());
    		dic.createDict(dict);
    	}
    }
}
