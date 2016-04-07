package com.hplatform.model.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.hplatform.core.common.util.SpringUtils;
import com.hplatform.core.entity.Attachment;
import com.hplatform.core.service.AttachmentService;
import com.hplatform.core.web.controller.BaseController;
@Controller
@RequestMapping(value="${adminPath}/plugins")
public class PluginsController extends BaseController {
	/**
	 * 上传控件
	 * @param modelMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/dropzone")
	public String dropzone(ModelMap modelMap) throws Exception{
		return "plugins/dropzone";
	}
	/**
	 * webuploader上传控件
	 * @param modelMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/webuploader")
	public String webuploader(ModelMap modelMap) throws Exception{
		modelMap.put("attachmentList", SpringUtils.getBean(AttachmentService.class).findAll(new Attachment()));
		return "plugins/webuploader";
	}
	/**
	 * icon控件
	 * @param modelMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/icon")
	public String icon(ModelMap modelMap) throws Exception{
		return "plugins/icon";
	}
	/**
	 * 页面缓存
	 * @param modelMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/pagecache")
	public String pagecache(ModelMap modelMap) throws Exception{
		return "plugins/pagecache";
	}
}
