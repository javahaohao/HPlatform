package com.hplatform.aop.test;

import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.stereotype.Component;

@Aspect
@Component
public class AspectBean {
	@Pointcut("execution(public * com.hplatform.aop.excute..*.*(..))") 
	public void pointcut(){
		System.out.println("pointcut");
	}
	@Before("pointcut()")
	public void before(){
		System.out.println("before");
	}
}
