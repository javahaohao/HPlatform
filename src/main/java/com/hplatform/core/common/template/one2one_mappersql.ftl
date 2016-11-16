<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd" >
<mapper namespace="${table.pkg}.${table.bumodel}.mapper.${table.domainName}Mapper" >
	<sql id="columns">
	<#list table.columnList as column> 
		${table.tableAlias}.${column.columnName} AS "${column.propertiesName}",
	</#list>
	<#list table.childs as childTable>
		<#list childTable.columnList as column>
		${childTable.tableAlias}.${column.columnName} AS "${childTable.tableAlias}${column.propertiesName}"<#if childTable_has_next||column_has_next>,</#if>
		</#list>
	</#list>
	</sql>
	<select id="findOne" parameterType="${table.domainName}" resultType="${table.domainName}">
		SELECT 
			<include refid="columns"/>
		FROM ${table.tableName} ${table.tableAlias}
		<#list table.childs as childTable>
        LEFT JOIN ${childTable.tableName} ${childTable.tableAlias} ON ${table.tableAlias}.id = ${childTable.tableAlias}.${table.foreignKey}
		</#list>
		<where>
			<if test="id != null and id != ''">
				${table.tableAlias}.id=${"#"}{id}
			</if>
		</where>
	</select>
	<select id="findAll" parameterType="${table.domainName}" resultType="${table.domainName}">
		SELECT 
			 <include refid="columns"/>
		FROM ${table.tableName} ${table.tableAlias}
		<#list table.childs as childTable>
        LEFT JOIN ${childTable.tableName} ${childTable.tableAlias} ON ${table.tableAlias}.id = ${childTable.tableAlias}.${table.foreignKey}
		</#list>
		<where>
			<#list table.columnList as column> 
				<if test="${column.propertiesName} != null and ${column.propertiesName} != ''">
					AND ${table.tableAlias}.${column.columnName}=${"#"}{${column.propertiesName}}
				</if>
			</#list>
		</where>
	</select>
	<insert id="addEntity" parameterType="${table.domainName}">
		insert into 
		${table.tableName}(
		<#list table.columnList as column> 
			${column.columnName}<#if column_has_next>,</#if>
		</#list>
		) 
		values(
		<#list table.columnList as column> 
			${"#"}{${column.propertiesName}}<#if column_has_next>,</#if>
		</#list>
		)
	</insert>
	<update id="updateEntity" parameterType="${table.domainName}">
		update 
			${table.tableName} 
		<set>
		<#list table.columnList as column> 
		<if test="${column.propertiesName} !=null and ${column.propertiesName} !=''">
			${column.columnName}=${"#"}{${column.propertiesName}}<#if column_has_next>,</#if>
		</if>
		</#list>
		</set>
		where id=${"#"}{id}
	</update>
	<delete id="deleteEntity" parameterType="${table.domainName}">
		delete from ${table.tableName} where id=${"#"}{id}
	</delete>
	<delete id="deleteBatchEntity" parameterType="${table.domainName}">
		delete from ${table.tableName} 
		WHERE id IN 
		<foreach item="idList" collection="idList"
		open="(" separator="," close=")">
		${"#"}{idList}
		</foreach>
	</delete>
</mapper>