package com.hplatform.core.service;

import java.util.Arrays;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import com.hplatform.core.constants.Constants;
import com.hplatform.core.entity.Role;
import com.hplatform.core.mapper.RoleMapper;

@Service

public class RoleService extends BaseService<Role, RoleMapper>{

    @Autowired
    private ResourceService resourceService;
    
    @CacheEvict(value={Constants.CACHE_ROLE,Constants.CACHE_ROLE_K_V},allEntries=true,beforeInvocation=true)
    public void createRole(Role role) {
    	role.preInsert();
        m.addEntity(role);
    }

    @CacheEvict(value={Constants.CACHE_ROLE,Constants.CACHE_ROLE_K_V},allEntries=true,beforeInvocation=true)
    public void updateRole(Role role) {
    	role.preUpdate();
        m.updateEntity(role);
    }

    @CacheEvict(value={Constants.CACHE_ROLE,Constants.CACHE_ROLE_K_V},allEntries=true,beforeInvocation=true)
    public void deleteRole(Role role) {
        m.deleteEntity(role);
    }
    @CacheEvict(value={Constants.CACHE_ROLE,Constants.CACHE_ROLE_K_V},allEntries=true,beforeInvocation=true)
    public void deleteBatchEntity(Role role) {
    	role.setIdList(Arrays.asList(role.getId().split(",")));
    	m.deleteBatchEntity(role);
    }

    @Cacheable(value=Constants.CACHE_ROLE_K_V)
    public Role findOne(Role role) {
        return m.findOne(role);
    }

    @Cacheable(value=Constants.CACHE_ROLE)
    public List<Role> findAll() {
        return m.findAll(new Role());
    }

    
    public Set<String> findRoles(String... roleIds) {
        Set<String> roles = new HashSet<String>();
        for(String roleId : roleIds) {
            Role role = findOne(new Role(roleId));
            if(role != null) {
                roles.add(role.getRole());
            }
        }
        return roles;
    }

    
    public Set<String> findPermissions(String[] roleIds) {
        Set<String> resourceIds = new HashSet<String>();
        for(String roleId : roleIds) {
            Role role = findOne(new Role(roleId));
            if(role != null) {
                resourceIds.addAll(role.getResourceIds());
            }
        }
        return resourceService.findPermissions(resourceIds);
    }
}
