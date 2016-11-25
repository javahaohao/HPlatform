<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/include/taglib.jsp"%>
<html>
<head>
    <title>角色${op}</title>
</head>
<body>
	<div class="page-content-area">
		<div class="page-header">
			<h1>
				角色
				<small>
					<i class="ace-icon fa fa-angle-double-right"></i>
					 ${op}
				</small>
			</h1>
		</div><!-- /.page-header -->
	
		<div class="row">
			<div class="col-xs-12">
				<!-- PAGE CONTENT BEGINS -->
				<form:form method="post" commandName="role" id="subForm" class="form-horizontal">
					<p>
						<shiro:hasPermission name="role:create">
							<button id="btnSave" type="submit" class="btn btn-info no-border btn-sm">
								<i class="ace-icon fa fa-edit align-top bigger-125"></i>
								${op}
							</button>
						</shiro:hasPermission>
						<button id="btnBack"class="btn btn-danger no-border btn-sm" type="button" onclick="javascript:history.go(-1);">
							<i class="ace-icon fa fa-undo align-top bigger-125"></i>
							返回
						</button>
					</p>
			        <form:hidden path="id"/>
			        <form:hidden path="available"/>
			
					<div class="form-group">
						<form:label path="role" cssClass="control-label col-xs-12 col-sm-3 no-padding-right" for="role">角色名：</form:label>
						<div class="col-xs-12 col-sm-5">
							<span class="block input-icon input-icon-right">
								<form:input path="role" maxlength="50" cssClass="width-100 required input-xlarge" title="角色名称必填"/>
								<i class="ace-icon fa fa-info-circle"></i>
							</span>
						</div>
					</div>
			
					<div class="form-group">
						<form:label path="description" cssClass="control-label col-xs-12 col-sm-3 no-padding-right" for="description">角色描述：</form:label>
						<div class="col-xs-12 col-sm-5">
							<span class="block input-icon input-icon-right">
								<form:input path="description" maxlength="50" cssClass="width-100 required input-xlarge" title="角色描述必填"/>
								<i class="ace-icon fa fa-info-circle"></i>
							</span>
						</div>
					</div>
			
			        <div class="form-group">
			            <form:label path="resourceIds" cssClass="control-label col-xs-12 col-sm-3 no-padding-right" for="resourceIds">拥有的资源列表：</form:label>
			            <div class="col-xs-12 col-sm-5">
							<span class="block input-icon input-icon-right">
					            <tags:tree name="resourceIds" title="拥有的资源必选" labelName="resourceName" cssClass="width-100 required input-xlarge" checked="true"
					            value="${role.resourceIds}" labelValue="${elfn:resourceNames(role.resourceIds)}" 
					            data="${resourceList}"></tags:tree>
					            <i class="ace-icon fa fa-info-circle"></i>
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