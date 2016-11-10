package com.hplatform.aop.gen;

import com.hplatform.core.entity.Table;
import com.hplatform.core.service.TableService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

/**
 * use for:
 * Created by javahao on 2016/11/10.
 * auth:JavaHao
 */
@WebAppConfiguration
@RunWith(SpringJUnit4ClassRunner.class) //指定测试用例的运行器 这里是指定了Junit4
@ContextConfiguration(locations={"classpath:spring-config.xml"}) //指定Spring的配置文件 /为classpath下
public class TestGenCode {
    @Autowired
    private TableService tableService;

    @Test
    public void genCode() throws Exception {
        Table table = new Table();
        table.setId("4c51136664f44efe98e566f16862884a");
        tableService.genCodeBatch(table);
    }
}
