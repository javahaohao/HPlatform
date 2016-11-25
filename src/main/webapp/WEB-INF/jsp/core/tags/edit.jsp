<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/include/taglib.jsp"%>
<html>
<head>
    <tags:header inplugins="${plugins.jqui},${plugins.validate}" title="标签库${op}"></tags:header>
</head>
<body>
	<div class="page-content-area">
		<div class="page-header">
			<h1>
				标签库
				<small>
					<i class="ace-icon fa fa-angle-double-right"></i>
					 ${op}
				</small>
			</h1>
		</div><!-- /.page-header -->
	
		<div class="row">
			<div class="col-xs-12">
				<!-- PAGE CONTENT BEGINS -->
				<form:form method="post" commandName="tags" id="subForm" class="form-horizontal">
					<p>
						<shiro:hasPermission name="tags:create">
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
					<div class="form-group">
						<form:label path="tagName" cssClass="control-label col-xs-12 col-sm-3 no-padding-right" for="tagName">标签名字：</form:label>
						<div class="col-xs-12 col-sm-5">
							<span class="block input-icon input-icon-right">
								<form:input path="tagName" cssClass="width-100 input-xlarge"/>
								<i class="ace-icon fa fa-info-circle"></i>
							</span>
						</div>
					</div>
					<div class="form-group">
						<form:label path="sequence" cssClass="control-label col-xs-12 col-sm-3 no-padding-right" for="sequence">标签排序：</form:label>
						<div class="col-xs-12 col-sm-5">
							<span class="block input-icon input-icon-right">
								<form:input path="sequence" cssClass="width-100 input-xlarge"/>
								<i class="ace-icon fa fa-info-circle"></i>
							</span>
						</div>
					</div>
					<div class="form-group">
						<form:label path="remark" cssClass="control-label col-xs-12 col-sm-3 no-padding-right" for="remark">说明：</form:label>
						<div class="col-xs-12 col-sm-5">
							<span class="block input-icon input-icon-right">
								<form:input path="remark" cssClass="width-100 input-xlarge"/>
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
        $(function () {
			//添加表单验证
        	formValidate($("#subForm"), 'help-block inline error', 'div');
        });
    </script>
</body>
</html>