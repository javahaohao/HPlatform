package com.hplatform.core.mapper;

import java.util.List;

import com.hplatform.core.common.annotation.MyBatisMapper;
import com.hplatform.core.entity.Area;

@MyBatisMapper
public interface AreaMapper extends BaseMapper<Area>{
	public List<Area> findChildAreaById(String AreaId);
	/**
	 * 查询所有城市信息
	 * @return
	 */
	public List<Area> findAllCity();
	
	/**
	 * 查询所有省下面的区域
	 * @param area
	 * @return
	 */
	public List<Area> findBrotherArea(List<String> idList);
}
