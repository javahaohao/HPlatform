package com.hplatform.core.service;

import java.util.Arrays;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.hplatform.core.common.util.FileUtil;
import com.hplatform.core.entity.Attachment;
import com.hplatform.core.exception.CRUDException;
import com.hplatform.core.mapper.AttachmentMapper;

/**
 * 程序名称：AttachmentService.java
 * 程序说明：文件service
 * 版权信息： Copyright XXXXXXXXX有限公司
 * 时间：2012-2-24
 * 
 * @author： lib
 * @version： Ver 0.1
 */

@Service
public class AttachmentService extends BaseService<Attachment, AttachmentMapper> {
	
	/**
	 * 根据文件id查询文件
	 * @param id
	 * @return
	 * @throws CRUDException
	 */
	public Attachment findAttachmentById(String id) throws CRUDException{
		try{
			Attachment attachment = new Attachment();
			attachment.setId(id);
			return super.findOne(attachment);
		}catch(Exception e){
			log.error(e);
			throw new CRUDException(e);
		}
	}
	
	/**
	 * 删除文件
	 * @param listId
	 * @throws CRUDException
	 */
	public void deleteAttachment(String id) throws CRUDException {
		try{
			deleteAttachmentBatch(Arrays.asList(id.split(",")));
		}catch(Exception e){
			log.error(e);
			throw new CRUDException(e);
		}
	}
	/**
	 * 批量删除文件
	 * @param idList
	 * @throws CRUDException
	 */
	public void deleteAttachmentBatch(List<String> idList) throws CRUDException{
		try{
			Attachment attachment = new Attachment();
			attachment.setIdList(idList);
			m.deleteBatchEntity(attachment);
		}catch(Exception e){
			log.error(e);
			throw new CRUDException(e);
		}
	}
	/**
	 * 保存文件
	 * @param attachment
	 * @throws CRUDException
	 */
	public String saveAttachment(Attachment attachment) throws CRUDException{
        try{
			super.save(attachment);
		}catch(Exception e){
			log.error(e);
			throw new CRUDException(e);
		}
		return attachment.getId();
	}
	/**
	 * 上传文件
	 * @param attachment
	 * @throws CRUDException
	 */
	public Attachment createAttachment(Attachment attachment,MultipartFile multipartFile) throws CRUDException{
        try{
        	//根据文件格式，对文件作出相应处理，并返回处理之后对象
        	attachment = FileUtil.upload(attachment,multipartFile);
		}catch(Exception e){
			log.error(e);
			throw new CRUDException(e);
		}
		return attachment;
	}
	/**
	 * 上传分片文件
	 * @param attachment
	 * @throws CRUDException
	 */
	public Attachment createChunkAttachment(Attachment attachment,MultipartFile multipartFile) throws CRUDException{
		FileUtil.uploadChunk(attachment, multipartFile);
		return attachment;
	}
}
