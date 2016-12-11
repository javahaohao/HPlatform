<%@ page import="com.hplatform.core.entity.Table" %>
<%@ page import="com.hplatform.core.constants.ColumnsConstants" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<tags:header inplugins="${plugins.jqui},${plugins.validate},${plugins.select2},${plugins.template},${plugins.jbox}" title="列定义"></tags:header>
</head>
<body>
	<c:set var="plugins" value="${elfn:getPluginsList()}"></c:set>
	<div class="page-content-area">
		<div class="page-header">
			<h1>
				列定义
				<small>
					<i class="ace-icon fa fa-angle-double-right"></i>
					 修改
				</small>
			</h1>
		</div><!-- /.page-header -->
	
		<div class="row">
			<div class="col-xs-12">
				<div class="widget-box">
					<div class="widget-header widget-header-flat widget-header-small">
						<h5 class="widget-title">
							<i class="ace-icon fa fa-signal"></i>
							表单名称：[“<span id="tabletext">${empty table.tableName?'表单名称':table.tableName}</span>”]
						</h5>
						<div class="widget-toolbar">
							<label>
								<small class="green">
									<b>恢复默认</b>
								</small>

								<input id="isdefault" type="checkbox" ${table.step==1?'checked':''} class="ace ace-switch ace-switch-7" />
								<span class="lbl middle"></span>
							</label>
						</div>
					</div>

					<div class="widget-body">
						<div class="widget-main">
							<!-- #section:plugins/fuelux.wizard -->
							<div id="fuelux-wizard" data-target="#step-container">
								<!-- #section:plugins/fuelux.wizard.steps -->
								<ul class="wizard-steps">
									<li data-target="#step1">
										<span class="step">1</span>
										<span class="title">定义方案</span>
									</li>

									<li data-target="#step2">
										<span class="step">2</span>
										<span class="title">配置细则</span>
									</li>

									<li data-target="#step3">
										<span class="step">3</span>
										<span class="title">代码生成</span>
									</li>
								</ul>

								<!-- /section:plugins/fuelux.wizard.steps -->
							</div>

							<hr />

							<!-- #section:plugins/fuelux.wizard.container -->
							<div class="step-content pos-rel" id="step-container">
								<div class="step-pane" id="step1">
									<form:form method="post" commandName="table" id="tabForm" class="form-horizontal container">
										<p>
											<shiro:hasPermission name="table:create">
												<button id="addChild" type="button" class="btn btn-info no-border btn-sm">
													<i class="ace-icon fa fa-edit align-top bigger-125"></i>
													增加子表
												</button>
											</shiro:hasPermission>
										</p>
										<div class="row table maintable">
											<form:hidden path="id"/>
											<form:hidden path="step"/>
											<div class="form-group col-xs-12 col-sm-6">
												<form:label path="tableName" cssClass="control-label col-xs-12 col-sm-2 no-padding-right">表名:</form:label>
												<div class="col-xs-12 col-sm-7">
													<span class="block input-icon input-icon-right">
														<form:select path="tableName" items="${gentables}" disabled="${not empty table.id}" itemLabel="tableName" itemValue="tableName" title="表名必选" cssClass="select2 width-100 required input-xlarge tableName"></form:select>
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
														<select name="relationType" class="select2 width-100 required input-xlarge" title="表关系必填">
															<c:forEach items="${relationTypes}" var="type">
																<c:if test="${type.show}">
																	<option value="${type.value}" <c:if test="${type.value eq table.relationType}">selected="selected"</c:if>>${type.info}</option>
																</c:if>
															</c:forEach>
														</select>
													</span>
												</div>
											</div>
											<div class="form-group col-xs-12 col-sm-6">
												<form:label path="genFlag" cssClass="control-label col-xs-12 col-sm-2 no-padding-right">是否生成:</form:label>
												<div class="col-xs-12 col-sm-7">
													<span class="block input-icon input-icon-right">
														<label>
															<input name="genFlag" type="checkbox" ${table.genFlag?'checked':''} class="ace ace-switch ace-switch-7" title="是否生成">
															<span class="lbl middle"></span>
														</label>
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
										<div class="row">
											<div class="hr hr8 hr-double"></div>
										</div>
										<div class="relation-content row">
										</div>
									</form:form>
								</div>

								<div class="step-pane" id="step2">
									<form id="columnform">
									<table class="table table-striped table-bordered table-hover" id="proptable">
										<thead>
										<tr>
											<th>列名称</th>
											<th>数据类型</th>
											<th class="disabled">列类型</th>
											<th>属性名称</th>
											<th>属性类型</th>
											<th>备注</th>
											<th>控件类型</th>
											<th>控件设置</th>
											<th>验证设置</th>
											<th>是否生成</th>
											<th>是否隐藏</th>
											<th>是否排序</th>
											<th>排序</th>
										</tr>
										</thead>
										<tbody>
										</tbody>
									</table>
									</form>
								</div>

								<div class="step-pane ${table.step==3?'active':''}" id="step3">
									<div class="center">
										<h3 class="blue lighter">代码生成成功！</h3>
									</div>
								</div>
							</div>

							<!-- /section:plugins/fuelux.wizard.container -->
							<hr />
							<div class="wizard-actions">
								<!-- #section:plugins/fuelux.wizard.buttons -->
								<button class="btn btn-prev btn-sm" type="button">
									<i class="ace-icon fa fa-arrow-left"></i>
									上一步
								</button>
								<button class="btn btn-success btn-next btn-sm" data-last="完成" type="button" id="nextbtn">
									下一步
									<i class="ace-icon fa fa-arrow-right icon-on-right"></i>
								</button>
								<button id="btnBack"class="btn btn-danger no-border btn-sm" type="button" onclick="javascript:window.location.href='${adminFullPath}/table'">
									<i class="ace-icon fa fa-undo align-top bigger-125"></i>
									返回
								</button>
								<!-- /section:plugins/fuelux.wizard.buttons -->
							</div>

							<!-- /section:plugins/fuelux.wizard -->
						</div><!-- /.widget-main -->
					</div><!-- /.widget-body -->
				</div>
			</div><!-- /.col -->
		</div><!-- /.row -->
	</div><!-- /.page-content-area -->
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
									<select name="childs[{{index}}].tableName" title="表名必选" class="select2 width-100 required input-xlarge tableName">
										<c:forEach items="${gentables}" var="t">
											<option value="${t.tableName}" {{if tableName=='${t.tableName}'}}selected="selected"{{/if}}>${t.tableName}</option>
										</c:forEach>
									</select>
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
	<script id="trtemplate" type="text/html">
		<tr id="tr-{{index}}" columnName="{{column.columnName}}">
			<td>{{column.columnName}}
				<input type="hidden" name="columnList[{{index}}].id" value="{{column.id}}">
				<input type="hidden" name="columnList[{{index}}].columnName" value="{{column.columnName}}">
				<input type="hidden" name="columnList[{{index}}].tableId" value="${table.id}">
				<input type="hidden" name="columnList[{{index}}].columnType" value="{{column.columnType}}">
				<input type="hidden" name="columnList[{{index}}].columnLength" value="{{column.columnLength}}">
				<input type="hidden" name="columnList[{{index}}].dataType" value="{{column.dataType}}">
				<input type="hidden" name="columnList[{{index}}].nullAble" value="{{column.nullAble}}">
				<input type="hidden" name="columnList[{{index}}].columnKey" value="{{columnKey}}">
			</td>
			<td>{{column.dataType}}</td>
			<td class="disabled">{{column.columnType}}</td>
			<td><input name="columnList[{{index}}].propertiesName" value="{{column.propertiesName}}" class="width-100" id="dvalue"></td>
			<td>
				<select name="columnList[{{index}}].propertiesType" class="select2" style="min-width: 110px;">
					<c:forEach items="${elfn:getJavaTypeList()}" var="javaType">
						<option value="${javaType}"{{if getJavaType(column.dataType)=='${javaType}'}}selected="selected"{{/if}}>${javaType}</option>
					</c:forEach>
				</select>
			</td>
			<td><input name="columnList[{{index}}].comments" value="{{column.comments}}" class="width-100"></td>
			<td>
				{{if isdefault}}
					<input type="hidden" value="{{genColumnVo.pluginId}}" name="columnList[{{index}}].plugin">
				{{/if}}
				<select name="columnList[{{index}}].plugin" class="select2" {{if isdefault}}disabled="disabled"{{/if}} style="min-width: 110px;" statindex="{{index}}" id="plugin{{index}}" pluginid="{{column.plugin}}">
					<c:forEach items="${plugins}" var="plugin">
						<option title="${plugin.remark}" value="${plugin.id}"{{if (column.plugin=='${plugin.id}')||(isdefault&&('${plugin.id}'==genColumnVo.pluginId))}} selected="selected"{{/if}}>${plugin.tagName}</option>
					</c:forEach>
				</select>
			</td>
			<td class="center">
				<a class="{{if length(column.columnElements)<=0}}grey{{else if length(column.columnElements)>0}}green{{else}}{{/if}}" href="javascript:void(0)" title="标签元素设置">
					<i class="ace-icon fa fa-plug bigger-125 cursor" {{if !!!isdefault}}setting="plugin{{index}}"{{/if}} statindex="{{index}}"></i>
				</a>
			</td>
			<td class="center">
				<a class="{{if length(column.columnValidates)<=0}}grey{{else if length(column.columnValidates)>0}}green{{else}}{{/if}}" href="javascript:void(0)" title="验证类型设置">
					<i class="ace-icon fa fa-filter bigger-125 cursor" setting="validate{{index}}" statindex="{{index}}"></i>
				</a>
			</td>
			<td class="center">
				<label class="position-relative">
					<input type="checkbox" class="ace" name="columnList[{{index}}].genFlag" {{if column.genFlag||!!!column.id}}checked="checked"{{/if}}>
					<span class="lbl"></span>
				</label>
			</td>
			<td class="center">
				<label class="position-relative">
					<input type="checkbox" class="ace" name="columnList[{{index}}].hideFlag" {{if column.hideFlag||(!column.hideFlag&&column.pk)}}checked="checked"{{/if}}>
					<span class="lbl"></span>
				</label>
			</td>
			<td class="center">
				<label class="position-relative">
					<input type="checkbox" class="ace" name="columnList[{{index}}].sortFlag" {{if column.sortFlag||(!!!column.id&&!column.pk)}}checked="checked"{{/if}}>
					<span class="lbl"></span>
				</label>
			</td>
			<td class="center"><input type="text" class="width-100" name="columnList[{{index}}].sequence" value="{{(!!!column.sequence||column.sequence==0)?index*10:column.sequence}}"></td>
			<td class="disabled" id="columnTag-{{index}}">
				<div id="elements"></div>
				<div id="validates"></div>
				<div id="dialog-setting-{{index}}" class="hide">
					<table class="table table-striped table-bordered table-hover no-margin-bottom no-border-top">
						<thead>
						<tr>
							<th>元素名称</th>
							<th>元素值</th>
							<th>元素举例</th>
						</tr>
						</thead>
						<tbody>
						<%--展示默认列的属性值--%>
						{{if isdefault&&!!!column.columnElements}}
							{{each genColumnVo.elementList as element i}}
							<c:forEach items="${genColumnVo.elementList}" var="element" varStatus="statu">
								<tr>
									<td>
										<input type="hidden" name="columnList[{{index}}].columnElements[{{i}}].elementId" value="{{element.id}}"/>
											{{element.required=='constants.DICT_YES_PARENT_ID'?'<font color="red">*</font>':''}{{element.elementName}}
									</td>
									<td>
										<input type="text" name="columnList[{{index}}].columnElements[{{i}}].elementValue" value="{{element.defaultVal}}" mustrequired="{{element.required}}" statindex="{{index}}" class="width-100">
									</td>
									<td>{{!!!element.description?'暂无':element.description}}</td>
								</tr>
							</c:forEach>
							{{/each}}
						{{/if}}
						{{each column.columnElements as value i}}
						<tr>
							<td>
								<input type="hidden" name="columnList[{{index}}].columnElements[{{i}}].elementId" value="{{value.element.id}}"/>
								{{if value.element.required == '${constants.DICT_YES_PARENT_ID}'}}<font color="red">*</font>{{/if}}{{value.element.elementName}}
							</td>
							<td>
								<input type="text" name="columnList[{{index}}].columnElements[{{i}}].elementValue" value="{{if !!value.elementValue}}{{value.elementValue}}{{else if !!!value.elementValue}}{{value.element.defaultVal}}{{else}}{{/if}}" mustrequired="{{value.element.required}}" statindex="{{index}}" class="width-100">
							</td>
							<td>{{!!!value.element.description?'暂无':value.element.description}}</td>
						</tr>
						{{/each}}
						</tbody>
					</table>
				</div><!-- #elements-dialog-confirm -->
				<div id="dialog-validate-{{index}}" class="hide">
					<table class="table table-striped table-bordered table-hover no-margin-bottom no-border-top">
						<thead>
						<tr>
							<th>验证类型</th>
							<th>类型值</th>
							<th>验证信息</th>
							<th>验证举例</th>
						</tr>
						</thead>
						<tbody>
						<c:forEach items="${validateList}" var="validate" varStatus="statu">
							<tr>
								<td>
									<input submit-input="true" type="hidden" value="${validate.id}" name="columnList[{{index}}].columnValidates[${statu.index}].validateId"/>
										${validate.name}
								</td>
								<td>
									<input submit-input="true" type="text" name="columnList[{{index}}].columnValidates[${statu.index}].validateVal" value="{{getValidate(column.columnValidates,'${validate.id}','validateVal')}}" placeholder="${validate.value}" class="width-100">
								</td>
								<td>
									<input submit-input="true" type="text" name="columnList[{{index}}].columnValidates[${statu.index}].validateMessage" value="{{getValidate(column.columnValidates,'${validate.id}','validateMessage')}}" class="width-100">
								</td>
								<td>${empty validate.means?'暂无':validate.means}</td>
							</tr>
						</c:forEach>
						</tbody>
					</table>
				</div><!-- #validates-dialog-confirm -->
			</td>
		</tr>
	</script>
	<script type="text/javascript">
		template.helper('getJavaType', function (prop) {
			var typeMaps = eval((${elfn:toJSON(constants.mysqlDataTypeMap)}))||[];
			return typeMaps[prop.toLocaleUpperCase()];
		});
		template.helper('getValidate', function (param,id,prop) {
			if(!!param)
				for(var i=0;i<param.length;i++)
					if(param[i].validateId==id)
						return param[i][prop];
		});
		$(function(){
			//添加表单验证
			formValidate($("#tabForm"), 'help-block inline error', 'div');
			formValidate($("#columnform"), 'help-block inline error', 'div');

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
			$('[name="relationType"]').on('click',function(){
				$('.relation-content').html('');
			});
			//---------------------------------------------------//
			$(document).on('click','i[setting^="plugin"]',function(){
				var statindex = $(this).attr('statindex');
				loadElements($('#'+$(this).attr('setting')).val(),statindex,function(){
					showSettingElementDialog(statindex);
				});
			});
			$(document).on('change','[id^=plugin]',function(){
				var statindex = $(this).attr('statindex'),self=$(this);
				$('tbody',$('#dialog-setting-'+statindex)).html('');
				loadElements($(this).val(),statindex,function(){
					showSettingElementDialog(statindex,function(){
						self.val(self.attr('pluginid'));
					});
				});
			});
			
			$(document).on('click','i[setting^="validate"]',function(){
				var statindex = $(this).attr('statindex');
				platform.showContentDialog({
					title:'"'+$('#tr-'+statindex).attr('columnName')+'"验证设置',
					content:'#dialog-validate-'+statindex,
					selectedHandler:function(dialog){
						$('#validates',$('#columnTag-'+statindex)).html($('input[submit-input]',dialog).clone());
						$('[setting="validate'+statindex+'"]').closest('a').attr('class','green');
					},
					cancleHandler:function(dialog){
						$('#validates',$('#columnTag-'+statindex)).html('');
						$('[setting="validate'+statindex+'"]').closest('a').attr('class','grey');
					},
					option:{
						width:400,
						open:function(event, ui){
							$('#validates',$('#columnTag-'+statindex)).html($('input[submit-input]',$(this)).clone());
						}
					}
				});
			});
			$('#isdefault').on('click', function(){
				var self = $(this);
				if(this.checked&&!!'${table.id}') {
					platform.showContentDialog({
						title: '确认？',
						content: $('<div>重置“${table.tableName}”方案生成规则？</div>'),
						option: {width: "300"},
						selectedHandler: function (dialog) {
							self.attr('checked', true);
							window.location.href='${adminFullPath}/table/${table.id}/reset'
						},
						cancleHandler: function (dialog) {
						}
					});
					return false;
				}else
					return false;
			});

			$('#fuelux-wizard')
			.ace_wizard({
				step: 1 //optional argument. wizard will jump to step "2" at first
			})
			.on('change' , function(e, info){
				if(info.step == 1) {
					if(!$('#tabForm').valid()) return false;
					init();
				}
				if(info.step == 2) {
					var stepvalidate=true;
					if(!$('#tabForm').valid()) stepvalidate=false;
					$('input[mustrequired="${constants.DICT_YES_PARENT_ID}"]').each(function(){
						if(""===$(this).val()){
							showSettingElementDialog($(this).attr('statindex'));
							stepvalidate=false;
							return false;
						}
					});
					if(!stepvalidate)
						return false;
				}
				if(info.step == 1||info.step == 3){
					init();
				}
			})
			.on('finished', function(e) {
				sub("${adminFullPath}/table/editColumns",function(data){
					window.location='${adminFullPath}/table'
				});
			}).on('stepclick', function(e){
			//e.preventDefault();//this will prevent clicking and selecting steps
			});
		});
		function sub(url,fun){
			if(!$('#tabForm').valid()||!$('#columnform').valid())return false;
			var flag = true;
			$('input[mustrequired="${constants.DICT_YES_PARENT_ID}"]').each(function(){
				if(""===$(this).val()){
					flag=false;
					showSettingElementDialog($(this).attr('statindex'));
					return flag;
				}
			});
			if(flag)
				$.ajax({
					type: "POST",
					url: url,
					data: $("#tabForm").serialize()+'&'+$("#columnform").serialize(),
					success: function(data){
						if(!!fun)fun.call(this,data);
					}
				});
		}
		//初始化数据
		function init(){
			if($('#proptable > tbody tr').size()>0)
				return false;
			var data;
			if(!!'${table.id}')
				data='tableId='+$('.maintable #id').val();
			else
				data='tableName='+$('.maintable #tableName').val();
			$.ajax({
				async:false,
				type: "POST",
				url: "${adminFullPath}/table/columns",
				data: data,
				success: function(columns){
					columns = columns||[];
					var htmlArray=[],columnKey,genColumnVo;
					for(var i=0;i<columns.length;i++) {
						//如果字段key类型为空并且遍历字段还是父表外键，则认为是外键类型
						if(!!!columns[i].columnKey&&!!eval(('${table.parent}'||{}))&&('${table.parent.foreignKey}'==columns[i].columnName))
							columnKey='<%=ColumnsConstants.COLUMN_KEYS_FK%>';
						else
							columnKey=columns[i].columnKey;
						genColumnVo=eval((${elfn:toJSON(defaultColumTagMap)})[columnKey])
						htmlArray.push(template('trtemplate', {
							column: columns[i],
							index: i,
							columnKey:columnKey,
							genColumnVo:genColumnVo,
							isdefault:!!genColumnVo
						}));
					}
					//初始化属性定义
					$('#proptable > tbody').html(htmlArray.join(''));
				}
			});
		}
		function addChild(data){
			var relationType;
			if($('[name="relationType"]').val()=='<%=Table.RelationType.one_2_more%>')
				relationType='<%=Table.RelationType.more_2_one%>';
			else if($('[name="relationType"]').val()=='<%=Table.RelationType.one_2_one%>')
				relationType='<%=Table.RelationType.one_2_one%>';
			data = $.extend(true,data,{
				index:$('.childitem',$('.relation-content')).size(),
				relationType:relationType
			});
			var item = $(template('itemtemplate', data));
			$(".select2",item).prepend('<option value="">--请选择--</option>').select2({allowClear:true});
			$('.relation-content').append(item);
		}
		function showSettingElementDialog(statindex,canclefun){
			platform.showContentDialog({
				title:'"'+$('#tr-'+statindex).attr('columnName')+'"标签元素设置',
				content:'#dialog-setting-'+statindex,
				option:{
					width:"500",
					open:function(event, ui){
						$('#elements',$('#columnTag-'+statindex)).html($('input',$(this)).clone());
					}
				},
				selectedHandler:function(dialog){
					$('#elements',$('#columnTag-'+statindex)).html($('input',dialog).clone());
					$('[setting="plugin'+statindex+'"]').closest('a').attr('class','green');
				},
				cancleHandler:function(dialog){
					$('#elements',$('#columnTag-'+statindex)).html('');
					$('[setting="plugin'+statindex+'"]').closest('a').attr('class','grey');
					if(!!canclefun)canclefun.call(this);
				}
			});
		}
		function loadElements(tagId,statindex,fun){
			if($.trim($('tbody',$('#dialog-setting-'+statindex)).html())==='')
				$.ajax({
					async:false,
				   type: "POST",
				   url: "${adminFullPath}/tags/loadElements",
				   data: 'tagId='+tagId,
				   success: function(data){
					   var tbody = $('tbody',$('#dialog-setting-'+statindex));
					   tbody.html('');
					   for(var index in data){
							if(!isNaN(index)){
							   tbody.append('<tr><td><input type="hidden" name="columnList['+statindex+'].columnElements['+index+'].elementId" value="'+data[index].id+'">'+(data[index].required==='${constants.DICT_YES_PARENT_ID}'?'<font color="red">*</font>':'')+data[index].elementName+
									   '</td><td><input type="text" value="'+((data[index].defaultVal||''))+'" name="columnList['+statindex+'].columnElements['+index+'].elementValue" mustrequired="'+data[index].required+'" statindex="'+statindex+'" class="width-100"></td><td>'+(data[index].description||'暂无')+'</td></tr>');
							   $('#elements',$('#columnTag-'+statindex)).html($('input',tbody).clone());
							}
					   }
				   },
				});
			if(!!fun)fun.call(this);
		}
	</script>
</body>
</html>