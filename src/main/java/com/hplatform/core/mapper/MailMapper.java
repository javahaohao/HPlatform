package com.hplatform.core.mapper;

import com.hplatform.core.common.annotation.MyBatisMapper;
import com.hplatform.core.entity.Mail;
import com.hplatform.core.entity.MailUser;


/**
 * 程序名称： Mail.java
 * 程序说明： 文件mapper
 * 版权信息： Copyright XXXXXXXXX有限公司
 * 时间： 2012-2-24
 * 
 * @author： lib
 * @version： Ver 0.1
 */
@MyBatisMapper
public interface MailMapper extends BaseMapper<Mail> {
	public String findMailMessageIdList(MailUser mailUser);
}