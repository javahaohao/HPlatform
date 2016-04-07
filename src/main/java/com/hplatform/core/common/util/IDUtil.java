package com.hplatform.core.common.util;

import java.io.Serializable;
import java.util.UUID;

import org.apache.shiro.session.Session;
import org.apache.shiro.session.mgt.eis.SessionIdGenerator;
import org.springframework.util.IdGenerator;

public class IDUtil implements IdGenerator, SessionIdGenerator{
	
	public static String createUUID(){
		return String.valueOf(UUID.randomUUID()).replaceAll("-", "");
	}
	
	@Override
	public Serializable generateId(Session session) {
		return createUUID();
	}
	
	@Override
	public UUID generateId() {
		return UUID.randomUUID();
	}
}
