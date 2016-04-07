package com.hplatform.model.web.controller;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.hplatform.core.exception.CRUDException;
import com.hplatform.core.web.controller.BaseController;
import com.hplatform.model.constants.ResumeConstants;
import com.hplatform.model.entity.Resume;
import com.hplatform.model.service.ResumeService;
@Controller
@RequestMapping("${adminPath}/resume")
public class ResumeController extends BaseController {
	@Autowired
	private ResumeService resumeService;
	
	@RequiresPermissions("resume:view")
    @RequestMapping(method = RequestMethod.GET)
    public String list(Model model) throws CRUDException {
        model.addAttribute("resumeList", resumeService.findAll(new Resume()));
        return ResumeConstants.LIST;
    }

    @RequiresPermissions("resume:create")
    @RequestMapping(value = "/create", method = RequestMethod.GET)
    public String showCreateForm(Model model) {
        model.addAttribute("resume", new Resume());
        model.addAttribute("op", "保存");
        return ResumeConstants.EDIT;
    }

    @RequiresPermissions("user:info")
    @RequestMapping(value = "/create", method = RequestMethod.POST)
    public String create(Resume resume, RedirectAttributes redirectAttributes) throws CRUDException {
        resumeService.save(resume);
        redirectAttributes.addFlashAttribute("msg", "保存成功");
        return getAdminUrlPath("/user/userinfo");
    }

    @RequiresPermissions("resume:update")
    @RequestMapping(value = "/{id}/update", method = RequestMethod.GET)
    public String showUpdateForm(Resume resume, Model model) throws CRUDException {
        model.addAttribute("resume", resumeService.findOne(resume));
        model.addAttribute("op", "修改");
        return ResumeConstants.EDIT;
    }

    @RequiresPermissions("user:info")
    @RequestMapping(value = "/update", method = RequestMethod.POST)
    public String update(Resume resume, RedirectAttributes redirectAttributes) throws CRUDException {
        resumeService.update(resume);
        redirectAttributes.addFlashAttribute("msg", "修改成功");
        return getAdminUrlPath("/user/userinfo");
    }

    @RequiresPermissions("resume:delete")
    @RequestMapping(value = "/delete", method = RequestMethod.GET)
    public String delete(Resume resume, RedirectAttributes redirectAttributes) throws CRUDException {
        resumeService.delete(resume);
        redirectAttributes.addFlashAttribute("msg", "删除成功");
        return getAdminUrlPath("/resume");
    }
    
    @RequiresPermissions("resume:delete")
    @RequestMapping(value = "/deleteBatch", method = RequestMethod.GET)
    public String deleteBatch(Resume resume, RedirectAttributes redirectAttributes) throws CRUDException {
    	resumeService.deleteBatch(resume);
    	redirectAttributes.addFlashAttribute("msg", "批量删除成功");
    	return getAdminUrlPath("/resume");
    }
}
