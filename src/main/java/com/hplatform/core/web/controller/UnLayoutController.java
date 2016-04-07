package com.hplatform.core.web.controller;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.hplatform.core.entity.MessageGroup;
import com.hplatform.core.entity.MessageGroupUser;
import com.hplatform.core.entity.User;
import com.hplatform.core.exception.CRUDException;
import com.hplatform.core.service.MessageGroupService;
import com.hplatform.core.service.MessageGroupUserService;
import com.hplatform.core.service.UserService;

@Controller
@RequestMapping("${adminPath}/unlayout")
public class UnLayoutController extends BaseController{
	@Autowired
	private MessageGroupService messageGroupService;
	@Autowired
	private UserService userService;
	@Autowired
	private MessageGroupUserService messageGroupUserService;
	/**
	 * 修改群组页面
	 * @param model
	 * @param messageGroup
	 * @return
	 * @throws CRUDException
	 */
	@RequiresPermissions("message:create")
	@RequestMapping(value="/editGroup",method=RequestMethod.GET)
	public String editGroup(Model model,MessageGroup messageGroup) throws CRUDException{
		if(StringUtils.isNotBlank(messageGroup.getId())){
			model.addAttribute("messageGroup", messageGroupService.findOne(messageGroup));
			initInvite(model, messageGroup);
		}else{
			model.addAttribute("messageGroup", messageGroup);
			model.addAttribute("unselectedusers", userService.findAll(new User()));
			model.addAttribute("selectedUsers", new ArrayList<User>());
		}
		return "core/message/editgroup";
	}

	/**
	 * 初始化邀请用户数据
	 * @param model
	 * @throws CRUDException
	 */
	private void initInvite(Model model,MessageGroup messageGroup) throws CRUDException{
		model.addAttribute("unselectedusers", userService.findAll(new User()));
		List<MessageGroupUser> messageGroupUsers = messageGroupUserService.findAll(new MessageGroupUser(messageGroup, null));
		List<User> selectedUsers = new ArrayList<User>();
		for(MessageGroupUser messageGroupUser : messageGroupUsers)selectedUsers.add(messageGroupUser.getUser());
		model.addAttribute("selectedUsers", selectedUsers);
	}
	/**
	 * 邀请用户入群
	 * @param model
	 * @param messageGroup
	 * @return
	 * @throws CRUDException
	 */
	@RequiresPermissions("message:create")
	@RequestMapping(value="/inviteUsers",method = RequestMethod.GET)
	public String inviteUsers(Model model,MessageGroup messageGroup) throws CRUDException{
		model.addAttribute("messageGroup", messageGroup);
		initInvite(model,messageGroup);
		return "core/message/invite";
	}
}
