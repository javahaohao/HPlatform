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

import com.hplatform.core.common.util.ConstantsUtil;
import com.hplatform.core.constants.NewsConstants;
import com.hplatform.core.entity.News;
import com.hplatform.core.exception.CRUDException;
import com.hplatform.core.service.DictService;
import com.hplatform.core.service.NewsService;

@Controller
@RequestMapping("${adminPath}/news")
public class NewsController extends BaseController {
	@Autowired
	private NewsService newsService;
	@Autowired
	private DictService dictService;
	@ModelAttribute
	public News get(@RequestParam(required=false) String id) throws CRUDException {
		return new News();
	}
	private void setCommonData(Model model) throws CRUDException{
    	model.addAttribute("typeList", dictService.findChildDictById(ConstantsUtil.get().DICT_NEWS_TYPE_PARENT_ID));
    	model.addAttribute("sourceList", dictService.findChildDictById(ConstantsUtil.get().DICT_NEWS_SOURCE_PARENT_ID));
    }
	@RequiresPermissions("news:view")
    @RequestMapping(method = RequestMethod.GET)
    public String list(Model model) throws CRUDException {
		model.addAttribute("newsList", newsService.findAll(new News()));
        return NewsConstants.LIST;
    }
	@RequiresPermissions("news:create")
    @RequestMapping(value = "/add", method = RequestMethod.GET)
    public String showCreatFrom(Model model) throws CRUDException {
        model.addAttribute("op", "新增");
        setCommonData(model);
        return NewsConstants.EDIT;
    }
	@RequiresPermissions("news:create")
    @RequestMapping(value = "/add", method = RequestMethod.POST)
    public String create(News news, RedirectAttributes redirectAttributes) throws CRUDException {
		newsService.save(news);
        redirectAttributes.addFlashAttribute("msg", "新增成功");
        return getAdminUrlPath("/news");
    }
	@RequiresPermissions("news:update")
    @RequestMapping(value = "/{id}/update", method = RequestMethod.GET)
    public String showUpdateForm(News news, Model model) throws CRUDException {
        model.addAttribute("news", newsService.findOne(news));
        model.addAttribute("op", "修改");
        setCommonData(model);
        return NewsConstants.EDIT;
    }
	@RequiresPermissions("news:update")
    @RequestMapping(value = "/{id}/update", method = RequestMethod.POST)
    public String update(News news, RedirectAttributes redirectAttributes) throws CRUDException {
		newsService.update(news);
        redirectAttributes.addFlashAttribute("msg", "修改成功");
        return getAdminUrlPath("/news");
    }
	@RequiresPermissions("news:update")
    @RequestMapping(value = "/updateStatus", method = RequestMethod.POST)
    public String updateStatus(News news, RedirectAttributes redirectAttributes) throws CRUDException {
		newsService.updateBatchStatus(news);
        redirectAttributes.addFlashAttribute("msg", "修改成功");
        return getAdminUrlPath("/news");
    }
	@RequiresPermissions("news:delete")
    @RequestMapping(value = "/{id}/delete", method = RequestMethod.GET)
    public String delete(News news, RedirectAttributes redirectAttributes) throws CRUDException {
		newsService.delete(news);
        redirectAttributes.addFlashAttribute("msg", "删除成功");
        return getAdminUrlPath("/news");
    }
	@RequiresPermissions("news:delete")
    @RequestMapping(value = "/deleteBatch", method = RequestMethod.GET)
    public String deleteBatch(News news, RedirectAttributes redirectAttributes) throws CRUDException {
		newsService.deleteBatch(news);
        redirectAttributes.addFlashAttribute("msg", "批量删除成功");
        return getAdminUrlPath("/news");
    }
	//查询带有评论信息的新闻
	@RequiresPermissions("news:view")
    @RequestMapping(value = "/{id}/viewComment", method = RequestMethod.GET)
    public String findNewsWithComment(News news, Model model) throws CRUDException {
		model.addAttribute("news", newsService.findNewsWithComment(news));
        return NewsConstants.NEWS_COMMENT;
    }
}
