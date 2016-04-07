<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<tags:header inplugins="${plugins.jqui},${plugins.dataTables},${plugins.jbox}" title="邮件服务设置"></tags:header>
</head>
<body>
	<div class="page-content-area">
		<div class="page-header">
			<h1>
				组件
				<small>
					<i class="ace-icon fa fa-angle-double-right"></i>
					 邮件服务
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
					<shiro:hasPermission name="mailDict:create">
						<button id="btnAdd" class="btn btn-info no-border">
							<i class="ace-icon fa fa-pencil align-top bigger-125"></i>
							新增服务
						</button>
					</shiro:hasPermission>
					<shiro:hasPermission name="mailDict:delete">
						<button id="btnDeleBatch"class="btn btn-danger no-border">
							<i class="ace-icon fa fa-trash-o align-top bigger-125"></i>
							批量删除
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
					            <th>类型</th>
					            <th>SMTP</th>
					            <th>SMTP端口号</th>
					            <th>POP3</th>
					            <th>POP3端口号</th>
					            <th>IMAP</th>
					            <th>IMAP端口号</th>
					            <th>创建人</th>
					            <th>创建时间</th>
					            <th>修改人</th>
					            <th>修改时间</th>
					            <th>操作</th>
					        </tr>
					    </thead>
					    <tbody>
					        <c:forEach items="${mailDictList}" var="mailDict" varStatus="stat">
					            <tr>
					            	<td class="center"><input name="idList" type="checkbox" class="ace"/><span class="lbl"></span></td>
					            	<td>${stat.index+1}</td>
					                <td>${mailDict.type}</td>
					                <td>${mailDict.smtp}</td>
					                <td>${mailDict.smtpPort}</td>
					                <td>${mailDict.pop3}</td>
					                <td>${mailDict.pop3Port}</td>
					                <td>${mailDict.imap}</td>
					                <td>${mailDict.imapPort}</td>
					                <td>${elfn:getUserById(mailDict.createUser).username}</td>
					                <td><fmt:formatDate value="${mailDict.createDate}" type="both"/></td>
					                <td>${elfn:getUserById(mailDict.updateUser).username}</td>
					                <td><fmt:formatDate value="${mailDict.updateDate}" type="both"/></td>
					                <td>
					                	<div class="visible-md visible-lg hidden-sm hidden-xs action-buttons">
											<shiro:hasPermission name="mailDict:update">
												<a class="green" href="${adminFullPath}/mailDict/${mailDict.id}/update" title="修改">
													<i class="ace-icon fa fa-pencil bigger-130"></i>
												</a>
						                    </shiro:hasPermission>
						                    
						                    <shiro:hasPermission name="mailDict:delete">
						                    	<a class="red" href="javascript:deleteRole(${mailDict.id})" title="删除">
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
				window.location="${adminFullPath}/mailDict/add";
			});
			$('#btnDeleBatch').on('click',function(){
				if(!confirm('您确定要删除所选择的数据？'))
					return false;
				var result = getTableChecked();
				if(!!!result)
					return false;
				window.location="${adminFullPath}/mailDict/deleteBatch?id="+result;
			});
			//添加表格排序事件
			$('#sortable').dataTable({
				"aoColumns": [
			      { "bSortable": false },
			      { "bSortable": false }, null,null, null,null,null, null,null,null, null,null,null,
				  { "bSortable": false }
				],"aaSorting": []});
			//添加表格全选事件
			bindCheckAllEvent();
		});
		function deleteUser(userId){
			$.jBox.confirm("您确定删除选中的数据？", "提示", function (v, h, f) {
			    if (v == true){
			    	window.location="${adminFullPath}/mailDict/delete?id="+userId;
			    }
			    return true;
			}, { buttons: { '确定': true, '取消': false} });
		}
	</script>
</body>
</html>