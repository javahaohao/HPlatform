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
import com.hplatform.test.constants.StuInfoConstants;
import com.hplatform.test.entity.StuInfo;
import com.hplatform.test.service.StuInfoService;
import com.hplatform.test.entity.ClassInfo;
import com.hplatform.test.service.ClassInfoService;

@Controller
@RequestMapping("${adminPath}/stuInfo")
public class StuInfoController extends BaseController {
	@Autowired
	private StuInfoService stuInfoService;
	@Autowired
	private ClassInfoService classInfoService;
	@ModelAttribute
	public StuInfo get(@RequestParam(required=false) String id) throws CRUDException {
		return new StuInfo();
	}
	private void initParents(Model model) throws CRUDException{
        model.addAttribute("parents", classInfoService.findAll(new ClassInfo()));
	}
	@RequiresPermissions("stuInfo:view")
    @RequestMapping(method = RequestMethod.GET)
    public String list(Model model) throws CRUDException {
        return StuInfoConstants.LIST;
    }
    @RequiresPermissions("stuInfo:view")
    @RequestMapping(value = "/list",method = RequestMethod.POST)
    @ResponseBody
    public Page<StuInfo> listStuInfoData(StuInfo stuInfo) throws CRUDException {
    	Page.setPageFromRequest();
    	Page<StuInfo> pageInfo = new Page<StuInfo>(stuInfoService.findAll(stuInfo));
        return pageInfo;
    }
	@RequiresPermissions("stuInfo:create")
    @RequestMapping(value = "/add", method = RequestMethod.GET)
    public String showCreatFrom(Model model)throws CRUDException {
        model.addAttribute("op", "保存");
        initParents(model);
        return StuInfoConstants.EDIT;
    }
	@RequiresPermissions("stuInfo:create")
    @RequestMapping(value = "/add", method = RequestMethod.POST)
    public String create(StuInfo stuInfo, RedirectAttributes redirectAttributes) throws CRUDException {
		stuInfoService.save(stuInfo);
        redirectAttributes.addFlashAttribute("msg", "新增成功");
        return getAdminUrlPath("/stuInfo");
    }
	@RequiresPermissions("stuInfo:update")
    @RequestMapping(value = "/{id}/update", method = RequestMethod.GET)
    public String showUpdateForm(StuInfo stuInfo, Model model) throws CRUDException {
        model.addAttribute("stuInfo", stuInfoService.findOne(stuInfo));
        model.addAttribute("op", "修改");
        initParents(model);
        return StuInfoConstants.EDIT;
    }
	@RequiresPermissions("stuInfo:update")
    @RequestMapping(value = "/{id}/update", method = RequestMethod.POST)
    public String update(StuInfo stuInfo, RedirectAttributes redirectAttributes) throws CRUDException {
		stuInfoService.update(stuInfo);;
        redirectAttributes.addFlashAttribute("msg", "修改成功");
        return getAdminUrlPath("/stuInfo");
    }
	@RequiresPermissions("stuInfo:delete")
    @RequestMapping(value = "/{id}/delete", method = RequestMethod.GET)
    public String delete(StuInfo stuInfo, RedirectAttributes redirectAttributes) throws CRUDException {
		stuInfoService.delete(stuInfo);
        redirectAttributes.addFlashAttribute("msg", "删除成功");
        return getAdminUrlPath("/stuInfo");
    }
	@RequiresPermissions("stuInfo:delete")
    @RequestMapping(value = "/deleteBatch", method = RequestMethod.GET)
    public String deleteBatch(StuInfo stuInfo, RedirectAttributes redirectAttributes) throws CRUDException {
		stuInfoService.deleteBatch(stuInfo);
        redirectAttributes.addFlashAttribute("msg", "批量删除成功");
        return getAdminUrlPath("/stuInfo");
    }
}