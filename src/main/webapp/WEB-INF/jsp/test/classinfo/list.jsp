<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/include/taglib.jsp"%>
<html>
<head>
    <tags:header inplugins="${plugins.jqgrid},${plugins.jqui}" title="父表"></tags:header>
</head>
<body>
	<div class="page-content-area">
		<div class="page-header">
			<h1>
				父表
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
					<shiro:hasPermission name="classInfo:create">
						<button id="btnAdd" class="btn btn-info no-border">
							<i class="ace-icon fa fa-pencil align-top bigger-125"></i>
							新增
						</button>
					</shiro:hasPermission>
					<shiro:hasPermission name="classInfo:delete">
						<button id="btnDeleBatch"class="btn btn-danger no-border">
							<i class="ace-icon fa fa-trash-o align-top bigger-125"></i>
							删除
						</button>
					</shiro:hasPermission>
				</p>
				<div class="modal-body no-padding">
					<table id="grid-table">
					</table>
					<div id="grid-page"></div>
				</div>
				<!-- PAGE CONTENT ENDS -->
			</div><!-- /.col -->
		</div><!-- /.row -->
	</div><!-- /.page-content-area -->
	<script type="text/html" id="oper">
		<div class="visible-md visible-lg hidden-sm hidden-xs action-buttons">
			<shiro:hasPermission name="classInfo:update">
				<a class="green" href="${adminFullPath}/classInfo/{{id}}/update" title="修改">
					<i class="ace-icon fa fa-pencil bigger-130"></i>
				</a>
            </shiro:hasPermission>
            
            <shiro:hasPermission name="classInfo:delete">
            	<a class="deleteBtn red" href="#" data-id="{{id}}" title="删除">
					<i class="ace-icon fa fa-trash-o bigger-130"></i>
				</a>
            </shiro:hasPermission>
		</div>
	</script>
	<script type="text/javascript">
		$(function(){
			$('#btnAdd').on('click',function(){
				window.location="${adminFullPath}/classInfo/add";
			});
			$(".deleteBtn").click(function() {
				var self = this;
	        	platform.showDeleteDialog({
					beforDeleteHandler:function(dialog){
						window.location="${adminFullPath}/classInfo/"+$(self).attr("data-id")+"/delete";
					}
				});
	        });
			$('#btnDeleBatch').on('click',function(){
				var result = getTableChecked();
				if(!!!result)
					return false;
				platform.showDeleteDialog({
					beforDeleteHandler:function(dialog){
						window.location="${adminFullPath}/classInfo/deleteBatch?id="+result;
					}
				});
			});
			//jqgrid渲染表格配置
			$('#grid-table').jqDatagrid({
				caption: "列表",
				url:'${adminFullPath}/classInfo/list'
			},{
				columnModel:[
		        	{header:'班级名字',name:'className',index:'class_name',sortable:true},
		        	{header:'楼层',name:'floor',index:'floor',sortable:true},
		        	{header:'创建人',name:'createUser',index:'create_user',sortable:true},
		        	{header:'修改人',name:'updateUser',index:'update_user',sortable:true},
		        	{header:'创建时间',name:'createDate',index:'create_date',sortable:true},
		        	{header:'修改时间',name:'updateDate',index:'update_date',sortable:true},
					{header:'操作',name:'',sortable:false,title:false,classes:'no-white-space',formatter:function(val,obj,row,oper){
						return template('oper',row);
					}}
				]
			});
		});
	</script>
</body>
</html>