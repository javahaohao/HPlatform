package com.hplatform.core.mapper;

import com.hplatform.core.common.annotation.MyBatisMapper;
import com.hplatform.core.entity.User;

@MyBatisMapper
public interface UserMapper extends BaseMapper<User> {
	public User registerCheckInfo(User user);
	public void lockUser(User user);
	public void activationUser(User user);
	public void updatePassword(User user);
	public User confirmOldPwd(User user);
}
