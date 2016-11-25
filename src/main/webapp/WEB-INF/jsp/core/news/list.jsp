<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/include/taglib.jsp"%>
<html>
<head>
    <tags:header inplugins="${plugins.jqui},${plugins.dataTables},${plugins.jbox}" title="新闻列表"></tags:header>
    <style type="text/css">
    	.btn-toolbar .btn-group{float:none;}
    	.btn-group>.btn, .btn-group+.btn{border-width: 2px;}
    </style>
</head>
<body>
	<div class="page-content-area-area">
		<div class="page-header">
			<h1>
				新闻
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
				<div class="btn-toolbar">
					<shiro:hasPermission name="news:create">
						<button id="btnAdd" class="btn btn-info no-border btn-sm">
							<i class="ace-icon fa fa-pencil align-top bigger-125"></i>
							新增新闻
						</button>
					</shiro:hasPermission>
					<shiro:hasPermission name="news:update">
						<button id="btnCheck" class="btn btn-purple no-border btn-sm">
							<i class="ace-icon fa fa-eye align-top bigger-125"></i>
							审核
						</button>
					</shiro:hasPermission>
					<shiro:hasPermission name="news:delete">
						<button id="btnDeleBatch"class="btn btn-danger no-border btn-sm">
							<i class="ace-icon fa fa-trash-o align-top bigger-125"></i>
							批量删除
						</button>
					</shiro:hasPermission>
					<shiro:hasPermission name="news:update">
						<div class="btn-group">
							<button data-toggle="dropdown" class="btn btn-lg btn-primary dropdown-toggle btn-sm">
								新闻类型
								<span class="ace-icon fa fa-caret-down icon-on-right"></span>
							</button>

							<ul class="dropdown-menu dropdown-default">
								<li>
									<a href="#" id="topnews">新闻头条</a>
								</li>

								<li>
									<a href="#" id="notop">取消头条</a>
								</li>

								<li class="divider"></li>
								
								<li>
									<a href="#" id="hotsnews">热点新闻</a>
								</li>

								<li>
									<a href="#" id="nohots">取消热点</a>
								</li>
							</ul>
						</div>
					</shiro:hasPermission>
				</div>
				<div class="table-header">
					&nbsp;
				</div>
				<div class="table-responsive">
					<table id="sortable" class="table table-striped table-bordered table-hover">
					    <thead>
					        <tr>
					        	<th class="center"><input type="checkbox" id="checkAll" class="ace"/><span class="lbl"></span></th>
					        	<th>#</th>
					            <th>新闻标题</th>
					            <th>简介</th>
					            <th>新闻类型</th>
					            <th>点击数</th>
					            <th>来源</th>
					            <th>是否头条</th>
					            <th>是否热闻</th>
					            <th>状态(审核)</th>
					            <th>操作</th>
					        </tr>
					    </thead>
					    <tbody>
					        <c:forEach items="${newsList}" var="news" varStatus="stat">
					            <tr>
					            	<td class="center"><input name="idList" type="checkbox" class="ace" value="${news.id}"/><span class="lbl"></span></td>
					            	<td>${stat.index+1}</td>
					                <td>${news.title}</td>
					                <td>${news.summary}</td>
					                <td>${elfn:getDictById(news.newsType).name}</td>
					                <td><fmt:formatNumber value="${news.clicks}" type="number"/></td>
					                <td>${elfn:getDictById(news.source).name}</td>
					                <td><tags:status id="newstop" title="点此更改新闻状态" type="top" value="${news.top}" flable="非头条" tlable="头条" nullable="非头条"></tags:status></td>
					                <td><tags:status id="newshots" title="点此更改新闻状态" type="hots" value="${news.hightlight}" flable="非热闻" tlable="热闻" nullable="非热闻"></tags:status></td>
					                <td><tags:status id="newscheck" value="${news.checkup}" flable="未审核" tlable="通过" nullable="未操作"></tags:status></td>
					                <td>
					                	<div class="visible-md visible-lg hidden-sm hidden-xs action-buttons">
											<shiro:hasPermission name="news:update">
												<a class="green" href="${adminFullPath}/news/${news.id}/update" title="修改">
													<i class="ace-icon fa fa-pencil bigger-130"></i>
												</a>
						                    </shiro:hasPermission>
						                    
											<shiro:hasPermission name="news:view">
												<a class="blue" href="${adminFullPath}/news/${news.id}/viewComment" title="查看评论">
													<i class="ace-icon fa fa-comments-o bigger-130"></i>
												</a>
						                    </shiro:hasPermission>
						                    
						                    <shiro:hasPermission name="news:delete">
						                    	<a class="deleteBtn red" href="#" data-id="${news.id}" title="删除">
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
	<div id="dialog-message" class="hide">
		<form action="${adminFullPath}/news/updateStatus" method="post" id="checkForm">
			<input type="hidden" name="id" id="newsId">
			<input type="hidden" name="checkup" id="checkup">
			<input type="hidden" name="top" id="top">
			<input type="hidden" name="hightlight" id="hightlight">
			<div class="page-content-area">
				<div class="row">
		            <div class="col-xs-12">
						<textarea id="checkOpinion" rows="5" name="checkOpinion" class="form-control" maxlength="250" class="require"></textarea>
					</div>
				</div>
			</div>
		</form>
	</div><!-- #dialog-message -->
	<script type="text/javascript">
		$(function(){
			$('#topnews').on('click',function(){
				var result = getTableChecked();
				if(!!!result)
					return false;
				$('#newsId').val(result);
				$('#top').val('true');
				$('#checkForm').submit();
			});
			$('#notop').on('click',function(){
				var result = getTableChecked();
				if(!!!result)
					return false;
				$('#newsId').val(result);
				$('#top').val('false');
				$('#checkForm').submit();
			});
			$('#hotsnews').on('click',function(){
				var result = getTableChecked();
				if(!!!result)
					return false;
				$('#newsId').val(result);
				$('#hightlight').val('true');
				$('#checkForm').submit();
			});
			$('#nohots').on('click',function(){
				var result = getTableChecked();
				if(!!!result)
					return false;
				$('#newsId').val(result);
				$('#hightlight').val('false');
				$('#checkForm').submit();
			});
			
			$( "#btnCheck" ).on('click', function(e) {
				e.preventDefault();
				var result = getTableChecked();
				if(!!!result)
					return false;
				var dialog = $( "#dialog-message" ).removeClass('hide').dialog({
					minWidth:400,
					minHeight:250,
					modal: true,
					title: "<div class='widget-header widget-header-small'><h4 class='smaller'><i class='icon-ok'></i>审核意见</h4></div>",
					title_html: true,
					buttons: [{
							text: "批准",
							"class" : "btn btn-primary btn-xs",
							click: function() {
								if(!checkFormSubmit('true'))return false;
								$( this ).dialog( "close" ); 
							} 
						},{
							text: "撤销",
							"class" : "btn btn-danger btn-xs",
							click: function() {
								if(!checkFormSubmit('false'))return false;
								$( this ).dialog( "close" ); 
							} 
						},{
							text: "取消",
							"class" : "btn btn-xs",
							click: function() {
								$( this ).dialog( "close" ); 
							} 
						}]
				});
		
				/**
				dialog.data( "uiDialog" )._title = function(title) {
					title.html( this.options.title );
				};
				**/
			});
			$('#btnAdd').on('click',function(){
				window.location="${adminFullPath}/news/add";
			});
			$(".deleteBtn").click(function() {
				var self = this;
				platform.showDeleteDialog({
					beforDeleteHandler:function(dialog){
						window.location="${adminFullPath}/news/delete?id="+$(self).attr("data-id");
					}
				});
	        });
			$('#btnDeleBatch').on('click',function(){
				var result = getTableChecked();
				if(!!!result)
					return false;
				platform.showDeleteDialog({
					beforDeleteHandler:function(dialog){
						window.location="${adminFullPath}/news/deleteBatch?id="+result;
					}
				});
			});
			//添加表格排序事件
			$('#sortable').dataTable({
				"aoColumns": [
			      { "bSortable": false },
			      { "bSortable": false }, null,null,null,null, null,null,null, null,
				  { "bSortable": false }
				],"aaSorting": []});
			//添加表格全选事件
			bindCheckAllEvent();
		});
		function checkFormSubmit(checkup){
			if(!$("#checkOpinion").val()){
				$.jBox.tip('亲！请输入您的审核意见！', 'info');
				return false;
			}
			var result = getTableChecked();
			if(!!!result)
				return false;
			$('#checkup').val(checkup);
			$('#newsId').val(result);
			$('#checkForm').submit();
		}
	</script>
</body>
</html>