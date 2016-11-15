<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/include/taglib.jsp"%>
<html>
<head>
    <tags:header inplugins="${"$"}{plugins.jqui},${"$"}{plugins.validate}" title="${table.comments}${"$"}{op}"></tags:header>
</head>
<body>
	<div class="page-content-area">
		<div class="page-header">
			<h1>
				${table.comments}
				<small>
					<i class="ace-icon fa fa-angle-double-right"></i>
					 ${"$"}{op}
				</small>
			</h1>
		</div><!-- /.page-header -->
	
		<div class="row">
			<div class="col-xs-12">
				<!-- PAGE CONTENT BEGINS -->
				<form:form method="post" commandName="${table.domainName?uncap_first}" id="subForm" class="form-horizontal">
					<p>
						<shiro:hasPermission name="${table.domainName?uncap_first}:create">
							<button id="btnSave" type="submit" class="btn btn-info no-border">
								<i class="ace-icon fa fa-edit align-top bigger-125"></i>
								${"$"}{op}
							</button>
						</shiro:hasPermission>
						<button id="btnBack"class="btn btn-danger no-border" type="button" onclick="javascript:history.go(-1);">
							<i class="ace-icon fa fa-undo align-top bigger-125"></i>
							返回
						</button>
					</p>
					<#list table.columnList as column> 
					<#if column.hideFlag??&&column.hideFlag>
					<#include "gen_tags.ftl" encoding="UTF-8">
					</#if>
					</#list>
					<#list table.columnList as column> 
					<#if (!column.hideFlag??||!column.hideFlag)&&!excludeColumns?seq_contains(column.propertiesName)>
					<div class="form-group">
						<form:label path="${column.propertiesName}" cssClass="control-label col-xs-12 col-sm-3 no-padding-right" for="${column.propertiesName}">${column.comments}：</form:label>
						<div class="col-xs-12 col-sm-5">
							<span class="block input-icon input-icon-right">
								<#include "gen_tags.ftl" encoding="UTF-8">
                                <i class="ace-icon fa fa-info-circle"></i>
							</span>
						</div>
					</div>
					</#if>
					</#list>
			    </form:form>
				<!-- PAGE CONTENT ENDS -->
			</div><!-- /.col -->
		</div><!-- /.row -->
	</div><!-- /.page-content-area -->
    <script type="text/javascript">
        $(function () {
			//添加表单验证
			formValidate($("#subForm"), 'help-block inline error', 'div',{
				<#list table.columnList as column>
				<#if (column.columnValidates?size>0&&!column.hideFlag)&&!excludeColumns?seq_contains(column.propertiesName)>
				${column.propertiesName}:{
					<#list column.columnValidates as columnValidate>
					${columnValidate.validate.value}:${columnValidate.validateVal}<#if columnValidate_has_next>,</#if>
					</#list>
				}<#if (column_has_next&&table.columnList[column_index+1].columnValidates?size>0)>,</#if>
				</#if>
				</#list>
			},{
				<#list table.columnList as column>
				<#if (column.columnValidates?size>0&&!column.hideFlag)&&!excludeColumns?seq_contains(column.propertiesName)>
				${column.propertiesName}:{
					<#list column.columnValidates as columnValidate>
					${columnValidate.validate.value}:'${columnValidate.validateMessage}'<#if columnValidate_has_next>,</#if>
					</#list>
				}<#if (column_has_next&&table.columnList[column_index+1].columnValidates?size>0)>,</#if>
				</#if>
				</#list>
			});
        });
    </script>
</body>
</html>