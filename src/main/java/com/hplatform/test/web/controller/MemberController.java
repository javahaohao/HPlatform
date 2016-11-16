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
import com.hplatform.test.constants.MemberConstants;
import com.hplatform.test.entity.Member;
import com.hplatform.test.service.MemberService;

@Controller
@RequestMapping("${adminPath}/member")
public class MemberController extends BaseController {
	@Autowired
	private MemberService memberService;
	@ModelAttribute
	public Member get(@RequestParam(required=false) String id) throws CRUDException {
		return new Member();
	}
	@RequiresPermissions("member:view")
    @RequestMapping(method = RequestMethod.GET)
    public String list(Model model) throws CRUDException {
        return MemberConstants.LIST;
    }
    @RequiresPermissions("member:view")
    @RequestMapping(value = "/list",method = RequestMethod.POST)
    @ResponseBody
    public Page<Member> listMemberData(Member member) throws CRUDException {
    	Page.setPageFromRequest();
    	Page<Member> pageInfo = new Page<Member>(memberService.findAll(member));
        return pageInfo;
    }
	@RequiresPermissions("member:create")
    @RequestMapping(value = "/add", method = RequestMethod.GET)
    public String showCreatFrom(Model model) {
        model.addAttribute("op", "保存");
        return MemberConstants.EDIT;
    }
	@RequiresPermissions("member:create")
    @RequestMapping(value = "/add", method = RequestMethod.POST)
    public String create(Member member, RedirectAttributes redirectAttributes) throws CRUDException {
		memberService.save(member);
        redirectAttributes.addFlashAttribute("msg", "新增成功");
        return getAdminUrlPath("/member");
    }
	@RequiresPermissions("member:update")
    @RequestMapping(value = "/{id}/update", method = RequestMethod.GET)
    public String showUpdateForm(Member member, Model model) throws CRUDException {
        model.addAttribute("member", memberService.findOne(member));
        model.addAttribute("op", "修改");
        return MemberConstants.EDIT;
    }
	@RequiresPermissions("member:update")
    @RequestMapping(value = "/{id}/update", method = RequestMethod.POST)
    public String update(Member member, RedirectAttributes redirectAttributes) throws CRUDException {
		memberService.update(member);;
        redirectAttributes.addFlashAttribute("msg", "修改成功");
        return getAdminUrlPath("/member");
    }
	@RequiresPermissions("member:delete")
    @RequestMapping(value = "/{id}/delete", method = RequestMethod.GET)
    public String delete(Member member, RedirectAttributes redirectAttributes) throws CRUDException {
		memberService.delete(member);
        redirectAttributes.addFlashAttribute("msg", "删除成功");
        return getAdminUrlPath("/member");
    }
	@RequiresPermissions("member:delete")
    @RequestMapping(value = "/deleteBatch", method = RequestMethod.GET)
    public String deleteBatch(Member member, RedirectAttributes redirectAttributes) throws CRUDException {
		memberService.deleteBatch(member);
        redirectAttributes.addFlashAttribute("msg", "批量删除成功");
        return getAdminUrlPath("/member");
    }
}