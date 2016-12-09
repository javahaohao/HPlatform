package com.test.file;

import com.hplatform.core.common.util.DynamicCompileUtil;
import com.hplatform.core.common.util.FileUtil;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import java.io.File;

/**
 * Created by Administrator on 2016/12/8.
 */
@WebAppConfiguration
@RunWith(SpringJUnit4ClassRunner.class) //指定测试用例的运行器 这里是指定了Junit4
@ContextConfiguration(locations={"classpath:spring-config.xml"}) //指定Spring的配置文件 /为classpath下
public class FileTest {
    @Test
    public void test(){
        File[] files = new File[]{new File("F:\\platform\\HPlatform\\src\\test\\java\\com\\test\\file\\CompileHello.java")};
        DynamicCompileUtil.compileJavaCode(files);
//        System.out.println(System.getProperty("java.class.path"));
    }
}
