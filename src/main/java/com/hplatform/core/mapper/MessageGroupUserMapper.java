package com.hplatform.core.mapper;

import com.hplatform.core.common.annotation.MyBatisMapper;
import com.hplatform.core.entity.MessageGroupUser;
@MyBatisMapper
public interface MessageGroupUserMapper extends BaseMapper<MessageGroupUser> {
	public void deleteByGroup(MessageGroupUser messageGroupUser);
}
