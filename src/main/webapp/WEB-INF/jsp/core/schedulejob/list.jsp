<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/include/taglib.jsp"%>
<html>
<head>
    <tags:header inplugins="${plugins.jqui},${plugins.dataTables}" title="任务调度表"></tags:header>
</head>
<body>
	<div class="page-content-area">
		<div class="page-header">
			<h1>
				任务调度表
				<small>
					<i class="ace-icon fa fa-angle-double-right"></i>
					 列表
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
				<p>
					<shiro:hasPermission name="scheduleJob:create">
						<button id="btnAdd" class="btn btn-info no-border btn-sm">
							<i class="ace-icon fa fa-pencil align-top bigger-125"></i>
							新增
						</button>
					</shiro:hasPermission>
					<shiro:hasPermission name="scheduleJob:delete">
						<button id="btnDeleBatch"class="btn btn-danger no-border btn-sm">
							<i class="ace-icon fa fa-trash-o align-top bigger-125"></i>
							删除
						</button>
					</shiro:hasPermission>
				</p>
				<div class="table-header">
					&nbsp;
				</div>
				<div class="modal-body no-padding">
					<table id="sortable" class="table table-striped table-bordered table-hover no-margin-bottom no-border-top">
					    <thead>
					        <tr>
					        	<th class="center"><input type="checkbox" id="checkAll" class="ace"/><span class="lbl"></span></th>
					        	<th>#</th>
					            <th></th>
					            <th></th>
					            <th></th>
					            <th></th>
					            <th></th>
					            <th></th>
					            <th></th>
					            <th></th>
					            <th></th>
					            <th></th>
					            <th></th>
					            <th>操作</th>
					        </tr>
					    </thead>
					    <tbody>
					        <c:forEach items="${scheduleJobList}" var="scheduleJob" varStatus="stat">
					            <tr>
					            	<td class="center"><input name="idList" type="checkbox" class="ace" value="${scheduleJob.id}"/><span class="lbl"></span></td>
					            	<td>${stat.index+1}</td>
						            <td>${scheduleJob.jobId}</td>
						            <td>${scheduleJob.jobName}</td>
						            <td>${scheduleJob.jobGroup}</td>
						            <td>${scheduleJob.jobImpl}</td>
						            <td>${scheduleJob.jobStatus}</td>
						            <td>${scheduleJob.cronExpression}</td>
						            <td>${scheduleJob.desc}</td>
						            <td>${scheduleJob.createDate}</td>
						            <td>${scheduleJob.updateDate}</td>
						            <td>${scheduleJob.createUser}</td>
						            <td>${scheduleJob.updateUser}</td>
					                <td>
					                	<div class="visible-md visible-lg hidden-sm hidden-xs action-buttons">
											<shiro:hasPermission name="scheduleJob:update">
												<a class="green" href="${adminFullPath}/scheduleJob/${scheduleJob.id}/update" title="修改">
													<i class="ace-icon fa fa-pencil bigger-130"></i>
												</a>
						                    </shiro:hasPermission>
						                    
						                    <shiro:hasPermission name="scheduleJob:delete">
						                    	<a class="deleteBtn red" href="#" data-id="${scheduleJob.id}" title="删除">
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
				window.location="${adminFullPath}/scheduleJob/add";
			});
			$(".deleteBtn").click(function() {
				var self = this;
	        	platform.showDeleteDialog({
					beforDeleteHandler:function(dialog){
						window.location="${adminFullPath}/scheduleJob/"+$(self).attr("data-id")+"/delete";
					}
				});
	        });
			$('#btnDeleBatch').on('click',function(){
				var result = getTableChecked();
				if(!!!result)
					return false;
				platform.showDeleteDialog({
					beforDeleteHandler:function(dialog){
						window.location="${adminFullPath}/scheduleJob/deleteBatch?id="+result;
					}
				});
			});
			//添加表格排序事件
			$('#sortable').dataTable({
				"aoColumns": [
			      { "bSortable": false },
			      { "bSortable": false }, null,null,null,null,null,null,null,null,null,null,null,
				  { "bSortable": false }
				],"aaSorting": []});
			//添加表格全选事件
			bindCheckAllEvent();
		});
	</script>
</body>
</html>