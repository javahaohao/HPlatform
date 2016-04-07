package com.hplatform.core.mapper;

import java.util.List;
import java.util.Map;

import com.hplatform.core.common.annotation.MyBatisMapper;
import com.hplatform.core.entity.Organization;

@MyBatisMapper
public interface OrganizationMapper extends BaseMapper<Organization> {
	public void deleteEntityByParent(Organization organization);
	public List<Organization> findAllWithExclude(Organization organization);
	public void move(Map<String, String> paramMap);
}
