package com.hplatform.test.service;

import org.springframework.stereotype.Service;
import com.hplatform.core.service.BaseService;
import com.hplatform.test.entity.Member;
import com.hplatform.test.mapper.MemberMapper;
@Service
public class MemberService extends BaseService<Member, MemberMapper>{
}