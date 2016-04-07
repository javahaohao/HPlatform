<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<tags:header inplugins="${plugins.jqui},${plugins.validate},${plugins.ztree}" title="${op}组织机构"></tags:header>
</head>
<body>
	<div class="page-content-area">
		<div class="page-header">
			<h1>
				组织机构
				<small>
					<i class="ace-icon fa fa-angle-double-right"></i>
					 ${op}
				</small>
			</h1>
		</div><!-- /.page-header -->
	
		<div class="row">
			<div class="col-xs-12">
				<!-- PAGE CONTENT BEGINS -->
				<form:form method="post" commandName="organization" id="subForm" class="form-horizontal">
					<p>
						<shiro:hasPermission name="organization:create">
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
			        <form:hidden path="available"/>
			        <form:hidden path="parentIds"/>
			
		        	<div class="form-group">
			            <form:label path="" cssClass="control-label col-xs-12 col-sm-3 no-padding-right">父节点名称：</form:label>
			            <div class="col-xs-12 col-sm-5">
							<tags:tree name="parentId" title="所属父节点" 
		            		value="${organization.parentId}" checked="false"
		            		cssClass="width-100 required" labelName="parentName" 
		            		labelValue="${elfn:organizationName(organization.parentId)}" 
		            		data="${organizationList}" checkHandler="checkHandler"></tags:tree>
						</div>
			        </div>
					<div class="form-group">
			            <form:label path="name" cssClass="control-label col-xs-12 col-sm-3 no-padding-right" for="name">名称：</form:label>
			            <div class="col-xs-12 col-sm-5">
							<span class="block input-icon input-icon-right">
								<form:input path="name" maxlength="50" cssClass="width-100 required" title="名称必填"/>
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