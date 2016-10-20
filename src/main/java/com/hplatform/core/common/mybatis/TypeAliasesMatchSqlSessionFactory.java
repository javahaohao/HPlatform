package com.hplatform.core.common.mybatis;

import org.apache.commons.lang.StringUtils;
import org.mybatis.spring.SqlSessionFactoryBean;

public class TypeAliasesMatchSqlSessionFactory extends SqlSessionFactoryBean{
    

    @Override
    public void setTypeAliasesPackage(String typeAliasesPackage) {
    	super.setTypeAliasesPackage(StringUtils.join(SpringMatchPackage.getMatchPackage(typeAliasesPackage), ","));
    }
}
