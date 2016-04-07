package com.hplatform.core.web.controller;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.hplatform.core.entity.Comment;
import com.hplatform.core.exception.CRUDException;
import com.hplatform.core.service.CommentService;

public class CommentController extends BaseController {
	 @Autowired
	    private CommentService commentService;
	    private void setCommonData(Model model) throws CRUDException{
	    	model.addAttribute("commentList", commentService.findAll(new Comment()));
	    }
	    @RequiresPermissions("comment:view")
	    @RequestMapping(method = RequestMethod.GET)
	    public String list(Model model) throws CRUDException {
	        model.addAttribute("commentList", commentService.findAll(new Comment()));
	        return "core/comment/list";
	    }

	    @RequiresPermissions("comment:create")
	    @RequestMapping(value = "/{parentId}/appendChild", method = RequestMethod.GET)
	    public String showAppendChildForm(@PathVariable("parentId") String parentId, Model model) throws CRUDException {
	    	Comment parent = commentService.findOne(parentId);
	        Comment child = new Comment();
	        child.setParentId(parentId);
	        child.setParentIds(parent.makeSelfAsParentIds());
	        model.addAttribute("comment", child);
	        model.addAttribute("op", "新增子节点");
	        setCommonData(model);
	        return "core/comment/edit";
	    }

	    @RequiresPermissions("comment:create")
	    @RequestMapping(value = "/{parentId}/appendChild", method = RequestMethod.POST)
	    public String create(Comment comment, RedirectAttributes redirectAttributes) throws CRUDException {
	        commentService.save(comment);
	        redirectAttributes.addFlashAttribute("msg", "新增子节点成功");
	        return getAdminUrlPath("/comment");
	    }

	    @RequiresPermissions("comment:update")
	    @RequestMapping(value = "/{id}/update", method = RequestMethod.GET)
	    public String showUpdateForm(@PathVariable("id") String id, Model model) throws CRUDException {
	        model.addAttribute("comment", commentService.findOne(id));
	        model.addAttribute("op", "修改");
	        setCommonData(model);
	        return "comment/edit";
	    }

	    @RequiresPermissions("comment:update")
	    @RequestMapping(value = "/{id}/update", method = RequestMethod.POST)
	    public String update(Comment comment, RedirectAttributes redirectAttributes) throws CRUDException {
	        commentService.update(comment);
	        redirectAttributes.addFlashAttribute("msg", "修改成功");
	        return getAdminUrlPath("/comment");
	    }

	    @RequiresPermissions("comment:delete")
	    @RequestMapping(value = "/{id}/delete", method = RequestMethod.GET)
	    public String delete(@PathVariable("id") String id, RedirectAttributes redirectAttributes) throws CRUDException {
	        commentService.deleteComment(id);
	        redirectAttributes.addFlashAttribute("msg", "删除成功");
	        return getAdminUrlPath("/comment");
	    }
}
