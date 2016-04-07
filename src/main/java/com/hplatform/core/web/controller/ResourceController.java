package com.hplatform.core.web.controller;

import com.hplatform.core.entity.Resource;
import com.hplatform.core.exception.CRUDException;
import com.hplatform.core.service.ResourceService;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("${adminPath}/resource")
public class ResourceController extends BaseController {

    @Autowired
    private ResourceService resourceService;

    private void setCommonData(Model model){
    	model.addAttribute("resourceList", resourceService.findAll());
    }
    
    @ModelAttribute("types")
    public Resource.ResourceType[] resourceTypes() {
        return Resource.ResourceType.values();
    }

    @RequiresPermissions("resource:view")
    @RequestMapping(method = RequestMethod.GET)
    public String list(Model model) {
    	setCommonData(model);
        return "core/resource/list";
    }

    @RequiresPermissions("resource:create")
    @RequestMapping(value = "/{parentId}/appendChild", method = RequestMethod.GET)
    public String showAppendChildForm(@PathVariable("parentId") String parentId, Model model) {
        Resource parent = resourceService.findOne(parentId);
        Resource child = new Resource();
        child.setParentId(parentId);
        child.setParentIds(parent.makeSelfAsParentIds());
        model.addAttribute("resource", child);
        model.addAttribute("op", "保存");
        setCommonData(model);
        return "core/resource/edit";
    }

    @RequiresPermissions("resource:create")
    @RequestMapping(value = "/{parentId}/appendChild", method = RequestMethod.POST)
    public String create(Resource resource, RedirectAttributes redirectAttributes) throws CRUDException {
        resourceService.createResource(resource);
        redirectAttributes.addFlashAttribute("msg", "保存子节点成功");
        redirectAttributes.addFlashAttribute("expandNodeId", resource.getParentIds());
        return getAdminUrlPath("/resource");
    }

    @RequiresPermissions("resource:update")
    @RequestMapping(value = "/{id}/update", method = RequestMethod.GET)
    public String showUpdateForm(@PathVariable("id") String id, Model model) {
        model.addAttribute("resource", resourceService.findOne(id));
        model.addAttribute("op", "修改");
        setCommonData(model);
        return "core/resource/edit";
    }

    @RequiresPermissions("resource:update")
    @RequestMapping(value = "/{id}/update", method = RequestMethod.POST)
    public String update(Resource resource, RedirectAttributes redirectAttributes) {
        resourceService.updateResource(resource);
        redirectAttributes.addFlashAttribute("expandNodeId", resource.getParentIds());
        redirectAttributes.addFlashAttribute("msg", "修改成功");
        return getAdminUrlPath("/resource");
    }

    @RequiresPermissions("resource:delete")
    @RequestMapping(value = "/{id}/delete", method = RequestMethod.GET)
    public String delete(@PathVariable("id") String id, RedirectAttributes redirectAttributes) {
        resourceService.deleteResource(id);
        redirectAttributes.addFlashAttribute("msg", "删除成功");
        return getAdminUrlPath("/resource");
    }


}
