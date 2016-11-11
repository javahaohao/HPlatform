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
					<form:hidden path="${column.propertiesName}"/>
					</#if>
					</#list>
					<#list table.columnList as column> 
					<#if !column.hideFlag??||!column.hideFlag>
					<div class="form-group">
						<form:label path="${column.propertiesName}" cssClass="control-label col-xs-12 col-sm-3 no-padding-right" for="${column.propertiesName}">${column.comments}：</form:label>
						<div class="col-xs-12 col-sm-5">
							<span class="block input-icon input-icon-right">
								<#if column.plugin=="587c1da1c19049e28577cfe988cef9b9">
								<form:input<#list column.columnElements as columnElement> ${columnElement.element.elementName}="${tableMapping(columnElement.elementValue!'',table.domainName)}"</#list>/>
								<i class="ace-icon fa fa-info-circle"></i>
								<#elseif column.plugin=="1db4e28fa5264429a4c9693fdad3eaa1">
								<form:select<#list column.columnElements as columnElement> ${columnElement.element.elementName}="${tableMapping(columnElement.elementValue!'',table.domainName)}"</#list>></form:select>
								<#elseif column.plugin=="b429024598fe4c00880e88292d8481ef">
								<form:textarea<#list column.columnElements as columnElement> ${columnElement.element.elementName}="${tableMapping(columnElement.elementValue!'',table.domainName)}"</#list>/>
								<#elseif column.plugin=="8b4c8d499e324d8aa096eb21b6a9c552">
								<form:hidden<#list column.columnElements as columnElement> ${columnElement.element.elementName}="${tableMapping(columnElement.elementValue!'',table.domainName)}"</#list>/>
								<#elseif column.plugin=="e27cd759855c4a0c8cd841d5241de654">
								<form:checkbox<#list column.columnElements as columnElement> ${columnElement.element.elementName}="${tableMapping(columnElement.elementValue!'',table.domainName)}"</#list>/>
								<#elseif column.plugin=="58e92e109b0448b3951913b65b6955c7">
								<form:label<#list column.columnElements as columnElement> ${columnElement.element.elementName}="${tableMapping(columnElement.elementValue!'',table.domainName)}"</#list>/>
								<#elseif column.plugin=="a3ed719e7c134ecc8017c85e651597ab">
								<form:password<#list column.columnElements as columnElement> ${columnElement.element.elementName}="${tableMapping(columnElement.elementValue!'',table.domainName)}"</#list>/>
								<#elseif column.plugin=="a257abedbd9f449abf3db63d9e584687">
								<form:radiobutton<#list column.columnElements as columnElement> ${columnElement.element.elementName}="${tableMapping(columnElement.elementValue!'',table.domainName)}"</#list>/>
								<#elseif column.plugin=="814ce70dd3a54b609992b66ac0407c1d">
								<form:radiobuttons<#list column.columnElements as columnElement> ${columnElement.element.elementName}="${tableMapping(columnElement.elementValue!'',table.domainName)}"</#list>/>
								<#elseif column.plugin=="6093dbcf5e59462294a135e973c5e055">
								<input<#list column.columnElements as columnElement> ${columnElement.element.elementName}="${tableMapping(columnElement.elementValue!'',table.domainName)}"</#list>/>
								<#elseif column.plugin=="96bb041317ec4d7281142201f5a0ac33">
								<select<#list column.columnElements as columnElement> ${columnElement.element.elementName}="${tableMapping(columnElement.elementValue!'',table.domainName)}"</#list>></select>
								<#elseif column.plugin=="b9da5ff4ca3f4dda920fb3ee7ea8880b">
								<textarea<#list column.columnElements as columnElement> ${columnElement.element.elementName}="${tableMapping(columnElement.elementValue!'',table.domainName)}"</#list>></textarea>
								<#elseif column.plugin=="c47f545bdb854584ae2fa3fc9e0645ca">
								<tags:editor<#list column.columnElements as columnElement> ${columnElement.element.elementName}="${tableMapping(columnElement.elementValue!'',table.domainName)}"</#list>></tags:editor>
								<#elseif column.plugin=="0673cb287bc048fa8f44f2a823f49f11">
								<tags:date<#list column.columnElements as columnElement> ${columnElement.element.elementName}="${tableMapping(columnElement.elementValue!'',table.domainName)}"</#list>></tags:date>
								<#elseif column.plugin=="7e75a40a48d347b6ad01cc561b58a080">
								<tags:webuploader<#list column.columnElements as columnElement> ${columnElement.element.elementName}="${tableMapping(columnElement.elementValue!'',table.domainName)}"</#list>></tags:webuploader>
								<#elseif column.plugin=="2a3daba88ae24a07891240835376dc16">
								<tags:area<#list column.columnElements as columnElement> ${columnElement.element.elementName}="${tableMapping(columnElement.elementValue!'',table.domainName)}"</#list>></tags:area>
								</#if>
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
				<#if (column.columnValidates?size>0&&!column.hideFlag)>
				${column.propertiesName}:{
					<#list column.columnValidates as columnValidate>
					${columnValidate.validate.value}:${columnValidate.validateVal}<#if columnValidate_has_next>,</#if>
					</#list>
				}<#if (column_has_next&&table.columnList[column_index+1].columnValidates?size>0)>,</#if>
				</#if>
				</#list>
			},{
				<#list table.columnList as column>
				<#if (column.columnValidates?size>0&&!column.hideFlag)>
				${column.propertiesName}:{
					<#list column.columnValidates as columnValidate>
					${columnValidate.validate.value}:${columnValidate.validateMessage}<#if columnValidate_has_next>,</#if>
					</#list>
				}<#if (column_has_next&&table.columnList[column_index+1].columnValidates?size>0)>,</#if>
				</#if>
				</#list>
			});
        });
    </script>
</body>
</html>