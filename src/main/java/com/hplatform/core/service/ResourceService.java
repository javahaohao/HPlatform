package com.hplatform.core.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.shiro.authz.permission.WildcardPermission;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import com.hplatform.core.constants.Constants;
import com.hplatform.core.entity.Resource;
import com.hplatform.core.exception.CRUDException;
import com.hplatform.core.mapper.ResourceMapper;

@Service

public class ResourceService extends BaseService<Resource, ResourceMapper> {


    @CacheEvict(value={Constants.CACHE_RESOURCE,Constants.CACHE_RESOURCE_K_V},allEntries=true,beforeInvocation=true)
    public void createResource(Resource resource) throws CRUDException {
        save(resource);
    }

    @CacheEvict(value={Constants.CACHE_RESOURCE,Constants.CACHE_RESOURCE_K_V},allEntries=true,beforeInvocation=true)
    public void updateResource(Resource resource) {
    	resource.preUpdate();
        move(resource);
        m.updateEntity(resource);
    }

    @CacheEvict(value={Constants.CACHE_RESOURCE,Constants.CACHE_RESOURCE_K_V},allEntries=true,beforeInvocation=true)
    public void deleteResource(String resourceId) {
    	Resource resource = new Resource();
    	resource.setId(resourceId);
    	Resource result = m.findOne(resource);
        m.deleteEntity(resource);
        m.deleteEntityByParent(result);
    }

    @Cacheable(value=Constants.CACHE_RESOURCE_K_V)
    public Resource findOne(String resourceId) {
    	Resource resource = new Resource();
    	resource.setId(resourceId);
        return m.findOne(resource);
    }

    @Cacheable(value=Constants.CACHE_RESOURCE)
    public List<Resource> findAll() {
        return m.findAll(new Resource());
    }

    
    public Set<String> findPermissions(Set<String> resourceIds) {
        Set<String> permissions = new HashSet<String>();
        for(String resourceId : resourceIds) {
            Resource resource = findOne(resourceId);
            if(resource != null && !StringUtils.isEmpty(resource.getPermission())) {
                permissions.add(resource.getPermission());
            }
        }
        return permissions;
    }

    
    public List<Resource> findMenus(Set<String> permissions) {
        List<Resource> allResources = findAll();
        List<Resource> menus = new ArrayList<Resource>();
        for(Resource resource : allResources) {
            if(resource.isRootNode()) {
                continue;
            }
            if(resource.getType() != Resource.ResourceType.menu) {
                continue;
            }
            if(!hasPermission(permissions, resource)) {
                continue;
            }
            menus.add(resource);
        }
        return menus;
    }

    private boolean hasPermission(Set<String> permissions, Resource resource) {
        if(StringUtils.isEmpty(resource.getPermission())) {
            return true;
        }
        for(String permission : permissions) {
            WildcardPermission p1 = new WildcardPermission(permission);
            WildcardPermission p2 = new WildcardPermission(resource.getPermission());
            if(p1.implies(p2) || p2.implies(p1)) {
                return true;
            }
        }
        return false;
    }
    @CacheEvict(value={Constants.CACHE_RESOURCE,Constants.CACHE_RESOURCE_K_V},allEntries=true,beforeInvocation=true)
    public void move(Resource resource) {
    	Resource source = m.findOne(resource);
    	if(!source.getParentIds().equals(resource.getParentIds())){
    		Map<String, String> paramMap = new HashMap<String, String>();
        	paramMap.put("source", source.getSelfPath());
        	paramMap.put("target", resource.getSelfPath());
        	m.move(paramMap);
    	}
    }
}
