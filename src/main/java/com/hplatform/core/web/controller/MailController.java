package com.hplatform.core.web.controller;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.hplatform.core.constants.MailConstants;
import com.hplatform.core.entity.Mail;
import com.hplatform.core.exception.CRUDException;
import com.hplatform.core.service.MailService;

@Controller
@RequestMapping("${adminPath}/mail")
public class MailController extends BaseController {
	@Autowired
	private MailService mailService;
	private void setCommonData(Model model) throws CRUDException{
    	model.addAttribute("mailList", mailService.findAll(new Mail()));
    }
	@RequiresPermissions("mail:view")
    @RequestMapping(method = RequestMethod.GET)
    public String list(Model model) throws CRUDException {
    	setCommonData(model);
        return MailConstants.LIST;
    }
	@RequiresPermissions("mail:create")
    @RequestMapping(value = "/{parentId}/add", method = RequestMethod.GET)
    public String showCreatFrom(Model model) {
        model.addAttribute("op", "新增");
        return MailConstants.EDIT;
    }
	@RequiresPermissions("mail:create")
    @RequestMapping(value = "/{parentId}/save", method = RequestMethod.POST)
    public String create(Mail mail, RedirectAttributes redirectAttributes) throws CRUDException {
		mailService.save(mail);
        redirectAttributes.addFlashAttribute("msg", "新增成功");
        return getAdminUrlPath("/mail");
    }
	@RequiresPermissions("mail:update")
    @RequestMapping(value = "/{id}/update", method = RequestMethod.GET)
    public String showUpdateForm(Mail mail, Model model) throws CRUDException {
        model.addAttribute("mail", mailService.findOne(mail));
        model.addAttribute("op", "修改");
        return MailConstants.EDIT;
    }
	@RequiresPermissions("mail:update")
    @RequestMapping(value = "/{id}/update", method = RequestMethod.POST)
    public String update(Mail mail, RedirectAttributes redirectAttributes) throws CRUDException {
		mailService.update(mail);;
        redirectAttributes.addFlashAttribute("msg", "修改成功");
        return getAdminUrlPath("/mail");
    }
	@RequiresPermissions("mail:delete")
    @RequestMapping(value = "/{id}/delete", method = RequestMethod.GET)
    public String delete(Mail mail, RedirectAttributes redirectAttributes) throws CRUDException {
		mailService.delete(mail);
        redirectAttributes.addFlashAttribute("msg", "删除成功");
        return getAdminUrlPath("/mail");
    }
}
