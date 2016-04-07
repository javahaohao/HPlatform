package com.hplatform.core.service;

import org.springframework.stereotype.Service;

import com.hplatform.core.entity.MessageGroupUser;
import com.hplatform.core.exception.CRUDException;
import com.hplatform.core.mapper.MessageGroupUserMapper;
@Service
public class MessageGroupUserService extends BaseService<MessageGroupUser, MessageGroupUserMapper> {
	public void deleteByGroup(MessageGroupUser messageGroupUser) throws CRUDException{
		try {
			m.deleteByGroup(messageGroupUser);
		}catch(Exception e){
			log.error(e);
			throw new CRUDException(e);
		}
	}
}
