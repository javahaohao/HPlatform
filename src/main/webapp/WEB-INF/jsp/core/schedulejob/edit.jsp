<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/include/taglib.jsp"%>
<html>
<head>
    <tags:header inplugins="${plugins.jqui},${plugins.validate}" title="任务调度表${op}"></tags:header>
</head>
<body>
	<div class="page-content-area">
		<div class="page-header">
			<h1>
				任务调度表
				<small>
					<i class="ace-icon fa fa-angle-double-right"></i>
					 ${op}
				</small>
			</h1>
		</div><!-- /.page-header -->
	
		<div class="row">
			<div class="col-xs-12">
				<!-- PAGE CONTENT BEGINS -->
				<form:form method="post" commandName="scheduleJob" id="subForm" class="form-horizontal">
					<p>
						<shiro:hasPermission name="scheduleJob:create">
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
						<form:label path="jobId" cssClass="control-label col-xs-12 col-sm-3 no-padding-right" for="jobId">：</form:label>
						<div class="col-xs-12 col-sm-5">
							<span class="block input-icon input-icon-right">
								<input/>
							</span>
						</div>
					</div>
					<div class="form-group">
						<form:label path="jobName" cssClass="control-label col-xs-12 col-sm-3 no-padding-right" for="jobName">：</form:label>
						<div class="col-xs-12 col-sm-5">
							<span class="block input-icon input-icon-right">
								<input/>
							</span>
						</div>
					</div>
					<div class="form-group">
						<form:label path="jobGroup" cssClass="control-label col-xs-12 col-sm-3 no-padding-right" for="jobGroup">：</form:label>
						<div class="col-xs-12 col-sm-5">
							<span class="block input-icon input-icon-right">
								<input/>
							</span>
						</div>
					</div>
					<div class="form-group">
						<form:label path="jobImpl" cssClass="control-label col-xs-12 col-sm-3 no-padding-right" for="jobImpl">：</form:label>
						<div class="col-xs-12 col-sm-5">
							<span class="block input-icon input-icon-right">
								<input/>
							</span>
						</div>
					</div>
					<div class="form-group">
						<form:label path="jobStatus" cssClass="control-label col-xs-12 col-sm-3 no-padding-right" for="jobStatus">：</form:label>
						<div class="col-xs-12 col-sm-5">
							<span class="block input-icon input-icon-right">
								<input/>
							</span>
						</div>
					</div>
					<div class="form-group">
						<form:label path="cronExpression" cssClass="control-label col-xs-12 col-sm-3 no-padding-right" for="cronExpression">：</form:label>
						<div class="col-xs-12 col-sm-5">
							<span class="block input-icon input-icon-right">
								<input/>
							</span>
						</div>
					</div>
					<div class="form-group">
						<form:label path="desc" cssClass="control-label col-xs-12 col-sm-3 no-padding-right" for="desc">：</form:label>
						<div class="col-xs-12 col-sm-5">
							<span class="block input-icon input-icon-right">
								<input/>
							</span>
						</div>
					</div>
					<div class="form-group">
						<form:label path="createDate" cssClass="control-label col-xs-12 col-sm-3 no-padding-right" for="createDate">：</form:label>
						<div class="col-xs-12 col-sm-5">
							<span class="block input-icon input-icon-right">
								<input/>
							</span>
						</div>
					</div>
					<div class="form-group">
						<form:label path="updateDate" cssClass="control-label col-xs-12 col-sm-3 no-padding-right" for="updateDate">：</form:label>
						<div class="col-xs-12 col-sm-5">
							<span class="block input-icon input-icon-right">
								<input/>
							</span>
						</div>
					</div>
					<div class="form-group">
						<form:label path="createUser" cssClass="control-label col-xs-12 col-sm-3 no-padding-right" for="createUser">：</form:label>
						<div class="col-xs-12 col-sm-5">
							<span class="block input-icon input-icon-right">
								<input/>
							</span>
						</div>
					</div>
					<div class="form-group">
						<form:label path="updateUser" cssClass="control-label col-xs-12 col-sm-3 no-padding-right" for="updateUser">：</form:label>
						<div class="col-xs-12 col-sm-5">
							<span class="block input-icon input-icon-right">
								<input/>
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
			formValidate($("#subForm"), 'help-block inline error', 'div',{
			},{
			});
        });
    </script>
</body>
</html>