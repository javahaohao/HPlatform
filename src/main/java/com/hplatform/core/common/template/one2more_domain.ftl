package ${table.pkg}.${table.bumodel}.entity;

import com.hplatform.core.entity.BaseEntity;
import java.util.List;

public class ${table.domainName} extends BaseEntity<${table.domainName}>{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
<#list table.columnList as column>
	<#if column.propertiesName!="id"&&!excludeColumns?seq_contains(column.propertiesName)>
	private ${column.propertiesType} ${column.propertiesName};
	</#if> 
</#list>
<#list table.childs as child>
	private List<${child.domainName}> ${child.domainName?uncap_first}List;
</#list>
<#list table.columnList as column> 
<#if column.propertiesName!="id"&&!excludeColumns?seq_contains(column.propertiesName)>
	public void set${column.propertiesName?cap_first}(${column.propertiesType} ${column.propertiesName}){
		this.${column.propertiesName}=${column.propertiesName};
	}
	public ${column.propertiesType} get${column.propertiesName?cap_first}(){
		return this.${column.propertiesName};
	}
</#if> 
</#list>
<#list table.childs as child>
	public void set${child.domainName}List(List<${child.domainName}> ${child.domainName?uncap_first}List){
		this.${child.domainName?uncap_first}List=${child.domainName?uncap_first}List;
	}
	public List<${child.domainName}> get${child.domainName}List(){
		return this.${child.domainName?uncap_first}List;
	}
</#list>
}