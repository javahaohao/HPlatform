<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/include/taglib.jsp"%>
<html>
<head>
    <title>子表${op}</title>
</head>
<body>
	<div class="page-content-area">
		<div class="page-header">
			<h1>
				子表
				<small>
					<i class="ace-icon fa fa-angle-double-right"></i>
					 ${op}
				</small>
			</h1>
		</div><!-- /.page-header -->
	
		<div class="row">
			<div class="col-xs-12">
				<!-- PAGE CONTENT BEGINS -->
				<form:form method="post" commandName="stuInfo" id="subForm" class="form-horizontal">
					<p>
						<shiro:hasPermission name="stuInfo:create">
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
						<form:label path="clsId" cssClass="control-label col-xs-12 col-sm-3 no-padding-right" for="clsId">班级：</form:label>
						<div class="col-xs-12 col-sm-5">
							<span class="block input-icon input-icon-right">
								<input id="id" name="name" class="class" value="${stuInfo.domainName}"/>
							</span>
						</div>
					</div>
					<div class="form-group">
						<form:label path="stuName" cssClass="control-label col-xs-12 col-sm-3 no-padding-right" for="stuName">学生名字：</form:label>
						<div class="col-xs-12 col-sm-5">
							<span class="block input-icon input-icon-right">
								<input id="id" name="name" class="class" value="${stuInfo.domainName}"/>
							</span>
						</div>
					</div>
					<div class="form-group">
						<form:label path="age" cssClass="control-label col-xs-12 col-sm-3 no-padding-right" for="age">年龄：</form:label>
						<div class="col-xs-12 col-sm-5">
							<span class="block input-icon input-icon-right">
								<input id="id" name="name" class="class" value="${stuInfo.domainName}"/>
							</span>
						</div>
					</div>
					<div class="form-group">
						<form:label path="sex" cssClass="control-label col-xs-12 col-sm-3 no-padding-right" for="sex">性别：</form:label>
						<div class="col-xs-12 col-sm-5">
							<span class="block input-icon input-icon-right">
								<input id="id" name="name" class="class" value="${stuInfo.domainName}"/>
							</span>
						</div>
					</div>
					<div class="form-group">
						<form:label path="createUser" cssClass="control-label col-xs-12 col-sm-3 no-padding-right" for="createUser">创建人：</form:label>
						<div class="col-xs-12 col-sm-5">
							<span class="block input-icon input-icon-right">
								<input id="id" name="name" class="class" value="${stuInfo.domainName}"/>
							</span>
						</div>
					</div>
					<div class="form-group">
						<form:label path="updateUser" cssClass="control-label col-xs-12 col-sm-3 no-padding-right" for="updateUser">修改人：</form:label>
						<div class="col-xs-12 col-sm-5">
							<span class="block input-icon input-icon-right">
								<input id="id" name="name" class="class" value="${stuInfo.domainName}"/>
							</span>
						</div>
					</div>
					<div class="form-group">
						<form:label path="createDate" cssClass="control-label col-xs-12 col-sm-3 no-padding-right" for="createDate">创建时间：</form:label>
						<div class="col-xs-12 col-sm-5">
							<span class="block input-icon input-icon-right">
								<input id="id" name="name" class="class" value="${stuInfo.domainName}"/>
							</span>
						</div>
					</div>
					<div class="form-group">
						<form:label path="updateDate" cssClass="control-label col-xs-12 col-sm-3 no-padding-right" for="updateDate">修改时间：</form:label>
						<div class="col-xs-12 col-sm-5">
							<span class="block input-icon input-icon-right">
								<input id="id" name="name" class="class" value="${stuInfo.domainName}"/>
							</span>
						</div>
					</div>
					<div class="form-group">
						<form:label path="className" cssClass="control-label col-xs-12 col-sm-3 no-padding-right" for="className">父表：</form:label>
						<div class="col-xs-12 col-sm-5">
							<span class="block input-icon input-icon-right">
							<form:select path="clsId" itemLabel="className" itemValue="id" items="${parents}" cssClass="select2 width-100 required" title="父表"></form:select>
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