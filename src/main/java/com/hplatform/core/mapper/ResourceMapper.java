package com.hplatform.core.mapper;

import java.util.Map;

import com.hplatform.core.common.annotation.MyBatisMapper;
import com.hplatform.core.entity.Resource;

@MyBatisMapper
public interface ResourceMapper extends BaseMapper<Resource>{
	public void deleteEntityByParent(Resource resource);
	public void move(Map<String, String> paramMap);
}
