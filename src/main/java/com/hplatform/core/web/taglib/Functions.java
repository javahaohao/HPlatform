package com.hplatform.core.web.taglib;

import cn.org.rapid_framework.util.ObjectUtils;
import com.hplatform.core.common.util.*;
import com.hplatform.core.constants.ColumnsConstants;
import com.hplatform.core.constants.Constants;
import com.hplatform.core.constants.TagsConstants;
import com.hplatform.core.entity.*;
import com.hplatform.core.exception.CRUDException;
import com.hplatform.core.service.*;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;
import org.apache.commons.collections.MapUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.shiro.SecurityUtils;
import org.springframework.util.CollectionUtils;

import java.util.*;

public class Functions {
	private static final transient Log log = LogFactory.getLog(Functions.class);
    private static Map<String,GenColumnVo> defaultColumTagMap = new HashMap<String, GenColumnVo>(){
        {
            final Element element = new Element();
            element.setTagId(TagsConstants.DEFAULT_HIDDEN_TAGS_MVCHIDDEN);
            try {
                //主键默认标签配置
                put(ColumnsConstants.COLUMN_KEYS_PRI
                        ,new GenColumnVo(ColumnsConstants.COLUMN_KEYS_PRI
                                ,TagsConstants.DEFAULT_HIDDEN_TAGS_MVCHIDDEN
                                ,SpringUtils.getBean(ElementService.class).findAll(element))
                );
                element.setTagId(TagsConstants.DEFAULT_FOREIGNKEY_TAGS_MVCSELECT);
                //外键默认标签配置
                put(ColumnsConstants.COLUMN_KEYS_FK
                        ,new GenColumnVo(ColumnsConstants.COLUMN_KEYS_FK
                                ,TagsConstants.DEFAULT_FOREIGNKEY_TAGS_MVCSELECT
                                ,SpringUtils.getBean(ElementService.class).findAll(element))
                );
            } catch (CRUDException e) {
                log.error("默认字段标签初始化失败！",e);
            }
        }
    };

    /**
     * 获取代码生成器列的默认选中标签
     * @param columnKey
     * @return
     */
    public static GenColumnVo defaultTag(String columnKey){
        if(StringUtils.isNotBlank(columnKey)
                && ObjectUtils.isNotEmpty(defaultColumTagMap.get(columnKey)))
            return defaultColumTagMap.get(columnKey);
        return null;
    }
	/**
	 * 获取平台中支持的JS控件标示
	 * @return
	 */
	public static Map<String, String> getPlugins(){
		return JSPlugins.getJsPlugins();
	}
	/**
	 * 获取后台访问路径
	 * @return
	 */
	public static String getAdminPath(){
		return PropertiesUtil.getAdminPath();
	}
	/**
	 * 获取前台访问路径
	 * @return
	 */
	public static String getSitePath(){
		return PropertiesUtil.getSitePath();
	}
	
    @SuppressWarnings("rawtypes")
	public static boolean in(Iterable iterable, Object element) {
        if(iterable == null) {
            return false;
        }
        return CollectionUtils.contains(iterable.iterator(), element);
    }

    public static String organizationName(String organizationId) {
    	if(organizationId==null||"0".equals(organizationId)||"".equals(organizationId)){
    		return "根节点";
    	}
        Organization organization = getOrganizationService().findOne(organizationId);
        if(organization == null) {
            return "";
        }
        return organization.getName();
    }

    public static String organizationNames(Collection<String> organizationIds) {
        if(CollectionUtils.isEmpty(organizationIds)) {
            return "";
        }

        StringBuilder s = new StringBuilder();
        for(String organizationId : organizationIds) {
            Organization organization = getOrganizationService().findOne(organizationId);
            if(organization == null) {
                return "";
            }
            s.append(organization.getName());
            s.append(",");
        }

        if(s.length() > 0) {
            s.deleteCharAt(s.length() - 1);
        }

        return s.toString();
    }
    public static String roleName(String roleId) {
        Role role = getRoleService().findOne(new Role(roleId));
        if(role == null) {
            return "";
        }
        return role.getDescription();
    }

    public static String roleNames(Collection<String> roleIds) {
        if(CollectionUtils.isEmpty(roleIds)) {
            return "";
        }

        StringBuilder s = new StringBuilder();
        for(String roleId : roleIds) {
            Role role = getRoleService().findOne(new Role(roleId));
            if(role == null) {
                return "";
            }
            s.append(role.getDescription());
            s.append(",");
        }

        if(s.length() > 0) {
            s.deleteCharAt(s.length() - 1);
        }

        return s.toString();
    }
    public static String resourceName(String resourceId) {
        Resource resource = getResourceService().findOne(resourceId);
        if(resource == null) {
            return "";
        }
        return resource.getName();
    }
    public static String resourceNames(Collection<String> resourceIds) {
        if(CollectionUtils.isEmpty(resourceIds)) {
            return "";
        }

        StringBuilder s = new StringBuilder();
        for(String resourceId : resourceIds) {
            Resource resource = getResourceService().findOne(resourceId);
            if(resource == null) {
                return "";
            }
            s.append(resource.getName());
            s.append(",");
        }

        if(s.length() > 0) {
            s.deleteCharAt(s.length() - 1);
        }

        return s.toString();
    }

    /**
     * 获取当前登录人所拥有的资源
     * @return
     */
    @SuppressWarnings("unchecked")
	public static List<Resource> getCurrentUserMenus(){
    	List<Resource> menus = UserUtil.getCurrentPrincipal().getValueFromCacheMap(Constants.CURRENT_MENUS, List.class);
    	if(CollectionUtils.isEmpty(menus)){
    		Set<String> permissions = getUserService().findPermissions(((Principal)SecurityUtils.getSubject().getPrincipal()).getUser());
            menus = getResourceService().findMenus(permissions);
            UserUtil.getCurrentPrincipal().putInCacheMap(Constants.CURRENT_MENUS, menus);
    	}
    	return menus;
    }
    /**
     * 获取当前用户对象
     * @return
     */
    public static User getCurrentUser(){
    	return UserUtil.getCurrentPrincipal().getUser();
    }
    /**
     * 按照用户ID获取用户对象
     * @param userId
     * @return
     */
    public static User getUserById(String userId){
    	if("0".equals(userId)||null==userId||"".equals(userId))
    		return new User();
    	User user = new User();
    	user.setId(userId);
    	User result = null;
		try {
			result = getUserService().findOne(user);
		} catch (CRUDException e) {
			log.error("按照用户ID获取用户失败！", e);
		}
    	if(result!=null)
    		return result;
    	else
    		return new User();
    }
    /**
     * 按照字典表的ids批量查询字典数据id,id,id
     * @param dictIds
     * @return
     * @throws CRUDException 
     */
    public static Collection<Dict> getDictsByIds(String dictIds) throws CRUDException{
    	Collection<Dict> dictList = null;
    	if(!StringUtils.isEmpty(dictIds)){
    		dictList = new ArrayList<Dict>();
    		for(String dictId : Arrays.asList(dictIds.split(",")))
    			dictList.add(getDictService().findOne(dictId));
    	}
    	return dictList;
    }
    /**
     * 按照字典的ID获取字典对象
     * @param dictId
     * @return
     * @throws CRUDException 
     */
    public static Dict getDictById(String dictId) throws CRUDException{
    	if(!StringUtils.isEmpty(dictId))
    		return getDictService().findOne(dictId);
    	else
    		return null;
    }
    /**
     * 按照ID获取所有子字典数据
     * @param dictId
     * @return
     */
    public static List<Dict> getChildDictById(String dictId){
    	if(!StringUtils.isEmpty(dictId))
    		return getDictService().findChildDictById(dictId);
    	else
    		return null;
    }
    /**
     * 按照条件查询区域表
     * @param area
     * @return
     */
    private static List<Area> getAreas(Area area){
    	try {
			return getAreaService().findAll(area);
		} catch (CRUDException e) {
			log.error("获取城市区域失败！", e);
		}
		return null;
    }
    /**
     * 按照父ID获取省份城市数据
     * @return
     */
    public static List<Area> getAreasByPid(Integer level,String pid){
    	Area area = new Area();
    	area.setLevel(level);
    	area.setParentId(pid);
		return getAreas(area);
    }
    /**
     * 获取省份城市数据
     * @return
     */
    public static List<Area> getAreasByLevel(Integer level){
    	Area area = new Area();
    	area.setLevel(level);
		return getAreas(area);
    }
    /**
     * 获取省份下面的区域数据
     * @return
     */
    public static Map<String, Object> getBrotherArea(String id){
		try {
			if(StringUtils.isNotBlank(id)){
	    		return getAreaService().findBrotherAndParentArea(id);
	    	}else{
	    		return getAreaService().findProvAreas();
	    	}
		} catch (CRUDException e) {
			log.error("获取省份下面的区域数据失败！", e);
		}
		return null;
    }
    /**
     * 按照ID获取省份城市数据
     * @return
     */
    public static Area getAreaById(String id){
    	Area area = new Area();
    	area.setId(id);
    	try {
			return getAreaService().findOne(area);
		} catch (CRUDException e) {
			log.error("获取城市区域失败！", e);
		}
    	return null;
    }
    /**
     * 按照文件id获取文件信息
     * @param id
     * @return
     */
    public static Attachment getAttachById(String id){
    	try {
			return getAttachmentService().findAttachmentById(id);
		} catch (CRUDException e) {
			log.error("按照id获取文件对象！", e);
		}
		return null;
    }
    /**
     * 按照文件id,id批量获取文件信息
     * @param ids
     * @return
     */
    public static List<Attachment> getAttachList(String ids){
    	List<Attachment> attachmentList = new ArrayList<Attachment>();
    	List<String> idList = Arrays.asList(ids.split(","));
    	Attachment attach= null;
    	for(String id:idList){
    		attach = getAttachById(id);
    		if(ObjectUtils.isNotEmpty(attach))
    			attachmentList.add(attach);
    	}
		return attachmentList;
    }
    /**
     * 判断是否是教员
     * @return
     */
    public static Boolean isTeacher(){
    	return UserUtil.isTeacher();
    }
    /**
     * 判断是否是学员
     * @return
     */
    public static Boolean isStudent(){
    	return UserUtil.isStudent();
    }
    /**
     * 获取预制的java类型
     * @return
     */
    public static List<String> getJavaTypeList(){
    	List<String> javaTypeList = new ArrayList<String>();
    	for(Map.Entry<String, String> entry:ConstantsUtil.get().mysqlDataTypeMap.entrySet()){
    		if(!javaTypeList.contains(entry.getValue())){
    			javaTypeList.add(entry.getValue());
    		}
    	}
    	return javaTypeList;
    }

    /**
     * 获取预制jdbc类型
     * @return
     */
    public static List<String> getJdbcTypeList(){
        List<String> jdbcTypeList = new ArrayList<String>();
        for(Map.Entry<String, String> entry:ConstantsUtil.get().mysqlDataTypeMap.entrySet()){
            if(!jdbcTypeList.contains(entry.getKey())){
                jdbcTypeList.add(entry.getKey());
            }
        }
        return jdbcTypeList;
    }
    /**
     * 获取可用组件
     * @return
     * @throws CRUDException 
     */
    public static List<Tags> getPluginsList(){
    	try {
			return getTagsService().findAll(new Tags());
		} catch (CRUDException e) {
			log.error(e);
		}
    	return null;
    }
    private static DictService dictService;
    private static OrganizationService organizationService;
    private static RoleService roleService;
    private static ResourceService resourceService;
    private static UserService userService;
    private static AreaService areaService;
    private static AttachmentService attachmentService;
    private static TagsService tagsService;

    public static DictService getDictService() {
        if(dictService == null) {
        	dictService = SpringUtils.getBean(DictService.class);
        }
        return dictService;
    }
    
    public static OrganizationService getOrganizationService() {
        if(organizationService == null) {
            organizationService = SpringUtils.getBean(OrganizationService.class);
        }
        return organizationService;
    }

    public static RoleService getRoleService() {
        if(roleService == null) {
            roleService = SpringUtils.getBean(RoleService.class);
        }
        return roleService;
    }

    public static ResourceService getResourceService() {
        if(resourceService == null) {
            resourceService = SpringUtils.getBean(ResourceService.class);
        }
        return resourceService;
    }
    public static UserService getUserService() {
        if(userService == null) {
        	userService = SpringUtils.getBean(UserService.class);
        }
        return userService;
    }
    public static AreaService getAreaService() {
        if(areaService == null) {
        	areaService = SpringUtils.getBean(AreaService.class);
        }
        return areaService;
    }
    public static AttachmentService getAttachmentService() {
    	if(attachmentService == null) {
    		attachmentService = SpringUtils.getBean(AttachmentService.class);
    	}
    	return attachmentService;
    }
    public static TagsService getTagsService() {
    	if(tagsService == null) {
    		tagsService = SpringUtils.getBean(TagsService.class);
    	}
    	return tagsService;
    }
    
    /**
	 * 将对象object转换成json对象
	 * @param object
	 * @return
	 */
	public static String toJSON(Object object){
		JsonConfig jsonconfig = new JsonConfig();
		jsonconfig.setExcludes(new String[]{"file"});//除去file属性
		if(ObjectUtils.isNotEmpty(object)&&object instanceof Collection){
			return JSONArray.fromObject(object,jsonconfig).toString();
		}else if(ObjectUtils.isNotEmpty(object))
			return JSONObject.fromObject(object,jsonconfig).toString();
		else
			return null;
	}
	
	/**
     * 返回集合对象中指定字段组成的字符串
     * @param paramList
     * @param columnMethod
     * @param paramSplit
     * @return
     * @throws Exception
     */
    @SuppressWarnings("rawtypes")
	public static String joinObjColumnValList(Collection paramList,String columnMethod,String paramSplit) throws Exception{
    	StringBuffer returnValue = new StringBuffer();
    	for(Object obj : paramList){
    		obj = AnalysisObject.getResult(obj, columnMethod);
    		returnValue.append(obj.toString());
    		returnValue.append(paramSplit);
    	}
    	if(!"".endsWith(returnValue.toString()))
    		return returnValue.deleteCharAt(returnValue.length()-1).toString();
    	else
    		return "";
    }
    /**
     * 获取集合中某列等于某个值的对象
     * @param paramList
     * @param eqColumn
     * @param eqStr
     * @return
     * @throws Exception
     */
    @SuppressWarnings("rawtypes")
	public static Object getObjFromList(Collection paramList,String eqColumn,String eqStr) throws Exception{
    	Object retObj = null;
    	if(!CollectionUtils.isEmpty(paramList))
	    	for(Object obj : paramList){
	    		String eq = String.valueOf(AnalysisObject.getResult(obj, eqColumn));
	    		if(eqStr.equals(eq))
	    			retObj = obj;
	    	}
    	return retObj;
    }
}

