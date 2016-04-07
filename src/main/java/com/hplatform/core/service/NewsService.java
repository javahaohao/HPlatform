package com.hplatform.core.service;

import java.util.Arrays;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.org.rapid_framework.util.ObjectUtils;

import com.hplatform.core.entity.News;
import com.hplatform.core.exception.CRUDException;
import com.hplatform.core.mapper.NewsMapper;
@Service
public class NewsService extends BaseService<News, NewsMapper>{
	/**
	 * 批量修改新闻状态
	 * @param news
	 * @throws CRUDException
	 */
	public void updateBatchStatus(News news) throws CRUDException{
		try{
			news.preUpdate();
			news.setIdList(Arrays.asList(news.getId().split(",")));
			//如果审核意见不为空则对新闻进行审核操作，设置审核人、审核时间
			if(ObjectUtils.isNotEmpty(news.getCheckup())){
				news.setCheckUser(news.getUpdateUser());
				news.setCheckDate(news.getCheckDate());
			}
			m.updateBatchStatus(news);
		}catch(Exception e){
			log.error(e);
			throw new CRUDException(e);
		}
	}
	//查询新闻信息带有评论信息
	/**
	 * 查询带有评论信息的新闻
	 * @param news
	 * @return
	 * @throws CRUDException 
	 */
	public News findNewsWithComment(News news) throws CRUDException{
		try{
			return m.findNewsWithComment(news);
		}catch(Exception e){
			log.error(e);
			throw new CRUDException(e);
		}
	}
}
