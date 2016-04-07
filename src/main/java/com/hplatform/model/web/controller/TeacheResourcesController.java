package com.hplatform.model.web.controller;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.hplatform.core.entity.Attachment;
import com.hplatform.core.exception.CRUDException;
import com.hplatform.core.web.controller.BaseController;
import com.hplatform.model.constants.TeacheResourcesConstants;
import com.hplatform.model.entity.TeacheResources;
import com.hplatform.model.service.TeacheResourcesService;

@Controller
@RequestMapping("${adminPath}/teacheResources")
public class TeacheResourcesController extends BaseController {
	@Autowired
	private TeacheResourcesService teacheResourcesService;
	@ModelAttribute
	public TeacheResources get(@RequestParam(required=false) String id) throws CRUDException {
		return new TeacheResources();
	}
	private void setCommonData(Model model) throws CRUDException{
    	model.addAttribute("teacheResourcesList", teacheResourcesService.findAll(new TeacheResources()));
    }
	@RequiresPermissions("teacheResources:view")
    @RequestMapping(method = RequestMethod.GET)
    public String list(Model model) throws CRUDException {
    	setCommonData(model);
        return TeacheResourcesConstants.LIST;
    }
	@RequiresPermissions("teacheResources:create")
    @RequestMapping(value = "/add", method = RequestMethod.GET)
    public String showCreatFrom(Model model) {
        model.addAttribute("op", "保存");
        return TeacheResourcesConstants.EDIT;
    }
	@RequiresPermissions("teacheResources:create")
    @RequestMapping(value = "/add", method = RequestMethod.POST)
    public String create(TeacheResources teacheResources, RedirectAttributes redirectAttributes) throws CRUDException {
		teacheResourcesService.save(teacheResources);
        redirectAttributes.addFlashAttribute("msg", "新增成功");
        return getAdminUrlPath("/teacheResources");
    }
	@RequiresPermissions("teacheResources:update")
    @RequestMapping(value = "/{id}/update", method = RequestMethod.GET)
    public String showUpdateForm(TeacheResources teacheResources, Model model) throws CRUDException {
        model.addAttribute("teacheResources", teacheResourcesService.findOne(teacheResources));
        model.addAttribute("op", "修改");
        return TeacheResourcesConstants.EDIT;
    }
	@RequiresPermissions("teacheResources:update")
    @RequestMapping(value = "/{id}/update", method = RequestMethod.POST)
    public String update(TeacheResources teacheResources, RedirectAttributes redirectAttributes) throws CRUDException {
		teacheResourcesService.update(teacheResources);;
        redirectAttributes.addFlashAttribute("msg", "修改成功");
        return getAdminUrlPath("/teacheResources");
    }
	@RequiresPermissions("teacheResources:delete")
    @RequestMapping(value = "/{id}/delete", method = RequestMethod.GET)
    public String delete(TeacheResources teacheResources, RedirectAttributes redirectAttributes) throws CRUDException {
		teacheResourcesService.delete(teacheResources);
        redirectAttributes.addFlashAttribute("msg", "删除成功");
        return getAdminUrlPath("/teacheResources");
    }
	
	/**
     * 修改资源封面
     * @return
     * @throws CRUDException 
     */
    @RequiresPermissions("teacheResources:create")
    @RequestMapping(value = "/uploadFrontCover", method = RequestMethod.POST)
    @ResponseBody
    public Attachment uploadFrontCover(Attachment attachment,@RequestParam("frontCover")MultipartFile file) throws CRUDException{
    	return teacheResourcesService.updateFrontCover(attachment,file);
    }
}