package com.hplatform.core.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import com.hplatform.core.constants.Constants;
import com.hplatform.core.entity.Organization;
import com.hplatform.core.exception.CRUDException;
import com.hplatform.core.mapper.OrganizationMapper;

@Service

public class OrganizationService extends BaseService<Organization, OrganizationMapper>{
	

    @CacheEvict(value={Constants.CACHE_ORGANIZATION,Constants.CACHE_ORGANIZATION_K_V},allEntries=true,beforeInvocation=true)
    public void createOrganization(Organization organization) throws CRUDException {
    	super.save(organization);
    }

    @CacheEvict(value={Constants.CACHE_ORGANIZATION,Constants.CACHE_ORGANIZATION_K_V},allEntries=true,beforeInvocation=true)
    public void updateOrganization(Organization organization) {
    	organization.preUpdate();
    	move(organization);
        m.updateEntity(organization);
    }

    @CacheEvict(value={Constants.CACHE_ORGANIZATION,Constants.CACHE_ORGANIZATION_K_V},allEntries=true,beforeInvocation=true)
    public void deleteOrganization(String organizationId) {
    	Organization organization = new Organization();
    	organization.setId(organizationId);
    	Organization result = m.findOne(organization);
        m.deleteEntity(organization);
        m.deleteEntityByParent(result);
    }

    @Cacheable(value=Constants.CACHE_ORGANIZATION_K_V)
    public Organization findOne(String organizationId) {
    	Organization organization = new Organization();
    	organization.setId(organizationId);
        return m.findOne(organization);
    }

    @Cacheable(value=Constants.CACHE_ORGANIZATION)
    public List<Organization> findAll() {
        return m.findAll(new Organization());
    }

    
    public List<Organization> findAllWithExclude(Organization excludeOraganization) {
        return m.findAllWithExclude(excludeOraganization);
    }

    @CacheEvict(value={Constants.CACHE_ORGANIZATION,Constants.CACHE_ORGANIZATION_K_V},allEntries=true,beforeInvocation=true)
    public void move(Organization organization) {
    	Organization source = m.findOne(organization);
    	if(!source.getParentIds().equals(organization.getParentIds())){
    		Map<String, String> paramMap = new HashMap<String, String>();
        	paramMap.put("source", source.getSelfPath());
        	paramMap.put("target", organization.getSelfPath());
        	m.move(paramMap);
    	}
    }
}
