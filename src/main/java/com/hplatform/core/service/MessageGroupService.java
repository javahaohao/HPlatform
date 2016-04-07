package com.hplatform.core.service;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hplatform.core.common.util.UserUtil;
import com.hplatform.core.entity.MessageGroup;
import com.hplatform.core.entity.MessageGroupUser;
import com.hplatform.core.entity.User;
import com.hplatform.core.exception.CRUDException;
import com.hplatform.core.mapper.MessageGroupMapper;
@Service
public class MessageGroupService extends BaseService<MessageGroup, MessageGroupMapper> {
	@Autowired
	private MessageGroupUserService messageGroupUserService;
	/**
	 * 修改群组信息
	 * @param messageGroup
	 * @throws CRUDException
	 */
	public void editGroup(MessageGroup messageGroup) throws CRUDException{
		try {
			if(StringUtils.isBlank(messageGroup.getId())){
				save(messageGroup);
				addUserToGroup(messageGroup);
			}else{
				update(messageGroup);
				editGroupUsers(messageGroup);
			}
		} catch (CRUDException e) {
			log.error(e);
			throw new CRUDException(e);
		}
	}
	/**
	 * 管理群组人员
	 * @param messageGroup
	 * @throws CRUDException
	 */
	public void editGroupUsers(MessageGroup messageGroup) throws CRUDException{
		//全删全增处理群组成员
		messageGroupUserService.deleteByGroup(new MessageGroupUser(messageGroup, null));
		addUserToGroup(messageGroup);
	}
	private void addUserToGroup(MessageGroup messageGroup) throws CRUDException{
		String[] userIds = messageGroup.getUserIds().split(",");
		List<String> userIdList = new ArrayList<String>(Arrays.asList(userIds));
		userIdList.add(UserUtil.getCurrentUserId());
		for(String userId:userIdList){
			messageGroupUserService.save(new MessageGroupUser(messageGroup,new User(userId)));
		}
	}
	/**
	 * 删除群组以及群组成员
	 */
	public void delete(MessageGroup messageGroup) throws CRUDException{
		try {
			super.delete(messageGroup);
			messageGroupUserService.deleteByGroup(new MessageGroupUser(messageGroup, null));
		} catch (CRUDException e) {
			log.error(e);
			throw new CRUDException(e);
		}
	}
	/**
	 * 当前用户退出群组
	 * @param messageGroup
	 * @throws CRUDException
	 */
	public void deleteGroupMapping(MessageGroup messageGroup) throws CRUDException{
		try {
			messageGroupUserService.deleteByGroup(new MessageGroupUser(messageGroup, new User(UserUtil.getCurrentUserId())));
		} catch (CRUDException e) {
			log.error(e);
			throw new CRUDException(e);
		}
	}
}
