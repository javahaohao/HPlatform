package com.hplatform.core.mapper;

import com.hplatform.core.common.annotation.MyBatisMapper;
import com.hplatform.core.entity.News;


/**
 * 程序名称： NewsMapper.java
 * 程序说明： 文件mapper
 * 版权信息： Copyright XXXXXXXXX有限公司
 * 时间： 2012-2-24
 * 
 * @author： lib
 * @version： Ver 0.1
 */
@MyBatisMapper
public interface NewsMapper extends BaseMapper<News> {

	public void updateBatchStatus(News news);
	
	public News findNewsWithComment(News news);
	
}