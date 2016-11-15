<%@page import="com.hplatform.core.entity.Table"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<tags:header inplugins="${plugins.jqui},${plugins.validate},${plugins.select2},${plugins.template},${plugins.jbox}" title="方案编辑"></tags:header>
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
				<form:form method="post" commandName="table" id="subForm" class="form-horizontal container">
					<p>
						<shiro:hasPermission name="table:create">
							<button id="btnSave" type="submit" class="btn btn-info no-border">
								<i class="ace-icon fa fa-edit align-top bigger-125"></i>
								${op}
							</button>
							<button id="addChild" type="button" class="btn btn-info no-border">
								<i class="ace-icon fa fa-edit align-top bigger-125"></i>
								增加子表
							</button>
						</shiro:hasPermission>
						<button id="btnBack"class="btn btn-danger no-border" type="button" onclick="javascript:history.go(-1);">
							<i class="ace-icon fa fa-undo align-top bigger-125"></i>
							返回
						</button>
					</p>
			        <form:hidden path="id"/>
					<div class="row table">
						<div class="widget-box">
							<div class="widget-header widget-header-flat widget-header-small">
								<h5 class="widget-title">
									<i class="ace-icon fa fa-signal"></i>
									<span class="tablelabel">${empty table.tableName?'表名':table.tableName}</span>
								</h5>
								<div class="widget-toolbar no-border">
									<label>
										<input name="genFlag" type="checkbox" ${table.genFlag?'checked':''} class="ace ace-switch ace-switch-7" title="是否生成">
										<span class="lbl middle"></span>
									</label>
								</div>
							</div>
							<div class="widget-body">
								<div class="widget-main">
									<div class="form-group col-xs-12 col-sm-6">
							            <form:label path="tableName" cssClass="control-label col-xs-12 col-sm-2 no-padding-right">表名:</form:label>
							            <div class="col-xs-12 col-sm-7">
							            	<span class="block input-icon input-icon-right">
								            	<form:input path="tableName" maxlength="50" cssClass="width-100 required tableName" title="表名必填"/>
												<i class="ace-icon fa fa-info-circle"></i>
											</span>
										</div>
							        </div>
							        <div class="form-group col-xs-12 col-sm-6">
							            <form:label path="tableAlias" cssClass="control-label col-xs-12 col-sm-2 no-padding-right">别名:</form:label>
							            <div class="col-xs-12 col-sm-7">
							            	<span class="block input-icon input-icon-right">
								            	<form:input path="tableAlias" maxlength="50" cssClass="width-100" title="别名"/>
												<i class="ace-icon fa fa-info-circle"></i>
											</span>
										</div>
							        </div>
							        <div class="form-group col-xs-12 col-sm-6">
							            <form:label path="foreignKey" cssClass="control-label col-xs-12 col-sm-2 no-padding-right">外键:</form:label>
							            <div class="col-xs-12 col-sm-7">
							            	<span class="block input-icon input-icon-right">
								            	<form:input path="foreignKey" maxlength="50" cssClass="width-100" title="外键"/>
												<i class="ace-icon fa fa-info-circle"></i>
											</span>
										</div>
							        </div>
							        <div class="form-group col-xs-12 col-sm-6">
							            <form:label path="labelName" cssClass="control-label col-xs-12 col-sm-2 no-padding-right">Label:</form:label>
							            <div class="col-xs-12 col-sm-7">
							            	<span class="block input-icon input-icon-right">
								            	<form:input path="labelName" maxlength="50" cssClass="width-100" title="被关联表显示字段"/>
												<i class="ace-icon fa fa-info-circle"></i>
											</span>
										</div>
							        </div>
							        <div class="form-group col-xs-12 col-sm-6">
							            <form:label path="domainName" cssClass="control-label col-xs-12 col-sm-2 no-padding-right">类名:</form:label>
							            <div class="col-xs-12 col-sm-7">
							            	<span class="block input-icon input-icon-right">
								            	<form:input path="domainName" maxlength="50" cssClass="width-100 required" title="类名必填"/>
												<i class="ace-icon fa fa-info-circle"></i>
											</span>
										</div>
							        </div>
							        <div class="form-group col-xs-12 col-sm-6">
							            <form:label path="bumodel" cssClass="control-label col-xs-12 col-sm-2 no-padding-right">模块:</form:label>
							            <div class="col-xs-12 col-sm-7">
							            	<span class="block input-icon input-icon-right">
								            	<form:input path="bumodel" maxlength="50" cssClass="width-100 required" title="业务模块必填"/>
												<i class="ace-icon fa fa-info-circle"></i>
											</span>
										</div>
							        </div>
							        <div class="form-group col-xs-12 col-sm-6">
							            <form:label path="pkg" cssClass="control-label col-xs-12 col-sm-2 no-padding-right">包名:</form:label>
							            <div class="col-xs-12 col-sm-7">
							            	<span class="block input-icon input-icon-right">
								            	<form:input path="pkg" maxlength="50" cssClass="width-100 required" title="包名必填"/>
												<i class="ace-icon fa fa-info-circle"></i>
											</span>
										</div>
							        </div>
							        <div class="form-group col-xs-12 col-sm-6">
							            <form:label path="pkg" cssClass="control-label col-xs-12 col-sm-2 no-padding-right">风格:</form:label>
							            <div class="col-xs-12 col-sm-7">
							            	<span class="block input-icon input-icon-right">
							            		<form:select path="fgType" itemLabel="name" itemValue="id" items="${elfn:getChildDictById(constants.DICT_FG_PARENT_ID)}" cssClass="select2 width-100 required input-xlarge" title="生成风格"></form:select>
											</span>
										</div>
							        </div>
							        <div class="form-group col-xs-12 col-sm-6">
							            <form:label path="relationType" cssClass="control-label col-xs-12 col-sm-2 no-padding-right">关系:</form:label>
							            <div class="col-xs-12 col-sm-7">
							            	<span class="block input-icon input-icon-right">
							            	<form:select path="relationType" itemLabel="info" itemValue="value" items="${relationTypes}" cssClass="select2 width-100 required input-xlarge" title="生成表关系"></form:select>
											</span>
										</div>
							        </div>
							        <div class="form-group col-xs-12 col-sm-6">
							            <form:label path="comments" cssClass="control-label col-xs-12 col-sm-2 no-padding-right">描述:</form:label>
							            <div class="col-xs-12 col-sm-7">
							            	<span class="block input-icon input-icon-right">
								            	<form:textarea path="comments" cssClass="width-100 input-xlarge"/>
												<i class="ace-icon fa fa-info-circle"></i>
											</span>
										</div>
							        </div>
							        <div class="clearfix"></div>
								</div>
							</div>
						</div>
			        </div>
			        <div class="row">
			        	<div class="hr hr8 hr-double"></div>
			        </div>
			        <div class="relation-content row">
			        </div>
			    </form:form>
				<!-- PAGE CONTENT ENDS -->
			</div><!-- /.col -->
		</div><!-- /.row -->
	</div><!-- /.page-content-area -->
	<!-- index, -->
	<script id="itemtemplate" type="text/html">
		<div class="col-sm-6 childitem">
			<input type="hidden" name="childs[{{index}}].id" value="{{id}}"/>
			<input type="hidden" name="childs[{{index}}].relationType" value="{{relationType}}"/>
			<div class="widget-box">
				<div class="widget-header widget-header-flat widget-header-small">
					<h5 class="widget-title">
						<i class="ace-icon fa fa-signal"></i>
						<span class="tablelabel">{{if tableName}}{{tableName}}{{else}}表名{{/if}}</span>
					</h5>
					<div class="widget-toolbar no-border">
						<label>
							<input type="checkbox" name="childs[{{index}}].genFlag" {{if genFlag}}checked{{/if}} class="ace ace-switch ace-switch-7" title="是否生成">
							<span class="lbl middle"></span>
						</label>
						<a href="javascript:void(0)" class="close-warp" objid="{{id}}">
							<i class="ace-icon fa fa-times bigger-110 red"></i>
						</a>
					</div>
				</div>
				<div class="widget-body">
					<div class="widget-main">
						<div class="form-group col-xs-12 col-sm-6">
							<label path="tableName" class="control-label col-xs-12 col-sm-3">表名:</label>
							<div class="col-xs-12 col-sm-9">
								<span class="block input-icon input-icon-right">
									<input name="childs[{{index}}].tableName" value="{{tableName}}" maxlength="50" class="width-100 required tableName" title="表名必填"/>
									<i class="ace-icon fa fa-info-circle"></i>
								</span>
							</div>
						</div>
						<div class="form-group col-xs-12 col-sm-6">
							<label path="tableAlias" class="control-label col-xs-12 col-sm-3">别名:</label>
							<div class="col-xs-12 col-sm-9">
								<span class="block input-icon input-icon-right">
									<input name="childs[{{index}}].tableAlias" value="{{tableAlias}}" maxlength="50" class="width-100 required" title="别名必填"/>
									<i class="ace-icon fa fa-info-circle"></i>
								</span>
							</div>
						</div>
						<div class="form-group col-xs-12 col-sm-6">
							<label path="domainName" class="control-label col-xs-12 col-sm-3 no-padding-right">类名:</label>
							<div class="col-xs-12 col-sm-9">
								<span class="block input-icon input-icon-right">
									<input name="childs[{{index}}].domainName" value="{{domainName}}" maxlength="50" class="width-100 required" title="类名必填"/>
									<i class="ace-icon fa fa-info-circle"></i>
								</span>
							</div>
						</div>
						<div class="form-group col-xs-12 col-sm-6">
							<label path="bumodel" class="control-label col-xs-12 col-sm-3 no-padding-right">模块:</label>
							<div class="col-xs-12 col-sm-9">
								<span class="block input-icon input-icon-right">
									<input name="childs[{{index}}].bumodel" value="{{bumodel}}" maxlength="50" class="width-100 required" title="业务模块必填"/>
									<i class="ace-icon fa fa-info-circle"></i>
								</span>
							</div>
						</div>
						<div class="form-group col-xs-12 col-sm-6">
							<label path="pkg" class="control-label col-xs-12 col-sm-3 no-padding-right">包名:</label>
							<div class="col-xs-12 col-sm-9">
								<span class="block input-icon input-icon-right">
									<input name="childs[{{index}}].pkg" value="{{pkg}}" maxlength="50" class="width-100 required" title="包名必填"/>
									<i class="ace-icon fa fa-info-circle"></i>
								</span>
							</div>
						</div>
						<div class="form-group col-xs-12 col-sm-6">
							<label path="pkg" class="control-label col-xs-12 col-sm-3 no-padding-right">风格:</label>
							<div class="col-xs-12 col-sm-9">
								<span class="block input-icon input-icon-right">
									<select name="childs[{{index}}].fgType" class="select2 width-100 required input-xlarge">
										<c:forEach items="${elfn:getChildDictById(constants.DICT_FG_PARENT_ID)}" var="dict">
											<option value="${dict.id}" {{if "${dict.id}"==(fgType||"")}}selected="selected"{{/if}}>${dict.name}</option>
										</c:forEach>
									</select>
								</span>
							</div>
						</div>
						<div class="form-group col-xs-12 col-sm-6">
							<label path="comments" class="control-label col-xs-12 col-sm-3 no-padding-right">描述:</label>
							<div class="col-xs-12 col-sm-9">
								<span class="block input-icon input-icon-right">
									<textarea name="childs[{{index}}].comments" rows="" cols="" class="width-100 input-xlarge">{{comments}}</textarea>
									<i class="ace-icon fa fa-info-circle"></i>
								</span>
							</div>
						</div>
						<div class="clearfix"></div>
					</div>
				</div><!-- widget-body ENDS -->
			</div>
		</div>
	</script>
	<script type="text/javascript">
		$(function(){
			//添加表单验证
        	formValidate($("#subForm"), 'help-block inline error', 'div');
			
			$('#addChild').on('click',function(){
				if($('select[name="relationType"]',$('.table')).val()!="<%=Table.RelationType.one%>")
					addChild();
				else
					$.jBox.tip("表关系请设置“一对多”或“一对一”关系！", 'error');
			});
			$(document).on('click','.close-warp',function(){
				var self = $(this);
				platform.showDeleteDialog({
					beforDeleteHandler:function(dialog){
						self.closest('.childitem').remove();
					}
				});
			}).on('change','.tableName',function(){
				$(this).closest('.childitem').find('.tablelabel').text($(this).val());
			});
			//初始化字表数据
			var childTables = eval('${elfn:toJSON(table.childs)}')||[];
			if(childTables.length>0)
				for(var i=0;i<childTables.length;i++)
					addChild(childTables[i]);
		});
		function addChild(data){
			data = $.extend(true,data,{
				index:$('.childitem',$('.relation-content')).size(),
				relationType:'<%=Table.RelationType.more_2_one%>'
			});
			var item = $(template('itemtemplate', data));
			$(".select2",item).prepend('<option value="">--请选择--</option>').select2({allowClear:true});
			$('.relation-content').append(item);
		}
	</script>
</body>
</html>