<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<tags:header inplugins="${plugins.jqui},${plugins.validate},${plugins.select2}" title="列定义"></tags:header>
</head>
<body>
	<c:set var="plugins" value="${elfn:getPluginsList()}"></c:set>
	<div class="page-content-area">
		<div class="page-header">
			<h1>
				自定义表单
				<small>
					<i class="ace-icon fa fa-angle-double-right"></i>
					 修改
				</small>
			</h1>
		</div><!-- /.page-header -->
	
		<div class="row">
			<div class="col-xs-12">
				<form method="post" id="subForm" action="${adminFullPath}/table/editColumns">
				<div class="widget-box">
					<div class="widget-header widget-header-blue widget-header-flat">
						<h4 class="widget-title lighter">表单名称：[“${table.tableName}”]</h4>
					</div>

					<div class="widget-body">
						<div class="widget-main">
							<!-- #section:plugins/fuelux.wizard -->
							<div id="fuelux-wizard" data-target="#step-container">
								<!-- #section:plugins/fuelux.wizard.steps -->
								<ul class="wizard-steps">
									<li data-target="#step1"${table.step==1?' class="active"':' class="complete"'}>
										<span class="step">1</span>
										<span class="title">定义表单</span>
									</li>

									<li data-target="#step1"${table.step==2?' class="active"':(table.step>2?' class="complete"':'')}>
										<span class="step">2</span>
										<span class="title">配置属性</span>
									</li>

									<li data-target="#step1"${table.step==3?' class="complete"':''}>
										<span class="step">3</span>
										<span class="title">生成表单</span>
									</li>
								</ul>

								<!-- /section:plugins/fuelux.wizard.steps -->
							</div>

							<hr />

							<!-- #section:plugins/fuelux.wizard.container -->
							<div class="step-content pos-rel" id="step-container">
								<div class="step-pane active" id="step1">
									<div class="form-group col-xs-12 col-sm-6">
										<label name="tableName" class="control-label col-xs-12 col-sm-2 no-padding-right">表名:</label>
										<div class="col-xs-12 col-sm-7">
							            	<span class="block input-icon input-icon-right">
								            	<input name="tableName" value="${table.tableName}" maxlength="50" class="width-100 required tableName" title="表名必填"/>
												<i class="ace-icon fa fa-info-circle"></i>
											</span>
										</div>
									</div>
									<div class="form-group col-xs-12 col-sm-6">
										<label name="comments" class="control-label col-xs-12 col-sm-2 no-padding-right">描述:</label>
										<div class="col-xs-12 col-sm-7">
							            	<span class="block input-icon input-icon-right">
								            	<textarea name="comments" class="width-100 input-xlarge">${table.comments}</textarea>
												<i class="ace-icon fa fa-info-circle"></i>
											</span>
										</div>
									</div>
								</div>

								<div class="step-pane" id="step2">
									<!-- PAGE CONTENT BEGINS -->
									<input type="hidden" name="id" value="${table.id}">
									<input type="hidden" name="step" value="${table.step}">
									<table class="table table-striped table-bordered table-hover">
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
										<c:forEach items="${columnsList}" var="column" varStatus="stat">
											<tr id="tr-${stat.index}" columnName="${column.columnName}">
												<td>${column.columnName}
													<input type="hidden" name="columnList[${stat.index}].id" value="${column.id}">
													<input type="hidden" name="columnList[${stat.index}].columnName" value="${column.columnName}">
													<input type="hidden" name="columnList[${stat.index}].tableId" value="${table.id}">
													<input type="hidden" name="columnList[${stat.index}].columnType" value="${column.columnType}">
													<input type="hidden" name="columnList[${stat.index}].dataType" value="${column.dataType}">
													<input type="hidden" name="columnList[${stat.index}].columnKey" value="${columnKey}">
												</td>
												<td>${column.dataType}</td>
												<td class="disabled">${column.columnType}</td>
												<td><input name="columnList[${stat.index}].propertiesName" value="${column.propertiesName}" class="width-100" id="dvalue"></td>
												<td>
													<select name="columnList[${stat.index}].propertiesType" class="select2" style="min-width: 110px;">
														<c:forEach items="${elfn:getJavaTypeList()}" var="javaType">
															<option value="${javaType}"<c:if test="${constants.mysqlDataTypeMap[fn:toUpperCase(column.dataType)] eq javaType}">selected="selected"</c:if>>${javaType}</option>
														</c:forEach>
													</select>
												</td>
												<td><input name="columnList[${stat.index}].comments" value="${column.comments}" class="width-100"></td>
												<td>
													<select name="columnList[${stat.index}].plugin" class="select2" style="min-width: 110px;" statindex="${stat.index}" id="plugin${stat.index}">
														<c:forEach items="${plugins}" var="plugin">
															<option title="${plugin.remark}" value="${plugin.id}"<c:if test="${(column.plugin eq plugin.id)}">selected="selected"</c:if>>${plugin.tagName}</option>
														</c:forEach>
													</select>
												</td>
												<td class="center">
													<a class="${fn:length(column.columnElements)<=0?'grey':'green'}" href="#" title="标签元素设置">
														<i class="ace-icon fa fa-plug bigger-125 cursor" setting="plugin${stat.index}" statindex="${stat.index}"></i>
													</a>
												</td>
												<td class="center">
													<a class="${fn:length(column.columnValidates)<=0?'grey':'green'}" href="#" title="验证类型设置">
														<i class="ace-icon fa fa-filter bigger-125 cursor" setting="validate${stat.index}" statindex="${stat.index}"></i>
													</a>
												</td>
												<td class="center">
													<label class="position-relative">
														<input type="checkbox" class="ace" name="columnList[${stat.index}].genFlag" <c:if test="${column.genFlag||empty column.id}">checked="checked"</c:if>>
														<span class="lbl"></span>
													</label>
												</td>
												<td class="center">
													<label class="position-relative">
														<input type="checkbox" class="ace" name="columnList[${stat.index}].hideFlag" <c:if test="${column.hideFlag||(!column.hideFlag&&column.pk)}">checked="checked"</c:if>>
														<span class="lbl"></span>
													</label>
												</td>
												<td class="center">
													<label class="position-relative">
														<input type="checkbox" class="ace" name="columnList[${stat.index}].sortFlag" <c:if test="${column.sortFlag||(empty column.id&&!column.pk)}">checked="checked"</c:if>>
														<span class="lbl"></span>
													</label>
												</td>
												<td class="center"><input type="text" class="width-100" name="columnList[${stat.index}].sequence" value="${column.sequence==0?stat.index*10:column.sequence}"></td>
												<td class="disabled" id="columnTag-${stat.index}">
													<div id="elements"></div>
													<div id="validates"></div>
													<div id="dialog-setting-${stat.index}" class="hide">
														<table class="table table-striped table-bordered table-hover no-margin-bottom no-border-top">
															<thead>
															<tr>
																<th>元素名称</th>
																<th>元素值</th>
																<th>元素举例</th>
															</tr>
															</thead>
															<tbody>
															<c:forEach items="${column.columnElements}" var="columnElement" varStatus="statu">
																<tr>
																	<td>
																		<input type="hidden" name="columnList[${stat.index}].columnElements[${statu.index}].elementId" value="${columnElement.element.id}"/>
																			${columnElement.element.required eq constants.DICT_YES_PARENT_ID?'<font color="red">*</font>':''}${columnElement.element.elementName}
																	</td>
																	<td>
																		<input type="text" name="columnList[${stat.index}].columnElements[${statu.index}].elementValue" value="${empty columnElement.elementValue?columnElement.element.defaultVal:columnElement.elementValue}" mustrequired="${columnElement.element.required}" statindex="${stat.index}" class="width-100">
																	</td>
																	<td>${empty columnElement.element.description?'暂无':columnElement.element.description}</td>
																</tr>
															</c:forEach>
															</tbody>
														</table>
													</div><!-- #elements-dialog-confirm -->
													<div id="dialog-validate-${stat.index}" class="hide">
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
																		<input submit-input="true" type="hidden" value="${validate.id}" name="columnList[${stat.index}].columnValidates[${statu.index}].validateId"/>
																			${validate.name}
																	</td>
																	<td>
																		<input submit-input="true" type="text" name="columnList[${stat.index}].columnValidates[${statu.index}].validateVal" value="${elfn:getObjFromList(column.columnValidates,'validateId',validate.id).validateVal}" placeholder="${validate.value}" class="width-100">
																	</td>
																	<td>
																		<input submit-input="true" type="text" name="columnList[${stat.index}].columnValidates[${statu.index}].validateMessage" value="${elfn:getObjFromList(column.columnValidates,'validateId',validate.id).validateMessage}" class="width-100">
																	</td>
																	<td>${empty validate.means?'暂无':validate.means}</td>
																</tr>
															</c:forEach>
															</tbody>
														</table>
													</div><!-- #validates-dialog-confirm -->
												</td>
											</tr>
										</c:forEach>
										</tbody>
									</table>
									<!-- PAGE CONTENT ENDS -->
								</div>

								<div class="step-pane" id="step3">
									<div class="center">
										<h3 class="blue lighter">This is step 3</h3>
									</div>
								</div>
							</div>

							<!-- /section:plugins/fuelux.wizard.container -->
							<hr />
							<div class="wizard-actions">
								<!-- #section:plugins/fuelux.wizard.buttons -->
								<button class="btn btn-prev">
									<i class="ace-icon fa fa-arrow-left"></i>
									上一步
								</button>

								<button class="btn btn-success btn-next" data-last="Finish">
									下一步
									<i class="ace-icon fa fa-arrow-right icon-on-right"></i>
								</button>

								<!-- /section:plugins/fuelux.wizard.buttons -->
							</div>

							<!-- /section:plugins/fuelux.wizard -->
						</div><!-- /.widget-main -->
					</div><!-- /.widget-body -->
				</div>
				</form>
			</div><!-- /.col -->
		</div><!-- /.row -->
	</div><!-- /.page-content-area -->
	<script type="text/javascript">
		$(function(){
			$('i[setting^="plugin"]').on('click',function(){
				var statindex = $(this).attr('statindex');
				if($.trim($('tbody',$('#dialog-setting-'+statindex)).html())==='')
					loadElements($('#'+$(this).attr('setting')).val(),statindex);
				showSettingElementDialog(statindex);
			});
			$('[id^=plugin]').on('change',function(){
				var statindex = $(this).attr('statindex');
				loadElements($(this).val(),statindex);
				showSettingElementDialog(statindex);
			});
			
			$('i[setting^="validate"]').on('click',function(){
				var statindex = $(this).attr('statindex');
				platform.showContentDialog({
					title:'"'+$('#tr-'+statindex).attr('columnName')+'"验证设置',
					content:'#dialog-validate-'+statindex,
					selectedHandler:function(dialog){
						$('#validates',$('#columnTag-'+statindex)).html($('input[submit-input]',dialog).clone());
						$('[setting="validate'+statindex+'"]').closest('a').attr('class','green');
					},
					cancleHandler:function(dialog){
						$('[setting="validate'+statindex+'"]').closest('a').attr('class','grey');
					},
					option:{
						width:400
					}
				});
			});
			$("#subForm").submit(function(){
				var flag = true;
				$('input[mustrequired="${constants.DICT_YES_PARENT_ID}"]').each(function(){
					if(""===$(this).val()){
						flag=false;
						showSettingElementDialog($(this).attr('statindex'));
						return flag;
					}
				});
				return flag;
			});
			$('#isdefault').on('click', function(){
				var self = $(this);
				if(this.checked) {
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
				}
			})
		});
		function showSettingElementDialog(statindex){
			platform.showContentDialog({
				title:'"'+$('#tr-'+statindex).attr('columnName')+'"标签元素设置',
				content:'#dialog-setting-'+statindex,
				option:{width:"500"},
				selectedHandler:function(dialog){
					$('#elements',$('#columnTag-'+statindex)).html($('input',dialog).clone());
					$('[setting="plugin'+statindex+'"]').closest('a').attr('class','green');
				},
				cancleHandler:function(dialog){
					$('[setting="plugin'+statindex+'"]').closest('a').attr('class','grey');
				}
			});
		}
		function loadElements(tagId,statindex){
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
			   }
			});
		}
	</script>
</body>
</html>