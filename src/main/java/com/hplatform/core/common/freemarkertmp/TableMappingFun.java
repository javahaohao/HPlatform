package com.hplatform.core.common.freemarkertmp;

import com.hplatform.core.common.util.AnalysisObject;
import com.hplatform.core.common.util.StringUtils;
import freemarker.template.TemplateMethodModel;
import freemarker.template.TemplateModelException;

import java.util.List;

/**
 * use for:映射gencode的Table属性值
 * Created by javahao on 2016/11/11.
 * auth:JavaHao
 */
public class TableMappingFun implements TemplateMethodModel {
    @Override
    public Object exec(List list) throws TemplateModelException {
        if (list.size() != 2) {
            throw new TemplateModelException("Wrong arguments");
        }
        //第一个参数有可能为脚本，有可能为属性名称
        String paramone = (String) list.get(0);
        //第二个参数为table.domain
        String domain = (String)list.get(1);
        if(StringUtils.isELType(paramone)){
            return org.apache.commons.lang3.StringUtils.join("${",StringUtils.lowerFirst(domain),".",StringUtils.getELName(paramone),"}");
        }
        return paramone;
    }
}
