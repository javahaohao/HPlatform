package com.hplatform.core.common.websocket;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.config.annotation.EnableWebSocket;
import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;

import com.hplatform.core.web.taglib.Functions;

//@Configuration
//@EnableWebMvc
//@EnableWebSocket
public class WebSocketConfig extends WebMvcConfigurerAdapter implements WebSocketConfigurer {
	
	private Logger logger = LoggerFactory.getLogger(getClass());
	
	/**
	 * 
	 */
	public WebSocketConfig() {
		logger.debug("class init {}",getClass().getSimpleName());
	}
	
    @Override
    public void registerWebSocketHandlers(WebSocketHandlerRegistry registry) {
    	
    	logger.debug("registerWebSocketHandlers");
        registry.addHandler(systemWebSocketHandler(), Functions.getAdminPath()+"/webSocketServer").addInterceptors(new HandshakeInterceptor());
        registry.addHandler(systemWebSocketHandler(), Functions.getAdminPath()+"/sockjs/webSocketServer").addInterceptors(new HandshakeInterceptor()).withSockJS();
    }

    //@Bean
    public WebsocketEndPoint WebsocketEndPoint() {
        return new WebsocketEndPoint();
    }
    
    @Bean
    public WebSocketHandler systemWebSocketHandler(){
        return new SystemWebSocketHandler();
    }
}
