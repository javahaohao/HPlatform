<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/include/taglib.jsp"%>
<html>
<head>
    <tags:header inplugins="${plugins.jqui},${plugins.validate},${plugins.ztree}" title="${op}资源"></tags:header>
</head>
<body>
	<div class="page-content-area">
		<div class="page-header">
			<h1>
				资源
				<small>
					<i class="ace-icon fa fa-angle-double-right"></i>
					 ${op}
				</small>
			</h1>
		</div><!-- /.page-header -->
	
		<div class="row">
			<div class="col-xs-12">
				<!-- PAGE CONTENT BEGINS -->
				<form:form method="post" commandName="resource" id="subForm" class="form-horizontal">
					<p>
						<shiro:hasPermission name="resource:create">
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
			        <form:hidden path="parentIds"/>
			
		        	<div class="form-group">
			            <form:label path="" cssClass="control-label col-xs-12 col-sm-3 no-padding-right">父节点名称：</form:label>
			            <div class="col-xs-12 col-sm-5">
							<tags:tree name="parentId" title="所属父节点" 
		            		value="${resource.parentId}" checked="false"
		            		cssClass="width-100 required" labelName="parentName" 
		            		labelValue="${elfn:resourceName(resource.parentId)}" 
		            		data="${resourceList}" checkHandler="checkHandler"></tags:tree>
						</div>
			        </div>
					<div class="form-group">
			            <form:label path="name" cssClass="control-label col-xs-12 col-sm-3 no-padding-right" for="name"><c:if test="${not empty parent}">子</c:if>名称：</form:label>
			            <div class="col-xs-12 col-sm-5">
							<span class="block input-icon input-icon-right">
								<i class="ace-icon fa fa-info-circle"></i>
								<form:input path="name" maxlength="50" cssClass="width-100 required" title="名称必填"/>
							</span>
						</div>
			        </div>
			        <c:if test="${resource.type ne 'button'}">
					<div class="form-group">
			            <form:label path="name" cssClass="control-label col-xs-12 col-sm-3 no-padding-right" for="name">图标：</form:label>
			            <div class="col-xs-12 col-sm-5">
							<span class="block input-icon input-icon-right">
								<tags:icon name="icon" id="icon" value="${resource.icon}"></tags:icon>
							</span>
						</div>
			        </div>
			        </c:if>
			        <div class="form-group">
			            <form:label path="type" cssClass="control-label col-xs-12 col-sm-3 no-padding-right" for="type">类型：</form:label>
			            <div class="col-xs-12 col-sm-5">
							<span class="block input-icon input-icon-right">
								<form:select path="type" items="${types}" itemLabel="info" cssClass="select2 width-100 required"/>
							</span>
						</div>
			        </div>
					<div class="form-group">
			            <form:label path="url" cssClass="control-label col-xs-12 col-sm-3 no-padding-right" for="url">URL路径：</form:label>
			            <div class="col-xs-12 col-sm-5">
							<span class="block input-icon input-icon-right">
								<form:input path="url" cssClass="width-100" title="URL路径必填"/>
								<i class="ace-icon fa fa-info-circle"></i>
							</span>
						</div>
			        </div>
					<div class="form-group">
			            <form:label path="permission" cssClass="control-label col-xs-12 col-sm-3 no-padding-right" for="permission">权限字符串：</form:label>
			            <div class="col-xs-12 col-sm-5">
							<span class="block input-icon input-icon-right">
								<form:input path="permission" cssClass="width-100"/>
								<i class="ace-icon fa fa-info-circle"></i>
							</span>
						</div>
			        </div>
			    </form:form>
				<!-- PAGE CONTENT ENDS -->
			</div><!-- /.col -->
		</div><!-- /.row -->
	</div><!-- /.page-content-area -->
	<script type="text/javascript">
		function checkHandler(treeNode){
			$('#parentIds').val(treeNode.pIds+treeNode.id+'/');
		}
		$(function(){
			//添加表单验证
        	formValidate($("#subForm"), 'help-block inline error', 'div');
		});
	</script>
</body>
</html>