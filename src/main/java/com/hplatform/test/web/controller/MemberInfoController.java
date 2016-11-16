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
import com.hplatform.test.constants.MemberInfoConstants;
import com.hplatform.test.entity.MemberInfo;
import com.hplatform.test.service.MemberInfoService;
import com.hplatform.test.entity.Member;
import com.hplatform.test.service.MemberService;

@Controller
@RequestMapping("${adminPath}/memberInfo")
public class MemberInfoController extends BaseController {
	@Autowired
	private MemberInfoService memberInfoService;
	@Autowired
	private MemberService memberService;
	@ModelAttribute
	public MemberInfo get(@RequestParam(required=false) String id) throws CRUDException {
		return new MemberInfo();
	}
	private void initParents(Model model) throws CRUDException{
        model.addAttribute("parents", memberService.findAll(new Member()));
	}
	@RequiresPermissions("memberInfo:view")
    @RequestMapping(method = RequestMethod.GET)
    public String list(Model model) throws CRUDException {
        return MemberInfoConstants.LIST;
    }
    @RequiresPermissions("memberInfo:view")
    @RequestMapping(value = "/list",method = RequestMethod.POST)
    @ResponseBody
    public Page<MemberInfo> listMemberInfoData(MemberInfo memberInfo) throws CRUDException {
    	Page.setPageFromRequest();
    	Page<MemberInfo> pageInfo = new Page<MemberInfo>(memberInfoService.findAll(memberInfo));
        return pageInfo;
    }
	@RequiresPermissions("memberInfo:create")
    @RequestMapping(value = "/add", method = RequestMethod.GET)
    public String showCreatFrom(Model model)throws CRUDException {
        model.addAttribute("op", "保存");
        initParents(model);
        return MemberInfoConstants.EDIT;
    }
	@RequiresPermissions("memberInfo:create")
    @RequestMapping(value = "/add", method = RequestMethod.POST)
    public String create(MemberInfo memberInfo, RedirectAttributes redirectAttributes) throws CRUDException {
		memberInfoService.save(memberInfo);
        redirectAttributes.addFlashAttribute("msg", "新增成功");
        return getAdminUrlPath("/memberInfo");
    }
	@RequiresPermissions("memberInfo:update")
    @RequestMapping(value = "/{id}/update", method = RequestMethod.GET)
    public String showUpdateForm(MemberInfo memberInfo, Model model) throws CRUDException {
        model.addAttribute("memberInfo", memberInfoService.findOne(memberInfo));
        model.addAttribute("op", "修改");
        initParents(model);
        return MemberInfoConstants.EDIT;
    }
	@RequiresPermissions("memberInfo:update")
    @RequestMapping(value = "/{id}/update", method = RequestMethod.POST)
    public String update(MemberInfo memberInfo, RedirectAttributes redirectAttributes) throws CRUDException {
		memberInfoService.update(memberInfo);;
        redirectAttributes.addFlashAttribute("msg", "修改成功");
        return getAdminUrlPath("/memberInfo");
    }
	@RequiresPermissions("memberInfo:delete")
    @RequestMapping(value = "/{id}/delete", method = RequestMethod.GET)
    public String delete(MemberInfo memberInfo, RedirectAttributes redirectAttributes) throws CRUDException {
		memberInfoService.delete(memberInfo);
        redirectAttributes.addFlashAttribute("msg", "删除成功");
        return getAdminUrlPath("/memberInfo");
    }
	@RequiresPermissions("memberInfo:delete")
    @RequestMapping(value = "/deleteBatch", method = RequestMethod.GET)
    public String deleteBatch(MemberInfo memberInfo, RedirectAttributes redirectAttributes) throws CRUDException {
		memberInfoService.deleteBatch(memberInfo);
        redirectAttributes.addFlashAttribute("msg", "批量删除成功");
        return getAdminUrlPath("/memberInfo");
    }
}