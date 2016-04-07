package com.hplatform.model.service;

import org.springframework.stereotype.Service;

import com.hplatform.core.service.BaseService;
import com.hplatform.model.entity.Resume;
import com.hplatform.model.mapper.ResumeMapper;

@Service
public class ResumeService extends BaseService<Resume, ResumeMapper> {
}
