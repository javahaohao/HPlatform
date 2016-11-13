package com.hplatform.test.web.controller;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import com.hplatform.core.exception.CRUDException;
import org.springframework.web.bind.annotation.ResponseBody;
import com.hplatform.core.web.controller.BaseController;
import com.hplatform.core.entity.Page;
import com.hplatform.test.constants.SingleConstants;
import com.hplatform.test.entity.Single;
import com.hplatform.test.service.SingleService;

@Controller
@RequestMapping("${adminPath}/single")
public class SingleController extends BaseController {
	@Autowired
	private SingleService singleService;
	@ModelAttribute
	public Single get(@RequestParam(required=false) String id) throws CRUDException {
		return new Single();
	}
	@RequiresPermissions("single:view")
    @RequestMapping(method = RequestMethod.GET)
    public String list(Model model) throws CRUDException {
        return SingleConstants.LIST;
    }
    @RequiresPermissions("single:view")
    @RequestMapping(value = "/list",method = RequestMethod.POST)
    @ResponseBody
    public Page<Single> listSingleData(Single single) throws CRUDException {
    	Page.setPageFromRequest();
    	Page<Single> pageInfo = new Page<Single>(singleService.findAll(single));
        return pageInfo;
    }
	@RequiresPermissions("single:create")
    @RequestMapping(value = "/add", method = RequestMethod.GET)
    public String showCreatFrom(Model model) {
        model.addAttribute("op", "保存");
        return SingleConstants.EDIT;
    }
	@RequiresPermissions("single:create")
    @RequestMapping(value = "/add", method = RequestMethod.POST)
    public String create(Single single, RedirectAttributes redirectAttributes) throws CRUDException {
		singleService.save(single);
        redirectAttributes.addFlashAttribute("msg", "新增成功");
        return getAdminUrlPath("/single");
    }
	@RequiresPermissions("single:update")
    @RequestMapping(value = "/{id}/update", method = RequestMethod.GET)
    public String showUpdateForm(Single single, Model model) throws CRUDException {
        model.addAttribute("single", singleService.findOne(single));
        model.addAttribute("op", "修改");
        return SingleConstants.EDIT;
    }
	@RequiresPermissions("single:update")
    @RequestMapping(value = "/{id}/update", method = RequestMethod.POST)
    public String update(Single single, RedirectAttributes redirectAttributes) throws CRUDException {
		singleService.update(single);;
        redirectAttributes.addFlashAttribute("msg", "修改成功");
        return getAdminUrlPath("/single");
    }
	@RequiresPermissions("single:delete")
    @RequestMapping(value = "/{id}/delete", method = RequestMethod.GET)
    public String delete(Single single, RedirectAttributes redirectAttributes) throws CRUDException {
		singleService.delete(single);
        redirectAttributes.addFlashAttribute("msg", "删除成功");
        return getAdminUrlPath("/single");
    }
	@RequiresPermissions("single:delete")
    @RequestMapping(value = "/deleteBatch", method = RequestMethod.GET)
    public String deleteBatch(Single single, RedirectAttributes redirectAttributes) throws CRUDException {
		singleService.deleteBatch(single);
        redirectAttributes.addFlashAttribute("msg", "批量删除成功");
        return getAdminUrlPath("/single");
    }
}