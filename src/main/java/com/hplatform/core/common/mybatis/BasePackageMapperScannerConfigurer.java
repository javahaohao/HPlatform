package com.hplatform.core.common.mybatis;

import org.apache.commons.lang.StringUtils;
import org.mybatis.spring.mapper.MapperScannerConfigurer;

public class BasePackageMapperScannerConfigurer extends MapperScannerConfigurer{
	
	private String basePackage;
	
	@Override
	public void setBasePackage(String basepkg) {
		super.setBasePackage(this.basePackage = StringUtils.join(SpringMatchPackage.getMatchPackage(basepkg), ","));
	}

	public String getBasePackage() {
		return basePackage;
	}
}
