package ${table.pkg}.${table.bumodel}.entity;

import com.hplatform.core.entity.BaseEntity;
import java.util.List;

public class ${table.domainName} extends BaseEntity<${table.domainName}>{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
<#list table.columnList as column>
	<#if column.propertiesName!="id"&&column.propertiesName!="createDate"&&column.propertiesName!="createUser"&&column.propertiesName!="updateDate"&&column.propertiesName!="updateUser"> 
	private ${column.propertiesType} ${column.propertiesName};
	</#if> 
</#list>
	private ${table.parent.domainName} ${table.parent.domainName?uncap_first};
<#list table.columnList as column> 
<#if column.propertiesName!="id"&&column.propertiesName!="createDate"&&column.propertiesName!="createUser"&&column.propertiesName!="updateDate"&&column.propertiesName!="updateUser">
	public void set${column.propertiesName?cap_first}(${column.propertiesType} ${column.propertiesName}){
		this.${column.propertiesName}=${column.propertiesName};
	}
	public ${column.propertiesType} get${column.propertiesName?cap_first}(){
		return this.${column.propertiesName};
	}
</#if> 
</#list>
	public void set${table.parent.domainName}(${table.parent.domainName} ${table.parent.domainName?uncap_first}){
		this.${table.parent.domainName?uncap_first}=${table.parent.domainName?uncap_first};
	}
	public ${table.parent.domainName} get${table.parent.domainName}(){
		return this.${table.parent.domainName?uncap_first};
	}
}