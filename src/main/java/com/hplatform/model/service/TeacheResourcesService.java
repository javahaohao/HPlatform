package com.hplatform.model.service;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.hplatform.core.common.util.FileUtil;
import com.hplatform.core.entity.Attachment;
import com.hplatform.core.exception.CRUDException;
import com.hplatform.core.service.BaseService;
import com.hplatform.model.entity.TeacheResources;
import com.hplatform.model.mapper.TeacheResourcesMapper;
@Service
public class TeacheResourcesService extends BaseService<TeacheResources, TeacheResourcesMapper> {
	/**
	 * 修改封面
	 * @param file
	 * @return
	 * @throws CRUDException
	 */
	public Attachment updateFrontCover(Attachment attachment,MultipartFile file) throws CRUDException {
		try{
        	attachment = FileUtil.upload(attachment,file);
        	return attachment;
    	}catch(Exception e){
			log.error(e);
			throw new CRUDException(e);
		}
	}
}