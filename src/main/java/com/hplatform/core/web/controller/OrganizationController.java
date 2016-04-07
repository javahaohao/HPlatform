package com.hplatform.core.web.controller;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.hplatform.core.entity.Organization;
import com.hplatform.core.exception.CRUDException;
import com.hplatform.core.service.OrganizationService;

@Controller
@RequestMapping("${adminPath}/organization")
public class OrganizationController extends BaseController {

    @Autowired
    private OrganizationService organizationService;

    public void setCommonData(Model model){
    	model.addAttribute("organizationList", organizationService.findAll());
    }
    @RequiresPermissions("organization:view")
    @RequestMapping(value = "", method = RequestMethod.GET)
    public String showTree(Model model) {
    	setCommonData(model);
        return "core/organization/list";
    }

    @RequiresPermissions("organization:create")
    @RequestMapping(value = "/{parentId}/appendChild", method = RequestMethod.GET)
    public String showAppendChildForm(@PathVariable("parentId") String parentId, Model model) {
        Organization parent = organizationService.findOne(parentId);
        Organization child = new Organization();
        child.setParentId(parentId);
        child.setParentIds(parent.makeSelfAsParentIds());
        model.addAttribute("organization", child);
        model.addAttribute("op", "新增");
        setCommonData(model);
        return "core/organization/edit";
    }

    @RequiresPermissions("organization:create")
    @RequestMapping(value = "/{parentId}/appendChild", method = RequestMethod.POST)
    public String create(Organization organization, RedirectAttributes redirectAttributes) throws CRUDException {
        organizationService.createOrganization(organization);
        redirectAttributes.addFlashAttribute("msg", "新增子节点成功");
        return "redirect:/organization";
    }

    @RequiresPermissions("organization:update")
    @RequestMapping(value = "/{id}/update", method = RequestMethod.GET)
    public String showMaintainForm(@PathVariable("id") String id, Model model) {
        model.addAttribute("organization", organizationService.findOne(id));
        model.addAttribute("op", "修改");
        setCommonData(model);
        return "core/organization/edit";
    }

    @RequiresPermissions("organization:update")
    @RequestMapping(value = "/{id}/update", method = RequestMethod.POST)
    public String update(Organization organization, RedirectAttributes redirectAttributes) {
        organizationService.updateOrganization(organization);
        redirectAttributes.addFlashAttribute("msg", "修改成功");
        return getAdminUrlPath("/organization");
    }

    @RequiresPermissions("organization:delete")
    @RequestMapping(value = "/{id}/delete", method = RequestMethod.GET)
    public String delete(@PathVariable("id") String id, RedirectAttributes redirectAttributes) {
        organizationService.deleteOrganization(id);
        redirectAttributes.addFlashAttribute("msg", "删除成功");
        return getAdminUrlPath("/organization");
    }
}
