package com.hplatform.core.web.controller;

import java.util.List;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.hplatform.core.constants.TagsConstants;
import com.hplatform.core.entity.Element;
import com.hplatform.core.entity.Page;
import com.hplatform.core.entity.Table;
import com.hplatform.core.entity.Tags;
import com.hplatform.core.exception.CRUDException;
import com.hplatform.core.service.ElementService;
import com.hplatform.core.service.TagsService;

@Controller
@RequestMapping("${adminPath}/tags")
public class TagsController extends BaseController {
	@Autowired
	private TagsService tagsService;
	@Autowired
	private ElementService elementService;
	@ModelAttribute
	public Tags get(@RequestParam(required=false) String id){
		return new Tags();
	}
	@RequiresPermissions("tags:view")
    @RequestMapping(method = RequestMethod.GET)
    public String list() throws CRUDException {
        return TagsConstants.LIST;
    }
    
    @RequiresPermissions("tags:view")
    @RequestMapping(value = "/list",method = RequestMethod.POST)
    @ResponseBody
    public Page<Tags> listData(Tags tags) throws CRUDException {
        return tagsService.findAllByPage(tags);
    }
	@RequiresPermissions("tags:create")
    @RequestMapping(value = "/add", method = RequestMethod.GET)
    public String showCreatFrom(Model model) {
        model.addAttribute("op", "保存");
        return TagsConstants.EDIT;
    }
	@RequiresPermissions("tags:create")
    @RequestMapping(value = "/add", method = RequestMethod.POST)
    public String create(Tags tags, RedirectAttributes redirectAttributes) throws CRUDException {
		tagsService.save(tags);
        redirectAttributes.addFlashAttribute("msg", "新增成功");
        return getAdminUrlPath("/tags");
    }
	@RequiresPermissions("tags:update")
    @RequestMapping(value = "/{id}/update", method = RequestMethod.GET)
    public String showUpdateForm(Tags tags, Model model) throws CRUDException {
        model.addAttribute("tags", tagsService.findOne(tags));
        model.addAttribute("op", "修改");
        return TagsConstants.EDIT;
    }
	@RequiresPermissions("tags:update")
    @RequestMapping(value = "/{id}/update", method = RequestMethod.POST)
    public String update(Tags tags, RedirectAttributes redirectAttributes) throws CRUDException {
		tagsService.update(tags);;
        redirectAttributes.addFlashAttribute("msg", "修改成功");
        return getAdminUrlPath("/tags");
    }
	@RequiresPermissions("tags:delete")
    @RequestMapping(value = "/{id}/delete", method = RequestMethod.GET)
    public String delete(Tags tags, RedirectAttributes redirectAttributes) throws CRUDException {
		tagsService.delete(tags);
        redirectAttributes.addFlashAttribute("msg", "删除成功");
        return getAdminUrlPath("/tags");
    }
	@RequiresPermissions("tags:delete")
    @RequestMapping(value = "/deleteBatch", method = RequestMethod.GET)
    public String deleteBatch(Tags tags, RedirectAttributes redirectAttributes) throws CRUDException {
		tagsService.deleteBatch(tags);
        redirectAttributes.addFlashAttribute("msg", "批量删除成功");
        return getAdminUrlPath("/tags");
    }
	/**
	 * 跳转到标签元素列表页面
	 * @param element
	 * @param model
	 * @return
	 * @throws CRUDException
	 */
	@RequiresPermissions("tags:view")
    @RequestMapping(value = "/{tagId}/viewElement",method = RequestMethod.GET)
    public String viewElement(Element element,Model model) throws CRUDException {
		model.addAttribute("elementList", elementService.findAll(element));
		model.addAttribute("tagId", element.getTagId());
        return TagsConstants.LISTELEMENTS;
    }
	/**
	 * 定义标签元素
	 * @param tags
	 * @param redirectAttributes
	 * @return
	 * @throws CRUDException
	 */
	@RequiresPermissions("tags:create")
    @RequestMapping(value = "/editElement",method = RequestMethod.POST)
    public String editElement(Tags tags, RedirectAttributes redirectAttributes) throws CRUDException {
		elementService.editElement(tags);
		redirectAttributes.addFlashAttribute("msg", "元素保存成功！");
        return getAdminUrlPath("/tags");
    }
	/**
	 * 按照标签加载可设置的元素
	 * @param element
	 * @return
	 * @throws CRUDException
	 */
	@RequiresPermissions("tags:view")
    @RequestMapping(value = "/loadElements",method = RequestMethod.POST)
	@ResponseBody
    public List<Element> loadElements(Element element) throws CRUDException {
		return elementService.findAll(element);
    }
	/**
	 * 删除element
	 * @param element
	 * @throws CRUDException
	 */
	@RequiresPermissions("tags:delete")
    @RequestMapping(value = "/deleteElement",method = RequestMethod.POST)
	@ResponseBody
    public String deleteElement(Element element) throws CRUDException {
		elementService.delete(element);
		return "";
    }
	/**
	 * 批量修改sequence
	 * @param tagList
	 * @throws CRUDException
	 */
	@RequiresPermissions("tags:update")
    @RequestMapping(value = "/updateSequence",method = RequestMethod.POST)
    public String updateSequence(Table table, RedirectAttributes redirectAttributes) throws CRUDException {
		for(Tags tags : table.getTagList()){
			tagsService.update(tags);
		}
		redirectAttributes.addFlashAttribute("msg", "排序成功");
        return getAdminUrlPath("/tags");
    }
}