package com.hplatform.core.mapper;

import java.util.List;
import java.util.Map;

import com.hplatform.core.common.annotation.MyBatisMapper;
import com.hplatform.core.entity.Dict;

@MyBatisMapper
public interface DictMapper extends BaseMapper<Dict>{
	public void deleteEntityByParent(Dict dict);
	public List<Dict> findChildDictById(String dictId);
	public void move(Map<String, String> paramMap);
}
