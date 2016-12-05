<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<tags:header inplugins="${plugins.jqui},${plugins.validate},${plugins.select2},${plugins.template}" title="列定义"></tags:header>
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
				<div class="widget-box">
					<div class="widget-header widget-header-blue widget-header-flat">
						<h4 class="widget-title lighter">表单名称：[“<span id="tabletext">${empty table.tableName?'表单名称':table.tableName}</span>”]</h4>
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

									<li data-target="#step2"${table.step==2?' class="active"':(table.step>2?' class="complete"':'')}>
										<span class="step">2</span>
										<span class="title">配置属性</span>
									</li>

									<li data-target="#step3"${table.step==3?' class="complete"':''}>
										<span class="step">3</span>
										<span class="title">生成表单</span>
									</li>
								</ul>

								<!-- /section:plugins/fuelux.wizard.steps -->
							</div>

							<hr />

							<!-- #section:plugins/fuelux.wizard.container -->
							<div class="step-content pos-rel" id="step-container">
								<div class="step-pane ${table.step==1?'active':''}" id="step1">
									<form:form method="post" commandName="table" id="tabForm" action="" cssClass="form-horizontal">
										<input type="hidden" name="id" value="${table.id}">
										<input type="hidden" name="step" value="${table.step}">
										<div class="form-group">
											<form:label path="pkg" cssClass="control-label col-xs-12 col-sm-2 no-padding-right">风格:</form:label>
											<div class="col-xs-12 col-sm-7">
							            	<span class="block input-icon input-icon-right">
							            		<form:select path="fgType" itemLabel="name" itemValue="id" items="${elfn:getChildDictById(constants.DICT_FG_PARENT_ID)}" cssClass="select2 width-100 required input-xlarge" title="生成风格"></form:select>
											</span>
											</div>
										</div>
										<div class="form-group">
											<label name="comments" class="control-label col-xs-12 col-sm-2 no-padding-right">描述:</label>
											<div class="col-xs-12 col-sm-7">
												<span class="block input-icon input-icon-right">
                                                    <input name="comments" value="${table.comments}" class="width-100 required tablecomments" title="表单描述必填">
													<i class="ace-icon fa fa-info-circle"></i>
												</span>
											</div>
										</div>
									</form:form>
								</div>

								<div class="step-pane ${table.step==2?'active':''}" id="step2">
									<form method="post" id="subForm" action="">
									<p>
										<shiro:hasPermission name="table:create">
											<button id="addprop" class="btn btn-info no-border btn-sm" type="button">
												<i class="ace-icon fa fa-pencil align-top bigger-125"></i>
												增加属性
											</button>
										</shiro:hasPermission>
									</p>
									<!-- PAGE CONTENT BEGINS -->
									<table class="table table-striped table-bordered table-hover" id="proptable">
										<thead>
										<tr>
											<th>名称</th>
											<th>数据类型</th>
											<th>长度</th>
											<th>可否为空</th>
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
									<!-- PAGE CONTENT ENDS -->
									</form>
								</div>

								<div class="step-pane ${table.step==3?'active':''}" id="step3">
									<div class="center">
										<h3 class="blue lighter">This is step 3</h3>
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
								<button class="btn btn-success btn-next btn-sm  ${table.step==2?'hide':''}" data-last="完成" type="button" id="nextbtn">
									下一步
									<i class="ace-icon fa fa-arrow-right icon-on-right"></i>
								</button>
                                <button class="btn btn-success btn-next btn-sm ${table.step!=2?'hide':''}" type="button" id="savebtn">
                                    保存
                                    <i class="ace-icon fa fa-arrow-right icon-on-right"></i>
                                </button>
                                <button class="btn btn-success btn-next btn-sm  ${table.step!=2?'hide':''}" type="button" id="saveandgenbtn">
                                    保存并生成
                                    <i class="ace-icon fa fa-arrow-right icon-on-right"></i>
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
	<script id="trhtml" type="text/html">
		{{length(column.columnValidates)}}
		<tr id="tr-{{index}}" columnName="{{column.columnName||'属性'}}" class="proptr">
			<td><input name="columnList[{{index}}].comments" value="{{column.comments}}" class="width-100 required comments">
				<input type="hidden" name="columnList[{{index}}].id" value="{{column.id}}">
			</td>
			<td>
				<select name="columnList[{{index}}].dataType" class="select2" style="min-width: 110px;">
					<c:forEach items="${elfn:getJdbcTypeList()}" var="jdbcType">
						<option value="${jdbcType}"{{if column.dataType=='${jdbcType}'}}selected="selected"{{/if}}>${jdbcType}</option>
					</c:forEach>
				</select>
			</td>
			<td><input name="columnList[{{index}}].columnLength" value="{{column.columnLength}}" class="required"></td>
			<td>
                <select name="columnList[{{index}}].nullAble" class="select2">
                    <option value="YES" {{if column.nullAble=='${constants.YES}'}} checked="checked"{{/if}}>是</option>
                    <option value="NO" {{if column.nullAble=='${constants.NO}'}} checked="checked"{{/if}}>否</option>
                </select>
			</td>
			<td>
				<select name="columnList[{{index}}].plugin" class="select2" style="min-width: 110px;" statindex="{{index}}" id="plugin{{index}}">
					<c:forEach items="${plugins}" var="plugin">
						<option title="${plugin.remark}" value="${plugin.id}"{{if column.plugin=='${plugin.id}'}}selected="selected"{{/if}}>${plugin.tagName}</option>
					</c:forEach>
				</select>
			</td>
			<td class="center">
				<a class="{{if length(column.columnElements)<=0}}grey{{else if length(column.columnElements)>0}}green{{else}}{{/if}}" href="#" title="标签元素设置">
					<i class="ace-icon fa fa-plug bigger-125 cursor" setting="plugin{{index}}" statindex="{{index}}"></i>
				</a>
			</td>
			<td class="center">
				<a class="{{if length(column.columnValidates)<=0}}grey{{else if length(column.columnValidates)>0}}green{{else}}{{/if}}" href="#" title="验证类型设置">
					<i class="ace-icon fa fa-filter bigger-125 cursor" setting="validate{{index}}" statindex="{{index}}"></i>
				</a>
			</td>
			<td class="center">
				<label class="position-relative">
					<input type="checkbox" class="ace" name="columnList[{{index}}].genFlag" {{if column.genFlag||!!!column.id}}checked="checked"{{/if}}/>
					<span class="lbl"></span>
				</label>
			</td>
			<td class="center">
				<label class="position-relative">
					<input type="checkbox" class="ace" name="columnList[{{index}}].hideFlag" {{if column.hideFlag||(!column.hideFlag&&column.pk)}}checked="checked"{{/if}}/>
					<span class="lbl"></span>
				</label>
			</td>
			<td class="center">
				<label class="position-relative">
					<input type="checkbox" class="ace" name="columnList[{{index}}].sortFlag" {{if column.sortFlag||(!!!column.id&&!column.pk)}}checked="checked"{{/if}}/>
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
						{{if !!!column.columnElements}}
						<c:set var="genColumnVo" value="${elfn:defaultTag(input)}"></c:set>
						<c:forEach items="${genColumnVo.elementList}" var="element" varStatus="statu">
							<tr>
								<td>
									<input type="hidden" name="columnList[{{index}}].columnElements[${statu.index}].elementId" value="${element.id}"/>
										${element.required eq constants.DICT_YES_PARENT_ID?'<font color="red">*</font>':''}${element.elementName}
								</td>
								<td>
									<input type="text" name="columnList[{{index}}].columnElements[${statu.index}].elementValue" value="${element.defaultVal}" mustrequired="${element.required}" statindex="{{index}}" class="width-100">
								</td>
								<td>${empty element.description?'暂无':element.description}</td>
							</tr>
						</c:forEach>
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
								<td>{{if !!value.element.description}}{{value.element.description}}{{else if !!!value.element.description}}暂无{{else}}{{/if}}</td>
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
		template.helper('getValidate', function (param,id,prop) {
			if(!!param)
				for(var i=0;i<param.length;i++)
					if(param[i].validateId==id)
						return param[i][prop];
		});
		$(function(){
			//添加表单验证
			formValidate($("#tabForm"), 'help-block inline error', 'div');
			formValidate($("#subForm"), 'help-block inline error', 'div');

			$(document).on('click','i[setting^="plugin"]',function(){
				var statindex = $(this).attr('statindex');
				if($.trim($('tbody',$('#dialog-setting-'+statindex)).html())==='')
					loadElements($('#'+$(this).attr('setting')).val(),statindex);
				showSettingElementDialog(statindex);
			});
			$(document).on('change','[id^=plugin]',function(){
				var statindex = $(this).attr('statindex');
				loadElements($(this).val(),statindex);
				showSettingElementDialog(statindex);
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
						$('[setting="validate'+statindex+'"]').closest('a').attr('class','grey');
					},
					option:{
						width:400
					}
				});
			});
            $('#savebtn').on('click',function(){
                sub("${adminFullPath}/table/form/create",function(){
                    window.location='${adminFullPath}/table/form'
                });
            });
            $('#saveandgenbtn').on('click',function(){
                var wizard = $('#fuelux-wizard').data('wizard');
                //move to step 3
                wizard.currentStep = 3;
                wizard.setState();
                $('#savebtn,#saveandgenbtn').hide();
                $('#nextbtn').show();
                sub("${adminFullPath}/table/form/creategen",function(){
                    alert('生成成功');
                });

            });
            $('#fuelux-wizard')
			.ace_wizard({
				step: '${table.step}'||1 //optional argument. wizard will jump to step "2" at first
			})
			.on('change' , function(e, info){
				if(info.step == 1) {
					if(!$('#tabForm').valid()) return false;
				}
				if(info.step == 2) {
					if(!$('#subForm').valid()) return false;
					$('input[mustrequired="${constants.DICT_YES_PARENT_ID}"]').each(function(){
						if(""===$(this).val()){
							showSettingElementDialog($(this).attr('statindex'));
							return false;
						}
					});
				}

                $('#savebtn,#saveandgenbtn').hide();
                $('#nextbtn').removeClass('hide').show();
                if(info.step == 1||info.step == 3){
                    $('#nextbtn').hide();
                    $('#savebtn,#saveandgenbtn').removeClass('hide').show();
                }
			})
			.on('finished', function(e) {

			}).on('stepclick', function(e){
				//e.preventDefault();//this will prevent clicking and selecting steps
			});

			//增加一个新属性
			$('#addprop').on('click',function(){
				$('#proptable > tbody').append(template('trhtml', {column:{},index:$('tr.proptr',$('#proptable')).size()}));
			});

			//绑定输入框改变事件
            $(document).on('input propertychange','.tablecomments',function(){
                $('#tabletext').text($(this).val());
            });
			$(document).on('input propertychange','.comments',function(){
				$(this).closest('tr').attr('columnName',$(this).val());
			});
			init();
		});
        function sub(url,fun){
            if($('#tabForm').valid()&&$('#subForm').valid())
                $.ajax({
                    type: "POST",
                    url: url,
                    data: $("#tabForm").serialize()+'&'+$("#subForm").serialize(),
                    success: function(data){
                        if(!!fun)fun.call(this,this);
                    }
                });
        }
		function init(){
			var columns = eval((${elfn:toJSON(columnsList)}))||[],htmlArray=[];
			for(var i=0;i<columns.length;i++)
				htmlArray.push(template('trhtml', {column:columns[i],index:i}));
			//初始化属性定义
			$('#proptable > tbody').html(htmlArray.join(''));
		}
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