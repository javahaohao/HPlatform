<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/include/taglib.jsp"%>
<html>
<head>
	<tags:header inplugins="${plugins.dataTables},${plugins.jqui}" title="上传文件列表"></tags:header>
</head>
<body>
	<div class="page-content-area">
		<div class="page-header">
			<h1>
				上传文件
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
					<button id="btnDeleBatch"class="btn btn-danger no-border btn-sm">
						<i class="ace-icon fa fa-trash-o align-top bigger-125"></i>
						批量删除
					</button>
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
					            <th>名称</th>
					            <th>标题</th>
					            <th>存储名称</th>
					            <th>sha1(检验码)</th>
					            <th>存储路径</th>
					            <th>文件大小</th>
					            <th>MIME类型</th>
					            <th>操作</th>
					        </tr>
					    </thead>
					    <tbody>
					        <c:forEach items="${attachmentList}" var="attachment" varStatus="stat">
					            <tr>
					            	<td class="center"><input name="idList" type="checkbox" class="ace" value="${attachment.id}"/><span class="lbl"></span></td>
					            	<td>${stat.index+1}</td>
					            	<td>
					            		${attachment.name}
					            	</td>
					                <td>${attachment.title}</td>
					                <td>${attachment.realName}</td>
					                <td>${attachment.sha1}</td>
					                <td>${attachment.path}</td>
					                <td>${attachment.size}</td>
					                <td>${attachment.type}</td>
					                <td>
					                	<div class="visible-md visible-lg hidden-sm hidden-xs action-buttons">
					                    	<a class="deleteBtn red" href="#" data-id="${attachment.id}" title="删除">
												<i class="ace-icon fa fa-trash-o bigger-130"></i>
											</a>
											<a class="downloadBtn blue" href="#" data-id="${attachment.id}" title="下载">
												<i class="ace-icon fa fa-download bigger-130"></i>
											</a>
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
			$(".deleteBtn").click(function() {
				var dataId = $(this).attr("data-id");
	        	platform.showDeleteDialog({
					beforDeleteHandler:function(dialog){
						window.location="${adminFullPath}/attachment/deleteAttachmentFrom?id="+dataId;
					}
				});
	        });
			$('#btnDeleBatch').on('click',function(){
				var result = getTableChecked();
				if(!!!result)
					return false;
				platform.showDeleteDialog({
					beforDeleteHandler:function(dialog){
						window.location="${adminFullPath}/attachment/deleteAttachmentFrom?id="+result;
					}
				});
			});
			$('.downloadBtn').on('click',function(){
				var dataId = $(this).attr("data-id");
				if(!!!dataId)
					return false;
				window.location="${adminFullPath}/attachment/download?id="+dataId;
			});
			//添加表格排序事件
			$('#sortable').dataTable({
				bAutoWidth: false,
				"aoColumns": [
			      { "bSortable": false },{ "bSortable": false },
			      null, null,null,null, null,null,null,
				  { "bSortable": false }
				],"aaSorting": []
			});
			//添加表格全选事件
			bindCheckAllEvent();
		});
	</script>
</body>
</html>