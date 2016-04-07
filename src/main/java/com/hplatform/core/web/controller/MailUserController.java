package com.hplatform.core.web.controller;

import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.hplatform.core.constants.MailUserConstants;
import com.hplatform.core.entity.MailDict;
import com.hplatform.core.entity.MailUser;
import com.hplatform.core.exception.CRUDException;
import com.hplatform.core.service.MailDictService;
import com.hplatform.core.service.MailUserService;

@Controller
@RequestMapping("${adminPath}/mailUser")
public class MailUserController extends BaseController {
	@Autowired
	private MailUserService mailUserService;
	@Autowired
	private MailDictService mailDictService;
	@ModelAttribute
	public MailUser get(@RequestParam(required=false) String id) throws CRUDException {
		if (StringUtils.isNotBlank(id)){
			MailUser mailUser = new MailUser();
			mailUser.setId(id);
			return mailUserService.findOne(mailUser);
		}else{
			return new MailUser();
		}
	}
	private void setCommonData(Model model) throws CRUDException{
    	model.addAttribute("mailUserList", mailUserService.findAll(new MailUser()));
    }
	@RequiresPermissions("mailUser:view")
    @RequestMapping(method = RequestMethod.GET)
    public String list(Model model) throws CRUDException {
    	setCommonData(model);
        return MailUserConstants.LIST;
    }
	@RequiresPermissions("mailUser:create")
    @RequestMapping(value = "/add", method = RequestMethod.GET)
    public String showCreatFrom(Model model) throws CRUDException {
        model.addAttribute("op", "新增");
        model.addAttribute("mailDictList", mailDictService.findAll(new MailDict()));
        return MailUserConstants.EDIT;
    }
	@RequiresPermissions("mailUser:create")
    @RequestMapping(value = "/add", method = RequestMethod.POST)
    public String create(MailUser mailUser, RedirectAttributes redirectAttributes) throws CRUDException {
		mailUserService.save(mailUser);
        redirectAttributes.addFlashAttribute("msg", "新增成功");
        return getAdminUrlPath("/mailUser");
    }
	@RequiresPermissions("mailUser:update")
    @RequestMapping(value = "/{id}/update", method = RequestMethod.GET)
    public String showUpdateForm(MailUser mailUser, Model model) throws CRUDException {
        model.addAttribute("mailUser", mailUserService.findOne(mailUser));
        model.addAttribute("mailDictList", mailDictService.findAll(new MailDict()));
        model.addAttribute("op", "修改");
        return MailUserConstants.EDIT;
    }
	@RequiresPermissions("mailUser:update")
    @RequestMapping(value = "/{id}/update", method = RequestMethod.POST)
    public String update(MailUser mailUser, RedirectAttributes redirectAttributes) throws CRUDException {
		mailUserService.update(mailUser);;
        redirectAttributes.addFlashAttribute("msg", "修改成功");
        return getAdminUrlPath("/mailUser");
    }
	@RequiresPermissions("mailUser:delete")
    @RequestMapping(value = "/{id}/delete", method = RequestMethod.GET)
    public String delete(MailUser mailUser, RedirectAttributes redirectAttributes) throws CRUDException {
		mailUserService.delete(mailUser);
        redirectAttributes.addFlashAttribute("msg", "删除成功");
        return getAdminUrlPath("/mailUser");
    }
	@RequiresPermissions("mailUser:delete")
	@RequestMapping(value = "/deleteBatch", method = RequestMethod.GET)
	public String deleteBatch(MailUser mailUser, RedirectAttributes redirectAttributes) throws CRUDException {
		mailUserService.deleteBatch(mailUser);
		redirectAttributes.addFlashAttribute("msg", "批量删除成功");
		return getAdminUrlPath("/mailUser");
	}
}
