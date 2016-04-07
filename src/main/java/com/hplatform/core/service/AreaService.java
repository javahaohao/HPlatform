package com.hplatform.core.service;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import com.hplatform.core.common.util.IDUtil;
import com.hplatform.core.common.util.PingYinUtil;
import com.hplatform.core.constants.Constants;
import com.hplatform.core.entity.Area;
import com.hplatform.core.exception.CRUDException;
import com.hplatform.core.mapper.AreaMapper;

/**
 * <p>User: hls
 * <p>Date: 14-2-14
 * <p>Version: 1.0
 */
@Service
public class AreaService extends BaseService<Area, AreaMapper>{

    /**
     * 获取单个地域数据
     * @param area
     * @return
     * @throws CRUDException
     */
    @Cacheable(value=Constants.CACHE_AREA_K_V)
    public Area findOne(Area area) throws CRUDException{
    	try {
			return super.findOne(area);
		} catch (Exception e) {
			log.error(e);
			throw new CRUDException(e);
		}
    }
    /**
     * 查询传入参数ID的同级以及上级区域
     * @param area
     * @return
     * @throws CRUDException
     */
    @Cacheable(value=Constants.CACHE_AREA_K_BROTHER)
    public Map<String, Object> findBrotherAndParentArea(String id) throws CRUDException{
    	try {
    		List<Area> areas = null;
			Area area = new Area();
    		area.setId(id);
    		Area checkedArea = findOne(area);
    		List<String> queryParam = new ArrayList<String>();
    		List<String> pidList = new ArrayList<String>(Arrays.asList(checkedArea.getParentIds().split("/")));
    		queryParam.add(id);
			queryParam.addAll(pidList.subList(1, pidList.size()));
    		
    		areas = m.findBrotherArea(queryParam);
    		
    		return analyAreas(areas, id);
		} catch (Exception e) {
			log.error(e);
			throw new CRUDException(e);
		}
    }
    /**
     * 查询所有省份信息
     * @return
     * @throws CRUDException
     */
    @Cacheable(value=Constants.CACHE_AREA_K_PROVINCE)
    public Map<String, Object> findProvAreas() throws CRUDException{
    	try {
			Area param = new Area();
			param.setLevel(1);
			List<Area> areas = findAll(param);
			return analyAreas(areas, null);
		} catch (CRUDException e) {
			log.error(e);
			throw new CRUDException(e);
		}
    }
    /**
     * 拼装渲染区域选择对象
     * @param areas
     * @param id
     * @return
     */
    private Map<String, Object> analyAreas(List<Area> areas,String id){
    	List<Area> areaParam = null;
		List<String> checkList = new ArrayList<String>();
		Area currentArea = null;
		Map<Integer, List<Area>> resultMap = new HashMap<Integer, List<Area>>();
		Map<String, Object> result = new HashMap<String, Object>();
		for(Area eachArea : areas){
			if(CollectionUtils.isEmpty(areaParam=resultMap.get(eachArea.getLevel()))){
				areaParam = new ArrayList<Area>();
				resultMap.put(eachArea.getLevel(), areaParam);
			}
			if(StringUtils.isNotBlank(id)&&eachArea.getId().equals(id)){
				currentArea = eachArea;
			}
			areaParam.add(eachArea);
		}
		if(StringUtils.isNotBlank(id)){
			//选中的ID
			checkList.addAll(Arrays.asList(currentArea.getParentIds().split("/")));
			checkList.add(id);
			checkList.remove(0);
		}
		result.put("brotherAreas", resultMap);
		result.put("selectedAreas", checkList);
		return result;
    }
    public void updateFirstEn() throws CRUDException{
    	List<Area> areas = findAll(new Area());
    	for(Area area : areas){
    		area.setChName(PingYinUtil.getPingYin(area.getName()));
    		area.setFirstLetter(PingYinUtil.getFistOneSpell(area.getName()));
    		super.update(area);
    	}
    }
    public void updateIds() throws CRUDException{
    	List<Area> areas = findAll(new Area());
    	int i=0;
    	for(Area area : areas){
    		area.setId(IDUtil.createUUID());
    		super.update(area);
    		System.out.println(i++);
    	}
    }
    /**
     * 更新区域父节点ID
     * @throws CRUDException
     */
    public void updateData() throws CRUDException{
    	List<Area> areas = findAll(new Area());
    	Map<String, String> idMap = new HashMap<String, String>();
    	StringBuffer result = null;
    	int i=0;
		idMap.put("0","0");
    	for(Area area : areas){
    		idMap.put(area.getCode(),area.getId());
    	}
    	for(Area area : areas){
    		result = new StringBuffer();
    		getParendIds(area.getParentCode(), result, idMap);
    		result.insert(0, "0/");
    		area.setParentIds(result.toString());
    		area.setParentId(idMap.get(area.getParentCode()));
    		super.update(area);
    		System.out.println(i++);
    	}
    }
    public void getParendIds(String parentCode,StringBuffer result,Map<String, String> idMap){
    	if(parentCode.length()>=2){
    		result.insert(0,"/");
        	result.insert(0,idMap.get(parentCode));
        	getParendIds(parentCode.substring(0,parentCode.length()-2), result, idMap);
    	}
    }
    public static void main(String[] args) throws CRUDException {
    	ApplicationContext ac = new ClassPathXmlApplicationContext(
				"spring-config.xml");
    	AreaService areaService = ac.getBean(AreaService.class);
    	areaService.updateFirstEn();
	}
}
