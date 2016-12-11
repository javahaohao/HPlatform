<%@ page import="com.hplatform.core.constants.TableConstants" %>
<%@ page import="com.hplatform.core.entity.Table" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<tags:header inplugins="${plugins.jqui},${plugins.dataTables},${plugins.jbox}" title="代码生成"></tags:header>
	<style type="text/css">
		.progress{
			margin-bottom: 0px;
		}
	</style>
</head>
<body>
	<div class="page-content-area">
		<div class="page-header">
			<h1>
				组件
				<small>
					<i class="ace-icon fa fa-angle-double-right"></i>
					代码生成器
				</small>
			</h1>
		</div><!-- /.page-header -->
	
		<div class="row">
			<div class="col-xs-12">
				<!-- PAGE CONTENT BEGINS -->
				<c:if test="${not empty msg}">
					<div class="alert alert-info">
						<button type="button" class="close" data-dismiss="alert">
							<i class="icon-remove"></i>
						</button>
						<strong>提示!</strong>
							${msg}
						<br />
					</div>
				</c:if>
				<div class="alert alert-block alert-warning">
					<button type="button" class="close" data-dismiss="alert">
						<i class="ace-icon fa fa-times"></i>
					</button>

					<p>
						<strong>
							<i class="ace-icon fa fa-check"></i>
							注意!
						</strong>
						在勾选生成表的时候请不要重复勾选主次表，避免重复生成代码，或导致代码生成错误。因为代码生成器默认是将关系表一并生成的！
					</p>
				</div>
				<p>
					<shiro:hasPermission name="table:create">
						<button id="btnAdd" class="btn btn-info no-border btn-sm">
							<i class="ace-icon fa fa-pencil align-top bigger-125"></i>
							新增方案
						</button>
					</shiro:hasPermission>
					<shiro:hasPermission name="table:delete">
						<button id="btnDeleBatch"class="btn btn-danger no-border btn-sm">
							<i class="ace-icon fa fa-trash-o align-top bigger-125"></i>
							批量删除
						</button>
					</shiro:hasPermission>
					<shiro:hasPermission name="table:create">
						<button id="btnGenCode"class="btn btn-success no-border btn-sm">
							<i class="ace-icon fa fa-gavel align-top bigger-125"></i>
							代码生成
						</button>
					</shiro:hasPermission>
				</p>
				<div class="table-header">
					&nbsp;
				</div>
				<div class="table-responsive">
					<table id="sortable" class="table table-striped table-bordered table-hover">
					    <thead>
					        <tr>
					        	<th class="center"><input type="checkbox" id="checkAll" class="ace"/><span class="lbl"></span></th>
					        	<th>#</th>
								<th>表名</th>
								<th>父表名</th>
					            <th>实体类名</th>
					            <th>包路径</th>
					            <th>备注</th>
								<th>状态</th>
								<th>关系</th>
								<th>操作</th>
					        </tr>
					    </thead>
					    <tbody>
					        <c:forEach items="${tableList}" var="table" varStatus="stat">
					            <tr>
					            	<td class="center"><input name="idList" type="checkbox" class="ace" value="${table.id}" table-step="${table.step}" table-name="${table.tableName}" relation="$${table.relationType}"/><span class="lbl"></span></td>
					            	<td>${stat.index+1}</td>
					                <td>${table.tableName}</td>
					                <td>${table.parent.tableName}</td>
					                <td>${table.domainName}</td>
					                <td>${table.pkg}</td>
									<td>${table.comments}</td>
					                <td>
										<div class="progress progress-striped pos-rel active" data-percent="<fmt:formatNumber value='${(table.step/3)*100}' pattern='#'/>%">
											<div class="progress-bar progress-bar-success" style="width:<fmt:formatNumber value='${(table.step/3)*100}' pattern='#'/>%;"></div>
										</div>
									</td>
									<td>
										${table.relationType.info}
									</td>
					                <td>
					                	<div class="visible-md visible-lg hidden-sm hidden-xs action-buttons">
						                    <shiro:hasPermission name="table:update">
												<a class="blue" href="${adminFullPath}/table/${table.id}/viewColumn" title="定义">
													<i class="ace-icon fa fa-fire bigger-130"></i>
												</a>
						                    </shiro:hasPermission>
						                    <shiro:hasPermission name="table:delete">
						                    	<a class="deleteBtn red" href="#" data-id="${table.id}" title="删除">
													<i class="ace-icon fa fa-trash-o bigger-130"></i>
												</a>
						                    </shiro:hasPermission>
										</div>
					                </td>
					            </tr>
					        </c:forEach>
					    </tbody>
					</table>
				</div>
				<!-- PAGE CONTENT ENDS -->
			</div><!-- /.col -->
		</div><!-- /.row -->
	</div><!-- /.page-content-area -->
	<script type="text/javascript">
		$(function(){
			$('#btnAdd').on('click',function(){
				window.location="${adminFullPath}/table/create/viewColumn";
			});
			$(".deleteBtn").click(function() {
				var self = this;
				platform.showDeleteDialog({
					beforDeleteHandler:function(dialog){
						window.location="${adminFullPath}/table/delete?id="+$(self).attr("data-id");
					}
				});
	        });
			$('#btnDeleBatch').on('click',function(){
				var result = getTableChecked();
				if(!!!result)
					return false;
				platform.showDeleteDialog({
					beforDeleteHandler:function(dialog){
						window.location="${adminFullPath}/table/deleteBatch?id="+result;
					}
				});
			});
			$('#btnGenCode').on('click',function(){
				var skipTable = [];
				var result = getTableChecked(false,function(id){
					if((parseInt('<%=TableConstants.GEN_STEP_TWO%>')<=parseInt($('[value="'+id+'"]').attr('table-step'))))
						return true;
					skipTable.push($('[value="'+id+'"]').attr('table-name'));
					return false;
				});
				if(!!!result){
					$.jBox.tip('亲！请选择配置好方案生成规则的数据进行操作！', 'warn');
					return false;
				}
				if(skipTable.length>0)
					$.jBox.tip('亲！['+skipTable.join(',')+']不符合生成规则，系统自动跳过！', 'info');
				window.location="${adminFullPath}/table/genCodeBatch?id="+result;
			});
			//添加表格排序事件
			$('#sortable').dataTable({
				"aoColumns": [
			      { "bSortable": false },
			      { "bSortable": false }, null, null,null, null,{ "bSortable": false },null,null,
				  { "bSortable": false }
				],"aaSorting": []});
			//添加表格全选事件
			bindCheckAllEvent();
		});
	</script>
</body>
</html>