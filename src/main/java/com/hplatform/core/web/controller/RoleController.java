package com.hplatform.core.web.controller;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.hplatform.core.entity.Role;
import com.hplatform.core.service.ResourceService;
import com.hplatform.core.service.RoleService;

@Controller
@RequestMapping("${adminPath}/role")
public class RoleController extends BaseController {

    @Autowired
    private RoleService roleService;

    @Autowired
    private ResourceService resourceService;

    @RequiresPermissions("role:view")
    @RequestMapping(method = RequestMethod.GET)
    public String list(Model model) {
        model.addAttribute("roleList", roleService.findAll());
        return "core/role/list";
    }

    @RequiresPermissions("role:create")
    @RequestMapping(value = "/create", method = RequestMethod.GET)
    public String showCreateForm(Model model) {
        setCommonData(model);
        model.addAttribute("role", new Role());
        model.addAttribute("op", "保存");
        return "core/role/edit";
    }

    @RequiresPermissions("role:create")
    @RequestMapping(value = "/create", method = RequestMethod.POST)
    public String create(Role role, RedirectAttributes redirectAttributes) {
        roleService.createRole(role);
        redirectAttributes.addFlashAttribute("msg", "保存成功");
        return getAdminUrlPath("/role");
    }

    @RequiresPermissions("role:update")
    @RequestMapping(value = "/{id}/update", method = RequestMethod.GET)
    public String showUpdateForm(Role role, Model model) {
        setCommonData(model);
        model.addAttribute("role", roleService.findOne(role));
        model.addAttribute("op", "修改");
        return "core/role/edit";
    }

    @RequiresPermissions("role:update")
    @RequestMapping(value = "/{id}/update", method = RequestMethod.POST)
    public String update(Role role, RedirectAttributes redirectAttributes) {
        roleService.updateRole(role);
        redirectAttributes.addFlashAttribute("msg", "修改成功");
        return getAdminUrlPath("/role");
    }

    @RequiresPermissions("role:delete")
    @RequestMapping(value = "/delete", method = RequestMethod.GET)
    public String delete(Role role, RedirectAttributes redirectAttributes) {
        roleService.deleteRole(role);
        redirectAttributes.addFlashAttribute("msg", "删除成功");
        return getAdminUrlPath("/role");
    }
    
    @RequiresPermissions("role:delete")
    @RequestMapping(value = "/deleteBatch", method = RequestMethod.GET)
    public String deleteBatch(Role role, RedirectAttributes redirectAttributes) {
    	roleService.deleteBatchEntity(role);
    	redirectAttributes.addFlashAttribute("msg", "批量删除成功");
    	return getAdminUrlPath("/role");
    }

    private void setCommonData(Model model) {
        model.addAttribute("resourceList", resourceService.findAll());
    }

}
