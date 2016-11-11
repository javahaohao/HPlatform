package com.hplatform.core.common.freemarkertmp;

import com.hplatform.core.common.util.StringUtils;
import freemarker.template.TemplateMethodModel;
import freemarker.template.TemplateModelException;

import java.util.List;

/**
 * Created by Administrator on 2016/11/11.
 */
public class TrimELFun implements TemplateMethodModel {
    @Override
    public Object exec(List list) throws TemplateModelException {
        if (list.size() != 1) {
            throw new TemplateModelException("Wrong arguments");
        }
        //第一个参数有可能为脚本，有可能为属性名称
        String paramone = (String) list.get(0);
        if(StringUtils.isELType(paramone)){
            return StringUtils.getELName(paramone);
        }
        return paramone;
    }
}
