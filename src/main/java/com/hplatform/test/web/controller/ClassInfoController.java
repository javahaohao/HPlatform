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
import com.hplatform.test.constants.ClassInfoConstants;
import com.hplatform.test.entity.ClassInfo;
import com.hplatform.test.service.ClassInfoService;

@Controller
@RequestMapping("${adminPath}/classInfo")
public class ClassInfoController extends BaseController {
	@Autowired
	private ClassInfoService classInfoService;
	@ModelAttribute
	public ClassInfo get(@RequestParam(required=false) String id) throws CRUDException {
		return new ClassInfo();
	}
	@RequiresPermissions("classInfo:view")
    @RequestMapping(method = RequestMethod.GET)
    public String list(Model model) throws CRUDException {
        return ClassInfoConstants.LIST;
    }
    @RequiresPermissions("classInfo:view")
    @RequestMapping(value = "/list",method = RequestMethod.POST)
    @ResponseBody
    public Page<ClassInfo> listClassInfoData(ClassInfo classInfo) throws CRUDException {
    	Page.setPageFromRequest();
    	Page<ClassInfo> pageInfo = new Page<ClassInfo>(classInfoService.findAll(classInfo));
        return pageInfo;
    }
	@RequiresPermissions("classInfo:create")
    @RequestMapping(value = "/add", method = RequestMethod.GET)
    public String showCreatFrom(Model model) {
        model.addAttribute("op", "保存");
        return ClassInfoConstants.EDIT;
    }
	@RequiresPermissions("classInfo:create")
    @RequestMapping(value = "/add", method = RequestMethod.POST)
    public String create(ClassInfo classInfo, RedirectAttributes redirectAttributes) throws CRUDException {
		classInfoService.save(classInfo);
        redirectAttributes.addFlashAttribute("msg", "新增成功");
        return getAdminUrlPath("/classInfo");
    }
	@RequiresPermissions("classInfo:update")
    @RequestMapping(value = "/{id}/update", method = RequestMethod.GET)
    public String showUpdateForm(ClassInfo classInfo, Model model) throws CRUDException {
        model.addAttribute("classInfo", classInfoService.findOne(classInfo));
        model.addAttribute("op", "修改");
        return ClassInfoConstants.EDIT;
    }
	@RequiresPermissions("classInfo:update")
    @RequestMapping(value = "/{id}/update", method = RequestMethod.POST)
    public String update(ClassInfo classInfo, RedirectAttributes redirectAttributes) throws CRUDException {
		classInfoService.update(classInfo);;
        redirectAttributes.addFlashAttribute("msg", "修改成功");
        return getAdminUrlPath("/classInfo");
    }
	@RequiresPermissions("classInfo:delete")
    @RequestMapping(value = "/{id}/delete", method = RequestMethod.GET)
    public String delete(ClassInfo classInfo, RedirectAttributes redirectAttributes) throws CRUDException {
		classInfoService.delete(classInfo);
        redirectAttributes.addFlashAttribute("msg", "删除成功");
        return getAdminUrlPath("/classInfo");
    }
	@RequiresPermissions("classInfo:delete")
    @RequestMapping(value = "/deleteBatch", method = RequestMethod.GET)
    public String deleteBatch(ClassInfo classInfo, RedirectAttributes redirectAttributes) throws CRUDException {
		classInfoService.deleteBatch(classInfo);
        redirectAttributes.addFlashAttribute("msg", "批量删除成功");
        return getAdminUrlPath("/classInfo");
    }
}