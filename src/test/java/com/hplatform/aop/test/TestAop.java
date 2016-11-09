package com.hplatform.aop.test;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import com.hplatform.aop.excute.AspectExcute;
@WebAppConfiguration
@RunWith(SpringJUnit4ClassRunner.class) //指定测试用例的运行器 这里是指定了Junit4
@ContextConfiguration(locations={"classpath:spring-config.xml"}) //指定Spring的配置文件 /为classpath下
public class TestAop {
	@Autowired
	private AspectExcute aspectExcute;
	
	@Test
	public void test(){
		aspectExcute.doit();
	}
	
}
