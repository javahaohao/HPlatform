<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<tags:header inplugins="${plugins.jqui},${plugins.validate}" title="方案编辑"></tags:header>
</head>
<body>
	<div class="page-content-area">
		<div class="page-header">
			<h1>
				方案编辑
				<small>
					<i class="ace-icon fa fa-angle-double-right"></i>
					 ${op}
				</small>
			</h1>
		</div><!-- /.page-header -->
	
		<div class="row">
			<div class="col-xs-12">
				<!-- PAGE CONTENT BEGINS -->
				<form:form method="post" commandName="table" id="subForm" class="form-horizontal">
					<p>
						<shiro:hasPermission name="table:create">
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
			
		        	<div class="form-group">
			            <form:label path="tableName" cssClass="control-label col-xs-12 col-sm-3 no-padding-right">表名:</form:label>
			            <div class="col-xs-12 col-sm-5">
			            	<span class="block input-icon input-icon-right">
				            	<form:input path="tableName" maxlength="50" cssClass="width-100 required" title="表名必填"/>
								<i class="ace-icon fa fa-info-circle"></i>
							</span>
						</div>
			        </div>
			        <div class="form-group">
			            <form:label path="domainName" cssClass="control-label col-xs-12 col-sm-3 no-padding-right">实体类名:</form:label>
			            <div class="col-xs-12 col-sm-5">
			            	<span class="block input-icon input-icon-right">
				            	<form:input path="domainName" maxlength="50" cssClass="width-100 required" title="实体类名必填"/>
								<i class="ace-icon fa fa-info-circle"></i>
							</span>
						</div>
			        </div>
			        <div class="form-group">
			            <form:label path="bumodel" cssClass="control-label col-xs-12 col-sm-3 no-padding-right">业务模块:</form:label>
			            <div class="col-xs-12 col-sm-5">
			            	<span class="block input-icon input-icon-right">
				            	<form:input path="bumodel" maxlength="50" cssClass="width-100 required" title="业务模块必填"/>
								<i class="ace-icon fa fa-info-circle"></i>
							</span>
						</div>
			        </div>
			        <div class="form-group">
			            <form:label path="pkg" cssClass="control-label col-xs-12 col-sm-3 no-padding-right">包名:</form:label>
			            <div class="col-xs-12 col-sm-5">
			            	<span class="block input-icon input-icon-right">
				            	<form:input path="pkg" maxlength="50" cssClass="width-100 required" title="包名必填"/>
								<i class="ace-icon fa fa-info-circle"></i>
							</span>
						</div>
			        </div>
			        <div class="form-group">
			            <form:label path="pkg" cssClass="control-label col-xs-12 col-sm-3 no-padding-right">风格类型:</form:label>
			            <div class="col-xs-12 col-sm-5">
			            	<span class="block input-icon input-icon-right">
			            		<form:select path="fgType" itemLabel="name" itemValue="id" items="${elfn:getChildDictById(constants.DICT_FG_PARENT_ID)}" cssClass="select2 width-100 required input-xlarge" title="生成风格类型"></form:select>
							</span>
						</div>
			        </div>
			        <div class="form-group">
			            <form:label path="comments" cssClass="control-label col-xs-12 col-sm-3 no-padding-right">描述:</form:label>
			            <div class="col-xs-12 col-sm-5">
			            	<span class="block input-icon input-icon-right">
				            	<form:textarea path="comments" cssClass="width-100 input-xlarge"/>
							</span>
						</div>
			        </div>
			    </form:form>
				<!-- PAGE CONTENT ENDS -->
			</div><!-- /.col -->
		</div><!-- /.row -->
	</div><!-- /.page-content-area -->
	<script type="text/javascript">
		$(function(){
			//添加表单验证
        	formValidate($("#subForm"), 'help-block inline error', 'div');
		});
	</script>
</body>
</html>