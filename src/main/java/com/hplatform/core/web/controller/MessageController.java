package com.hplatform.core.web.controller;

import java.util.Arrays;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hplatform.core.common.util.ConstantsUtil;
import com.hplatform.core.common.util.UserUtil;
import com.hplatform.core.common.websocket.SystemWebSocketHandler;
import com.hplatform.core.entity.Message;
import com.hplatform.core.entity.MessageGroup;
import com.hplatform.core.entity.MessageGroupUser;
import com.hplatform.core.entity.User;
import com.hplatform.core.exception.CRUDException;
import com.hplatform.core.service.MessageGroupService;
import com.hplatform.core.service.MessageGroupUserService;
import com.hplatform.core.service.MessageService;
import com.hplatform.core.service.UserService;

@Controller
@RequestMapping("${adminPath}/message")
public class MessageController {
	@Autowired
	private MessageService messageService;
	@Autowired
	private UserService userService;
	@Autowired
	private MessageGroupUserService messageGroupUserService;
	@Autowired
	private MessageGroupService messageGroupService;
	@RequiresPermissions("message:view")
    @RequestMapping(method = RequestMethod.GET)
    public String list(Model model,String sendIds) throws CRUDException {
		model.addAttribute("users", userService.findAll(new User()));
		MessageGroupUser messageGroupUser = new MessageGroupUser();
		messageGroupUser.setUser(new User(UserUtil.getCurrentUserId()));
		model.addAttribute("messageGroupUsers", messageGroupUserService.findAll(messageGroupUser));
		if(!StringUtils.isBlank(sendIds)){
			Message message = new Message();
			message.setSendIds(Arrays.asList(sendIds.split(",")));
			message.setReceiver(new User(UserUtil.getCurrentUserId()));
			message.setMsgStatus(ConstantsUtil.get().getFALSE());
			model.addAttribute("messages", messageService.findAll(message));
		}
        return "core/message/list";
    }
	@Bean
    public SystemWebSocketHandler systemWebSocketHandler() {
        return new SystemWebSocketHandler();
    }
	/**
	 * 发送消息
	 * @param message
	 * @return
	 * @throws CRUDException
	 */
	@RequiresPermissions("message:create")
    @RequestMapping(value="/send",method = RequestMethod.POST)
	@ResponseBody
	public String sendMessage(Message message) throws CRUDException{
		//messageService.save(message);
		return "";
	}
	/**
	 * 修改消息读取状态
	 * @param message
	 * @return
	 * @throws CRUDException
	 */
	@RequiresPermissions("message:create")
    @RequestMapping(value="/update",method = RequestMethod.POST)
	@ResponseBody
	public String updateMessage(Message message) throws CRUDException{
		messageService.update(message);
		return "";
	}
	/**
	 * 查询历史记录
	 * @param message
	 * @return
	 * @throws CRUDException
	 */
	@RequiresPermissions("message:view")
    @RequestMapping(value="/history",method = RequestMethod.POST)
	@ResponseBody
	public List<Message> findMessageHistory(Message message) throws CRUDException{
		return messageService.findAll(message);
	}
	/**
	 * 获取群组下面的成员
	 * @param messageGroupUser
	 * @return
	 * @throws CRUDException
	 */
	@RequiresPermissions("message:view")
	@RequestMapping(value="/groupusers",method = RequestMethod.POST)
	@ResponseBody
	public List<MessageGroupUser> groupusers(MessageGroupUser messageGroupUser) throws CRUDException{
		return messageGroupUserService.findAll(messageGroupUser);
	}
	/*****************************messagegroup***************************************/
	/**
	 * 创建群组方法
	 * @param messageGroup
	 * @return
	 * @throws CRUDException
	 */
	@RequiresPermissions("message:create")
	@RequestMapping(value="/editGroup",method = RequestMethod.POST)
	public String createGroup(Model model,MessageGroup messageGroup) throws CRUDException{
		messageGroupService.editGroup(messageGroup);
		return list(model, null);
	}
	/**
	 * 删除群组
	 * @param model
	 * @param messageGroup
	 * @return
	 * @throws CRUDException
	 */
	@RequiresPermissions("message:create")
	@RequestMapping(value="/deleteGroup",method = RequestMethod.GET)
	public String deleteGroup(Model model,MessageGroup messageGroup) throws CRUDException{
		messageGroupService.delete(messageGroup);
		return list(model, null);
	}
	/**
	 * 邀请用户
	 * @param model
	 * @param messageGroup
	 * @return
	 * @throws CRUDException
	 */
	@RequiresPermissions("message:create")
	@RequestMapping(value="/inviteUsers",method = RequestMethod.POST)
	public String inviteUsers(Model model,MessageGroup messageGroup) throws CRUDException{
		messageGroupService.editGroupUsers(messageGroup);
		return list(model, null);
	}
	/**
	 * 当前用户退出群组
	 * @param model
	 * @param messageGroup
	 * @return
	 * @throws CRUDException
	 */
	@RequiresPermissions("message:create")
	@RequestMapping(value="/exitGroup",method = RequestMethod.GET)
	public String exitGroup(Model model,MessageGroup messageGroup) throws CRUDException{
		messageGroupService.deleteGroupMapping(messageGroup);
		return list(model, null);
	}
}
