package com.hplatform.aop.excute;

import org.springframework.stereotype.Component;

@Component
public class AspectExcute {
	public void doit(){
		System.out.println("执行方法");
	}
}
