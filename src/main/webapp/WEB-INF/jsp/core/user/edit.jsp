<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/include/taglib.jsp"%>
<html>
<head>
    <tags:header inplugins="${plugins.jqui},${plugins.validate}" title="${op}用户"></tags:header>
</head>
<body>

	<div class="page-content-area">
		<div class="page-header">
			<h1>
				用户
				<small>
					<i class="ace-icon fa fa-angle-double-right"></i>
					 修改/新增
				</small>
			</h1>
		</div><!-- /.page-header -->
	
		<div class="row">
			<div class="col-xs-12">
				<!-- PAGE CONTENT BEGINS -->
				<form:form method="post" commandName="user" id="subForm" class="form-horizontal">
					<p>
						<shiro:hasPermission name="user:create">
							<button id="btnSave" type="submit" class="btn btn-info no-border">
								<i class="ace-icon fa fa-edit align-top bigger-125"></i>
								${op}
							</button>
						</shiro:hasPermission>
						<button id="btnBack"class="btn btn-danger no-border" type="button" onclick="javascript:history.go(-1);">
							<i class="ace-icon fa fa-undo align-top bigger-125"></i>
							返回
						</button>
					</p>
			        <form:hidden path="id"/>
			        <form:hidden path="salt"/>
			        <form:hidden path="locked"/>
					
					<div class="form-group">
			            <form:label path="realName" cssClass="control-label col-xs-12 col-sm-3 no-padding-right" for="realName">用户姓名：</form:label>
			            <div class="col-xs-12 col-sm-5">
							<span class="block input-icon input-icon-right">
								<form:input path="realName" maxlength="50" cssClass="width-100 required input-xlarge" title="姓名必填"/>
								<i class="ace-icon fa fa-info-circle"></i>
							</span>
						</div>
			        </div>
			        
			        <c:if test="${op ne '新增'}">
			            <form:hidden path="password"/>
			        </c:if>
			        <div class="form-group">
			            <form:label path="username" cssClass="control-label col-xs-12 col-sm-3 no-padding-right" for="username">用户名：</form:label>
			            <div class="col-xs-12 col-sm-5">
							<span class="block input-icon input-icon-right">
								<form:input path="username" maxlength="50" cssClass="width-100 required input-xlarge" title="用户名必填"/>
								<i class="ace-icon fa fa-info-circle"></i>
							</span>
						</div>
			        </div>
			
			        <c:if test="${op eq '新增'}">
			        	<div class="form-group">
				            <form:label path="password" cssClass="control-label col-xs-12 col-sm-3 no-padding-right" for="password">密码：</form:label>
				            <div class="col-xs-12 col-sm-5">
								<span class="block input-icon input-icon-right">
									<form:password path="password" maxlength="50" cssClass="width-100 required input-xlarge" title="密码必填"/>
									<i class="ace-icon fa fa-info-circle"></i>
								</span>
							</div>
				        </div>
			        </c:if>
			        <div class="form-group">
			            <form:label path="userType" cssClass="control-label col-xs-12 col-sm-3 no-padding-right" for="username">人员类型必选：</form:label>
			            <div class="col-xs-12 col-sm-5">
							<span class="block input-icon input-icon-right">
								<form:select path="userType" itemLabel="name" itemValue="id" items="${userTypeList}" cssClass="select2 width-100 required input-xlarge" title="人员类型必选"></form:select>
							</span>
						</div>
			        </div>
			        <div class="form-group">
			            <form:label path="organizationId" cssClass="control-label col-xs-12 col-sm-3 no-padding-right" for="organizationId">所属组织：</form:label>
			            <div class="col-xs-12 col-sm-5">
							<span class="block input-icon input-icon-right">
			            		<tags:tree name="organizationId" title="所属组织必填" 
			            		value="${user.organizationId}" checked="false"
			            		cssClass="width-100 required" labelName="organizationName" 
			            		labelValue="${elfn:organizationName(user.organizationId)}" 
			            		data="${organizationList}"></tags:tree>
			            		<i class="ace-icon fa fa-info-circle"></i>
							</span>
						</div>
			        </div>
					<div class="form-group">
			            <form:label path="roleIds" cssClass="control-label col-xs-12 col-sm-3 no-padding-right" for="roleIds">角色列表：</form:label>
			            <div class="col-xs-12 col-sm-5">
							<span class="block input-icon input-icon-right">
								<form:select path="roleIds" items="${roleList}" itemLabel="description" itemValue="id" multiple="true"/>
			            		(按住shift键多选)
							</span>
						</div>
			        </div>
					
			    </form:form>
				<!-- PAGE CONTENT ENDS -->
			</div><!-- /.col -->
		</div><!-- /.row -->
	</div><!-- /.page-content-area -->

    <script>
        $(function () {
			//添加表单验证
        	formValidate($("#subForm"), 'help-block inline error', 'div');
        });
    </script>

</body>
</html>