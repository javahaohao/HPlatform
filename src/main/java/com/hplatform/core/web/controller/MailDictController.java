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

import com.hplatform.core.constants.MailDictConstants;
import com.hplatform.core.entity.MailDict;
import com.hplatform.core.exception.CRUDException;
import com.hplatform.core.service.MailDictService;

@Controller
@RequestMapping("${adminPath}/mailDict")
public class MailDictController extends BaseController{
	@Autowired
	private MailDictService mailDictService;
	@ModelAttribute
	public MailDict get(@RequestParam(required=false) String id) throws CRUDException {
		if (StringUtils.isNotBlank(id)){
			MailDict mailDict = new MailDict();
			mailDict.setId(id);
			return mailDictService.findOne(mailDict);
		}else{
			return new MailDict();
		}
	}
	private void setCommonData(Model model) throws CRUDException{
    	model.addAttribute("mailDictList", mailDictService.findAll(new MailDict()));
    }
	@RequiresPermissions("mailDict:view")
    @RequestMapping(method = RequestMethod.GET)
    public String list(Model model) throws CRUDException {
    	setCommonData(model);
        return MailDictConstants.LIST;
    }
	@RequiresPermissions("mailDict:create")
    @RequestMapping(value = "/add", method = RequestMethod.GET)
    public String showCreatFrom(Model model) {
        model.addAttribute("op", "新增");
        return MailDictConstants.EDIT;
    }
	@RequiresPermissions("mailDict:create")
    @RequestMapping(value = "/add", method = RequestMethod.POST)
    public String create(MailDict mailDict, RedirectAttributes redirectAttributes) throws CRUDException {
		mailDictService.save(mailDict);
        redirectAttributes.addFlashAttribute("msg", "新增成功");
        return getAdminUrlPath("/mailDict");
    }
	@RequiresPermissions("mailDict:update")
    @RequestMapping(value = "/{id}/update", method = RequestMethod.GET)
    public String showUpdateForm(MailDict mailDict, Model model) throws CRUDException {
        model.addAttribute("mailDict", mailDictService.findOne(mailDict));
        model.addAttribute("op", "修改");
        return MailDictConstants.EDIT;
    }
	@RequiresPermissions("mailDict:update")
    @RequestMapping(value = "/{id}/update", method = RequestMethod.POST)
    public String update(MailDict mailDict, RedirectAttributes redirectAttributes) throws CRUDException {
		mailDictService.update(mailDict);;
        redirectAttributes.addFlashAttribute("msg", "修改成功");
        return getAdminUrlPath("/mailDict");
    }
	@RequiresPermissions("mailDict:delete")
    @RequestMapping(value = "/{id}/delete", method = RequestMethod.GET)
    public String delete(MailDict mailDict, RedirectAttributes redirectAttributes) throws CRUDException {
		mailDictService.delete(mailDict);
        redirectAttributes.addFlashAttribute("msg", "删除成功");
        return getAdminUrlPath("/mailDict");
    }
	@RequiresPermissions("mailDict:delete")
    @RequestMapping(value = "/deleteBatch", method = RequestMethod.GET)
    public String deleteBatch(MailDict mailDict, RedirectAttributes redirectAttributes) throws CRUDException {
		mailDictService.deleteBatch(mailDict);
        redirectAttributes.addFlashAttribute("msg", "批量删除成功");
        return getAdminUrlPath("/mailDict");
    }
}
