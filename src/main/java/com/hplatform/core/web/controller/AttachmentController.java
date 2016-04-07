package com.hplatform.core.web.controller;


import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.io.OutputStream;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import cn.org.rapid_framework.util.ObjectUtils;

import com.hplatform.core.common.util.FileUtil;
import com.hplatform.core.constants.AttachmentConstants;
import com.hplatform.core.entity.Attachment;
import com.hplatform.core.service.AttachmentService;

/**
 * 程序名称： AttachmentController.java
 * 程序说明：文件操作controller
 * 版权信息： Copyright XXXXXXXXX有限公司
 * 时间： 2011-2-23
 * 
 * @author： lib
 * @version： Ver 0.1
 */

@Controller
@RequestMapping(value = "${adminPath}/attachment")
public class AttachmentController extends BaseController {
	
	@Autowired
	private AttachmentService attachmentService;
	
	/**
	 * 查询所有文件信息
	 * @param modelMap
	 * @param attachment
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/listAttachment")
	public ModelAndView listAttachment(ModelMap modelMap,Attachment attachment) throws Exception{
		modelMap.put("attachmentList", attachmentService.findAll(attachment));
		return new ModelAndView(AttachmentConstants.LIST_ATTACHMENT, modelMap);
	}
	/**
	 * 按照ID查询文件信息
	 * @param modelMap
	 * @param id
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/findAttachmentById")
	public ModelAndView findAttachmentById(ModelMap modelMap,String id) throws Exception{
		modelMap.put("attachment", attachmentService.findAttachmentById(id));
		return new ModelAndView(AttachmentConstants.FIND_ATTACHMENT_BY_ID, modelMap);
	}
	
	/**
	 * 初始化上传页面
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/initUploadAttachment")
	public ModelAndView initUploadAttachment() throws Exception{
		return new ModelAndView(AttachmentConstants.UPLOAD_ATTACHMENT);
	}
	/**
	 * Ajax删除单文件
	 * @param id
	 * @throws Exception
	 */
	@RequestMapping(value = "/deleteAttachment")
	@ResponseBody
	public void deleteAttachment(String id) throws Exception{
		attachmentService.deleteAttachment(id);
	}
	@RequestMapping(value = "/deleteAttachmentFrom")
	public String deleteAttachment(RedirectAttributes redirectAttributes,String id) throws Exception{
		attachmentService.deleteAttachment(id);
		redirectAttributes.addFlashAttribute("msg", "批量删除成功");
		return getAdminUrlPath("/attachment/listAttachment");
	}
	/**
	 * 进行md5验证文件是否已经存在
	 * @param md5
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/md5Check", method = RequestMethod.POST)
	@ResponseBody
	public Attachment md5Check(String md5) throws Exception{
		return FileUtil.md5Check(md5);
	}
	/**
	 * 验证分块的完整性
	 * @param attachment
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/chunkCheck", method = RequestMethod.POST)
	@ResponseBody
	public boolean chunkCheck(Attachment attachment) throws Exception{
		return FileUtil.getWebUploader().chunkCheck(attachment);
	}
	/**
	 * 合并分片文件
	 * @param attachment
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/chunksMerge", method = RequestMethod.POST)
	@ResponseBody
	public Attachment chunksMerge(Attachment attachment) throws Exception{
		return FileUtil.getWebUploader().chunksMerge(attachment);
	}
	/**
	 * 按照文件名称单文件上传
	 * @param request
	 * @param modelMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/uploadFile", method = RequestMethod.POST)   
	@ResponseBody
    public Attachment uploadFile(Attachment attachment,@RequestParam("fileInput") MultipartFile fileInput)throws Exception {
		//如果存在分片数则进行分片上传，反之则单纯文件上传
		if(attachment.getChunks()>0)
			return attachmentService.createChunkAttachment(attachment,fileInput);
		else
			return attachmentService.createAttachment(attachment,fileInput);
	}
	/**
	 * 文件上传
	 * @param modelMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/uploadAttachment", method = RequestMethod.POST)
	@ResponseBody
	public Attachment uploadAttachment(Attachment attachment,@RequestParam("fileInput") MultipartFile fileInput) throws Exception{
		return attachmentService.createAttachment(attachment,fileInput);
	}
	/**
	 * 单文件上传
	 * @param request
	 * @param modelMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/upload", method = RequestMethod.POST)   
	@ResponseBody
    public String upload(ModelMap modelMap)throws Exception { 
		
		return FileUtil.upload();  
	}
	/**
	 * 下载指定Id的文件
	 * @param id
	 * @param modelMap
	 * @throws Exception
	 */
	@RequestMapping(value = "/download")   
    public @ResponseBody void download(String id,ModelMap modelMap)throws Exception { 
		Attachment attachment = attachmentService.findAttachmentById(id);
		FileUtil.download(StringUtils.arrayToDelimitedString(new String[]{attachment.getPath(),attachment.getRealName()}, File.separator), attachment.getName());
	}
	/**
	 * 按照文件路径获取文件流
	 * @param path
	 * @throws Exception 
	 */
	@RequestMapping(value="/readImageStreamPath", method = RequestMethod.GET)
	public String readImageStreamPath(String path, RedirectAttributes redirectAttributes) throws Exception{
		FileUtil.download(path);
		return getAdminUrlPath("/nolayout");
	}
	/**
	 * 按照ID获取图片文件流
	 * @param path
	 * @throws Exception 
	 */
	@RequestMapping(value="/readImageStreamId", method = RequestMethod.GET)
	public byte[] readImageStreamId(String id,HttpServletResponse response) throws Exception{
		if(org.apache.commons.lang3.StringUtils.isNotBlank(id)){
			Attachment attachment = attachmentService.findAttachmentById(id);
			if(ObjectUtils.isEmpty(attachment)||!new File(attachment.getFileFullPath()).exists()){
				return null;
			}
			response.setContentType("application/octet-stream");
			OutputStream out = response.getOutputStream();
			// 建立文件输入流
	        InputStream inputStream = new BufferedInputStream(new FileInputStream(attachment.getFileFullPath()));
			 // 建立文件输出流
	        OutputStream outputStream = new BufferedOutputStream(out);
	        byte[] buffer = new byte[1024];
	        int len = 0;
	        while ((len = inputStream.read(buffer)) > 0) {
	        	outputStream.write(buffer, 0, len);
	        }
	        outputStream.flush();
	        outputStream.close();
	        inputStream.close();
		}
		return null;
	}
}

