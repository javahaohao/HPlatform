package com.hplatform.core.constants;

import java.util.LinkedHashMap;
import java.util.Map;

public class Constants {
	public static final String CURRENT_USER = "user";
    public static final String CURRENT_MENUS = "menus";
    public static final String DEFAULT_PWD = "default_pwd";
    /*缓存标示-start*/
    //组织机构
    public static final String CACHE_ORGANIZATION = "organization";
    //组织机构键值对缓存
    public static final String CACHE_ORGANIZATION_K_V = "organization_k_v";
    //角色
    public static final String CACHE_ROLE = "role";
    //角色键值对缓存
    public static final String CACHE_ROLE_K_V = "role_k_v";
    //身份缓存
    public static final String AUTHENTICATION_CACHE = "authenticationCache";
    //身份缓存
    public static final String AUTHORIZATION_CACHE = "authorizationCache";
    
    //资源
    public static final String CACHE_RESOURCE = "resource";
    //资源键值对缓存
    public static final String CACHE_RESOURCE_K_V = "resource_k_v";
    //用户
    public static final String CACHE_USER = "user";
    //用户键值对缓存
    public static final String CACHE_USER_K_V = "user_k_v";
    //字典
    public static final String CACHE_DICT = "dict";
    //字典键值对缓存
    public static final String CACHE_DICT_K_V = "dict_k_v";
    //按照ID缓存子节点
    public static final String CACHE_DICT_PARENT = "dict_parentId";
    //实名认证缓存
    public static final String VERIFIED_CACHE = "verified_cache";
    //找回密码缓存
    public static final String REST_PWD_CACHE = "reset_pwd_cache";
    //账户密码重试缓存
    public static final String PASSWORDRETRY_CACHE = "passwordRetryCache";
    //区域字典k-v缓存
    public static final String CACHE_AREA_K_V = "area_k_v";
    //区域字典展现选中城市缓存
    public static final String CACHE_AREA_K_BROTHER = "area_k_brother";
    //区域字典展现省份信息缓存
    public static final String CACHE_AREA_K_PROVINCE = "area_k_province";
    /*缓存标示-end*/
    
    /*****系统初始化固定ID----Start******/
    //字典表的性别父ID
    public final String DICT_SEX_PARENT_ID="c4d5f1ceb4374134a6ba99306509248b";
    //教师类型父ID
    public final String DICT_USER_TYPE_PARENT_ID="f460ec2302a343c389e694cd6386a8b5";
    //新闻类型父ID
    public final String DICT_NEWS_TYPE_PARENT_ID="31257e49148f48b98cce5226d55e534f";
    //新闻来源父ID
    public final String DICT_NEWS_SOURCE_PARENT_ID="83762231c79140d886fddc6b4fa54844";
    //组织架构中“注册ID”
    public final String ORGANIZATION_REGISTER_ID="c9fcc8d97b34435d928242897f7db92a";
    //学员角色ID
    public final String ROLE_REGISTER_STUDENT_ID="575f7cc7fed244a6b812a0445aa420de";
    public final String ROLE_REGISTER_STUDENT_ROLE="学生或者家长";
    //家教角色ID
    public final String ROLE_REGISTER_TEACHER_ID="5cbe9db681794dd5a665221d5ee65721";
    public final String ROLE_REGISTER_TEACHER_ROLE="教师角色";
    //字典表系统设置父ID
    public final String DICT_SYSTEM_PARENT_ID="2";
    //字典表服务方式父ID
    public final String DICT_SERVICE_TYPE_PARENT_ID="1505314b90984d62b0f21364171afee9";
    //字典表家教状态父ID
    public final String DICT_SERVICE_STATUS_PARENT_ID="1e7cc889cd91494b82a678afcc9f8306";
    //字典表年级父ID
    public final String DICT_CLASS_PARENT_ID="243d8a7a1d854bb2b7ad171a01d06a99";
    //字典表学习状况父ID
    public final String DICT_LEARNING_PARENT_ID="ad1347b86def4dbebcaa49ebfcc10484";
    //字典表家教科目父ID
    public final String DICT_EXPERT_PARENT_ID="ebc9c83fb9f1433a9c2df8a7d107d24f";
    //字典表空闲时间父ID
    public final String DICT_FREE_DATE_PARENT_ID="0d460653327d42b899be08ba9896724b";
    //字典表资源类型父ID
    public final String DICT_FRONTCOVER_PARENT_ID="cc55195aabc043138370f6e2fdd987f0";
    //字典表学历父ID
    public final String DICT_DIPLOMA_PARENT_ID="95b31d2afd5642dcb63ec89c7f8bf5b1";
    //字典表显示“是”还是“否”父ID
    public final String DICT_YES_NO_PARENT_ID="7a946330990e45a3b935bfb191c77b9e";
    //字典表显示“是”ID
    public final String DICT_YES_PARENT_ID="22e97527036b4eaa898d2cc146cbefca";
    //字典表显示“否”ID
    public final String DICT_NO_PARENT_ID="5b7a9312727b4d03baa0dfbe5c7f1965";
    //字典表验证类型父节点
    public final String DICT_VALIDATE_PARENT_ID="989bd6c008c44f839d615ae5af6c372b";
    //代码生成器风格类型
    public final String DICT_FG_PARENT_ID="95c5803eae654919b12b9a3eec2082ec";
    //代码生成器风格类型jqgridID
    public final String DICT_FG_JQGRID_ID="5d1d3b7e94f947ada0837e83d4fc4a75";
    //代码生成器风格类型datatablesID
    public final String DICT_FG_DATATABLES_ID="e269dce001fb41ad9e6373eb56aaebf8";
    //上传路径ID
    public final String DICT_UPLOAD_ID="bdc2aaa7ddb94ef482687f858c0c8333";
    /*****系统初始化固定ID----End******/
    
    /*****模板文件----Start******/
    //注册账号邮箱验证码模板
    public final String TEMPLATE_EMAIL_CODE_CHECK="emailcodecheck.ftl";
    //密码重置验证模板
    public final String TEMPLATE_RESET_PWD="resetpwd.ftl";
    /*****模板文件----End******/
    
    public final String ADMIN_ID = "1";
    public final String TRUE = "T";
    public final String FALSE = "F";
    public final int RETRY_LOGIN_COUNT=5;
    
    //通讯事件类型
    //即时聊天
    public final String EVENT_TALK="talk";
    //在线状态
    public final String EVENT_ONLINE="online";
    //评论
    public final String EVENT_COMMENT="comment";
    //user
    public final String TALK_TYPE_USER="0";
    //group
    public final String TALK_TYPE_GROUP="1";

	//one
    public final String ONE="1";
	//zero
    public final String ZERO="0";


    
  //mysql映射java类型
    public final Map<String,String> mysqlDataTypeMap = new LinkedHashMap<String, String>();
    {
    	//初始化mysql对应java类型关系
    	mysqlDataTypeMap.put("VARCHAR","String");
    	mysqlDataTypeMap.put("CHAR","String");
    	mysqlDataTypeMap.put("BLOB","byte");
    	mysqlDataTypeMap.put("TEXT","String");
    	mysqlDataTypeMap.put("INTEGER","java.lang.Long");
    	mysqlDataTypeMap.put("INT","int");
    	mysqlDataTypeMap.put("TINYINT","java.lang.Integer");
    	mysqlDataTypeMap.put("SMALLINT","java.lang.Integer");
    	mysqlDataTypeMap.put("MEDIUMINT","java.lang.Integer");
    	mysqlDataTypeMap.put("BIT","java.lang.Boolean");
    	mysqlDataTypeMap.put("BIGINT","BigInteger");
    	mysqlDataTypeMap.put("FLOAT","java.lang.Float");
    	mysqlDataTypeMap.put("DOUBLE","java.lang.Double");
    	mysqlDataTypeMap.put("DECIMAL","java.math.BigDecimal");
    	mysqlDataTypeMap.put("DATE","java.util.Date");
    	mysqlDataTypeMap.put("DATETIME","java.util.Date");
    	mysqlDataTypeMap.put("YEAR","java.util.Date");
    }
    /**
     * 获取对应的java类型
     * @param columnType
     * @return
     */
    public String getMysqlDataType(String columnType){
    	return mysqlDataTypeMap.get(columnType.toUpperCase());
    }
    
    
    
	public Map<String, String> getMysqlDataTypeMap() {
		return mysqlDataTypeMap;
	}
	public String getDICT_SEX_PARENT_ID() {
		return DICT_SEX_PARENT_ID;
	}
	public String getDICT_USER_TYPE_PARENT_ID() {
		return DICT_USER_TYPE_PARENT_ID;
	}
	public String getDICT_NEWS_TYPE_PARENT_ID() {
		return DICT_NEWS_TYPE_PARENT_ID;
	}
	public String getDICT_NEWS_SOURCE_PARENT_ID() {
		return DICT_NEWS_SOURCE_PARENT_ID;
	}
	public String getORGANIZATION_REGISTER_ID() {
		return ORGANIZATION_REGISTER_ID;
	}
	public String getROLE_REGISTER_STUDENT_ID() {
		return ROLE_REGISTER_STUDENT_ID;
	}
	public String getROLE_REGISTER_STUDENT_ROLE() {
		return ROLE_REGISTER_STUDENT_ROLE;
	}
	public String getROLE_REGISTER_TEACHER_ID() {
		return ROLE_REGISTER_TEACHER_ID;
	}
	public String getROLE_REGISTER_TEACHER_ROLE() {
		return ROLE_REGISTER_TEACHER_ROLE;
	}
	public String getDICT_SYSTEM_PARENT_ID() {
		return DICT_SYSTEM_PARENT_ID;
	}
	public String getDICT_SERVICE_TYPE_PARENT_ID() {
		return DICT_SERVICE_TYPE_PARENT_ID;
	}
	public String getDICT_SERVICE_STATUS_PARENT_ID() {
		return DICT_SERVICE_STATUS_PARENT_ID;
	}
	public String getDICT_CLASS_PARENT_ID() {
		return DICT_CLASS_PARENT_ID;
	}
	public String getDICT_LEARNING_PARENT_ID() {
		return DICT_LEARNING_PARENT_ID;
	}
	public String getDICT_EXPERT_PARENT_ID() {
		return DICT_EXPERT_PARENT_ID;
	}
	public String getDICT_FREE_DATE_PARENT_ID() {
		return DICT_FREE_DATE_PARENT_ID;
	}
	public String getDICT_FRONTCOVER_PARENT_ID() {
		return DICT_FRONTCOVER_PARENT_ID;
	}
	public String getDICT_DIPLOMA_PARENT_ID() {
		return DICT_DIPLOMA_PARENT_ID;
	}
	public String getDICT_YES_NO_PARENT_ID() {
		return DICT_YES_NO_PARENT_ID;
	}
	public String getDICT_YES_PARENT_ID() {
		return DICT_YES_PARENT_ID;
	}
	public String getDICT_NO_PARENT_ID() {
		return DICT_NO_PARENT_ID;
	}
	public String getDICT_VALIDATE_PARENT_ID() {
		return DICT_VALIDATE_PARENT_ID;
	}
	public String getDICT_FG_PARENT_ID() {
		return DICT_FG_PARENT_ID;
	}
	public String getDICT_FG_JQGRID_ID() {
		return DICT_FG_JQGRID_ID;
	}
	public String getDICT_FG_DATATABLES_ID() {
		return DICT_FG_DATATABLES_ID;
	}
	public String getDICT_UPLOAD_ID() {
		return DICT_UPLOAD_ID;
	}
	public String getTEMPLATE_EMAIL_CODE_CHECK() {
		return TEMPLATE_EMAIL_CODE_CHECK;
	}
	public String getTEMPLATE_RESET_PWD() {
		return TEMPLATE_RESET_PWD;
	}
	public String getADMIN_ID() {
		return ADMIN_ID;
	}
	public String getTRUE() {
		return TRUE;
	}
	public String getFALSE() {
		return FALSE;
	}
	public int getRETRY_LOGIN_COUNT() {
		return RETRY_LOGIN_COUNT;
	}
	public String getEVENT_TALK() {
		return EVENT_TALK;
	}
	public String getEVENT_ONLINE() {
		return EVENT_ONLINE;
	}
	public String getEVENT_COMMENT() {
		return EVENT_COMMENT;
	}
	public String getTALK_TYPE_USER() {
		return TALK_TYPE_USER;
	}
	public String getTALK_TYPE_GROUP() {
		return TALK_TYPE_GROUP;
	}

	public String getONE() {
		return ONE;
	}

	public String getZERO() {
		return ZERO;
	}
}
