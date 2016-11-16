package com.hplatform.test.service;

import org.springframework.stereotype.Service;
import com.hplatform.core.service.BaseService;
import com.hplatform.test.entity.MemberInfo;
import com.hplatform.test.mapper.MemberInfoMapper;
@Service
public class MemberInfoService extends BaseService<MemberInfo, MemberInfoMapper>{
}