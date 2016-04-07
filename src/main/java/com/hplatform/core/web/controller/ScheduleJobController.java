package com.hplatform.core.web.controller;

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
import com.hplatform.core.web.controller.BaseController;
import com.hplatform.core.constants.ScheduleJobConstants;
import com.hplatform.core.entity.ScheduleJob;
import com.hplatform.core.service.ScheduleJobService;

@Controller
@RequestMapping("${adminPath}/scheduleJob")
public class ScheduleJobController extends BaseController {
	@Autowired
	private ScheduleJobService scheduleJobService;
	@ModelAttribute
	public ScheduleJob get(@RequestParam(required=false) String id) throws CRUDException {
		return new ScheduleJob();
	}
	private void setCommonData(Model model) throws CRUDException{
    	model.addAttribute("scheduleJobList", scheduleJobService.findAll(new ScheduleJob()));
    }
	@RequiresPermissions("scheduleJob:view")
    @RequestMapping(method = RequestMethod.GET)
    public String list(Model model) throws CRUDException {
    	setCommonData(model);
        return ScheduleJobConstants.LIST;
    }
	@RequiresPermissions("scheduleJob:create")
    @RequestMapping(value = "/add", method = RequestMethod.GET)
    public String showCreatFrom(Model model) {
        model.addAttribute("op", "保存");
        return ScheduleJobConstants.EDIT;
    }
	@RequiresPermissions("scheduleJob:create")
    @RequestMapping(value = "/add", method = RequestMethod.POST)
    public String create(ScheduleJob scheduleJob, RedirectAttributes redirectAttributes) throws CRUDException {
		scheduleJobService.save(scheduleJob);
        redirectAttributes.addFlashAttribute("msg", "新增成功");
        return getAdminUrlPath("/scheduleJob");
    }
	@RequiresPermissions("scheduleJob:update")
    @RequestMapping(value = "/{id}/update", method = RequestMethod.GET)
    public String showUpdateForm(ScheduleJob scheduleJob, Model model) throws CRUDException {
        model.addAttribute("scheduleJob", scheduleJobService.findOne(scheduleJob));
        model.addAttribute("op", "修改");
        return ScheduleJobConstants.EDIT;
    }
	@RequiresPermissions("scheduleJob:update")
    @RequestMapping(value = "/{id}/update", method = RequestMethod.POST)
    public String update(ScheduleJob scheduleJob, RedirectAttributes redirectAttributes) throws CRUDException {
		scheduleJobService.update(scheduleJob);;
        redirectAttributes.addFlashAttribute("msg", "修改成功");
        return getAdminUrlPath("/scheduleJob");
    }
	@RequiresPermissions("scheduleJob:delete")
    @RequestMapping(value = "/{id}/delete", method = RequestMethod.GET)
    public String delete(ScheduleJob scheduleJob, RedirectAttributes redirectAttributes) throws CRUDException {
		scheduleJobService.delete(scheduleJob);
        redirectAttributes.addFlashAttribute("msg", "删除成功");
        return getAdminUrlPath("/scheduleJob");
    }
	@RequiresPermissions("scheduleJob:delete")
    @RequestMapping(value = "/deleteBatch", method = RequestMethod.GET)
    public String deleteBatch(ScheduleJob scheduleJob, RedirectAttributes redirectAttributes) throws CRUDException {
		scheduleJobService.deleteBatch(scheduleJob);
        redirectAttributes.addFlashAttribute("msg", "批量删除成功");
        return getAdminUrlPath("/scheduleJob");
    }
}