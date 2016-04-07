package com.hplatform.core.web.controller;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.hplatform.core.entity.Dict;
import com.hplatform.core.exception.CRUDException;
import com.hplatform.core.service.DictService;

/**
 * 
 * @author JavaDream
 *
 */
@Controller
@RequestMapping("${adminPath}/dict")
public class DictController extends BaseController {

    @Autowired
    private DictService dictService;
    private void setCommonData(Model model) throws CRUDException{
    	model.addAttribute("dictList", dictService.findAll());
    }
    @RequiresPermissions("dict:view")
    @RequestMapping(method = RequestMethod.GET)
    public String list(Model model) throws CRUDException {
        model.addAttribute("dictList", dictService.findAll());
        return "core/dict/list";
    }

    @RequiresPermissions("dict:create")
    @RequestMapping(value = "/{parentId}/appendChild", method = RequestMethod.GET)
    public String showAppendChildForm(@PathVariable("parentId") String parentId, Model model) throws CRUDException {
    	Dict parent = dictService.findOne(parentId);
        Dict child = new Dict();
        child.setParentId(parentId);
        child.setParentIds(parent.makeSelfAsParentIds());
        model.addAttribute("dict", child);
        model.addAttribute("op", "新增子节点");
        setCommonData(model);
        return "core/dict/edit";
    }

    @RequiresPermissions("dict:create")
    @RequestMapping(value = "/{parentId}/appendChild", method = RequestMethod.POST)
    public String create(Dict dict, RedirectAttributes redirectAttributes) throws CRUDException {
        dictService.createDict(dict);
        redirectAttributes.addFlashAttribute("expandNodeId", dict.getParentIds());
        redirectAttributes.addFlashAttribute("msg", "新增子节点成功");
        return getAdminUrlPath("/dict");
    }

    @RequiresPermissions("dict:update")
    @RequestMapping(value = "/{id}/update", method = RequestMethod.GET)
    public String showUpdateForm(@PathVariable("id") String id, Model model) throws CRUDException {
        model.addAttribute("dict", dictService.findOne(id));
        model.addAttribute("op", "修改");
        setCommonData(model);
        return "core/dict/edit";
    }

    @RequiresPermissions("dict:update")
    @RequestMapping(value = "/{id}/update", method = RequestMethod.POST)
    public String update(Dict dict, RedirectAttributes redirectAttributes) throws CRUDException {
        dictService.updateDict(dict);
        redirectAttributes.addFlashAttribute("expandNodeId", dict.getParentIds());
        redirectAttributes.addFlashAttribute("msg", "修改成功");
        return getAdminUrlPath("/dict");
    }

    @RequiresPermissions("dict:delete")
    @RequestMapping(value = "/{id}/delete", method = RequestMethod.GET)
    public String delete(@PathVariable("id") String id, RedirectAttributes redirectAttributes) throws CRUDException {
        dictService.deleteDict(id);
        redirectAttributes.addFlashAttribute("msg", "删除成功");
        return getAdminUrlPath("/dict");
    }

}
