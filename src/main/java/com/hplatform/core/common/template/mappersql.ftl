<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd" >
<mapper namespace="${table.pkg}.${table.bumodel}.mapper.${table.domainName}Mapper" >
	<sql id="columns">
	<#list table.columnList as column> 
		${column.columnName} AS "${column.propertiesName}"<#if column_has_next>,</#if>
	</#list>
	</sql>
	<select id="findOne" parameterType="${table.domainName}" resultType="${table.domainName}">
		select 
			<include refid="columns"/>
		from ${table.tableName}
		<where>
			<if test="id != null and id != ''">
				id=${"#"}{id}
			</if>
		</where>
	</select>
	<select id="findAll" parameterType="${table.domainName}" resultType="${table.domainName}">
		select 
			 <include refid="columns"/>
		from ${table.tableName}
		<where>
			<#list table.columnList as column> 
				<if test="${column.propertiesName} != null and ${column.propertiesName} != ''">
					AND ${column.columnName}=${"#"}{${column.propertiesName}}
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