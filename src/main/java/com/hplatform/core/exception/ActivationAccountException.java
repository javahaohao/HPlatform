package com.hplatform.core.exception;

import org.apache.shiro.authc.DisabledAccountException;

public class ActivationAccountException extends DisabledAccountException{
	private static final long serialVersionUID = 1L;
	public ActivationAccountException(){
	}
	public ActivationAccountException(String message){
		super(message);
	}
	public ActivationAccountException(Throwable cause){
		super(cause);
	}
	public ActivationAccountException(String message, Throwable cause){
		super(message, cause);
	}
}
