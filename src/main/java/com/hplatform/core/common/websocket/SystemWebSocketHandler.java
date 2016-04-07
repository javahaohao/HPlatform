package com.hplatform.core.common.websocket;

import java.io.IOException;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import net.sf.json.JSONObject;

import org.apache.commons.collections.CollectionUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.WebSocketMessage;
import org.springframework.web.socket.WebSocketSession;

import com.hplatform.core.common.util.ConstantsUtil;
import com.hplatform.core.entity.Message;
import com.hplatform.core.entity.Page;
import com.hplatform.core.entity.User;
import com.hplatform.core.exception.CRUDException;
import com.hplatform.core.service.MessageService;
import com.hplatform.core.web.taglib.Functions;

public class SystemWebSocketHandler implements WebSocketHandler {

	private static final Logger logger = LoggerFactory.getLogger(SystemWebSocketHandler.class);;
	 
	private static final Map<String, WebSocketSession> users;
	@Autowired
	private MessageService messageService;
 
    static {
    	users = new HashMap<String, WebSocketSession>();
    }
 
    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
        /*
         * 链接成功后会触发此方法，可在此处对离线消息什么的进行处理
         */
        users.put(getUserId(session), session);
        //聊天未读消息
        sendTalkNoReadMsg(session);
    }
 
    @Override
    public void handleMessage(WebSocketSession session, WebSocketMessage<?> message) throws Exception {
    	/*
         * 前端 websocket.send() 会触发此方法 
         */
        Message msg = (Message) JSONObject.toBean(JSONObject.fromObject(message.getPayload()), Message.class);
        msg.setCreateDate(new Date());
        msg.setSender(Functions.getUserById(msg.getSender().getId()));
        msg.setReceiver(Functions.getUserById(msg.getReceiver().getId()));
        if(ConstantsUtil.get().getTALK_TYPE_USER().equals(msg.getMsgType()))
        	sendMessageToUser(msg);
        else
        	sendMessageToUsers(msg);
    }
 
    @Override
    public void handleTransportError(WebSocketSession session, Throwable exception) throws Exception {
        if(session.isOpen()){
            session.close();
        }
        users.remove(session);
    }
 
    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus closeStatus) throws Exception {
        users.remove(session);
    }
 
    @Override
    public boolean supportsPartialMessages() {
        return false;
    }
 
    /**
     * 给所有在线用户发送消息
     *
     * @param message
     */
    public void sendMessageToUsers(Message message) {
    	String[] receiveIds = message.getReceiver().getId().split(",");
    	for(String receiveId : receiveIds){
    		try {
	    		message.setReceiver(new User(receiveId));
	    		saveMessage(message);
	    		if (null!=users.get(receiveId)&&users.get(receiveId).isOpen()) {
						users.get(receiveId).sendMessage(new TextMessage(JSONObject.fromObject(message).toString()));
	            }
    		} catch (IOException e) {
    			logger.error("发送消息失败！",e);
    			continue;
    		}
    	}
    }
 
    /**
     * 给某个用户发送消息
     *
     * @param userId
     * @param message
     */
    public void sendMessageToUser(Message message) {
    	try {
    		saveMessage(message);
    		WebSocketSession session = users.get(message.getReceiver().getId());
    		if (null!=session&&session.isOpen())
    			session.sendMessage(new TextMessage(JSONObject.fromObject(message).toString()));
		} catch (Exception e) {
			logger.error("发送消息失败！",e);
		}
    }
    /**
     * 保存消息
     * @param message
     */
    public void saveMessage(Message message){
    	//处理未在线消息
		message.preInsert();
		message.setMsgStatus(ConstantsUtil.get().FALSE);
		message.setCreateUser(message.getSender().getId());
		message.setUpdateUser(message.getSender().getId());
		try {
			messageService.save(message);
		} catch (CRUDException e) {
			logger.error("保存消息失败！",e);
		}
    }
    /**
     * 从session获取userid
     * @param session
     * @return
     */
    public String getUserId(WebSocketSession session){
    	return String.valueOf(session.getHandshakeAttributes().get("userId"));
    }
    /**
     * 发送聊天未读消息
     * @throws CRUDException
     */
    public void sendTalkNoReadMsg(WebSocketSession session) throws CRUDException{
    	try {
			//获取当前用户未读消息
			Message message = new Message();
			message.setReceiver(new User(getUserId(session)));
			message.setMsgStatus(ConstantsUtil.get().FALSE);
			Page<Message> msgList = messageService.findAllByPage(message);
			message.getMsgs().addAll(msgList.getList());
			if(!CollectionUtils.isEmpty(message.getMsgs()))
				session.sendMessage(new TextMessage(JSONObject.fromObject(message).toString()));
		} catch (Exception e) {
			logger.error("发送未读消息失败！",e);
		}
    }
}
