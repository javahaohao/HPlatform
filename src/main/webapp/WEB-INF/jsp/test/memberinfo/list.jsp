<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/include/taglib.jsp"%>
<html>
<head>
    <tags:header inplugins="${plugins.jqgrid},${plugins.jqui},${plugins.template},${plugins.jbox}" title="一对一测试表"></tags:header>
</head>
<body>
	<div class="page-content-area">
		<div class="page-header">
			<h1>
				一对一测试表
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
					<shiro:hasPermission name="memberInfo:create">
						<button id="btnAdd" class="btn btn-info no-border">
							<i class="ace-icon fa fa-pencil align-top bigger-125"></i>
							新增
						</button>
					</shiro:hasPermission>
					<shiro:hasPermission name="memberInfo:delete">
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
			<shiro:hasPermission name="memberInfo:update">
				<a class="green" href="${adminFullPath}/memberInfo/{{id}}/update" title="修改">
					<i class="ace-icon fa fa-pencil bigger-130"></i>
				</a>
            </shiro:hasPermission>
            
            <shiro:hasPermission name="memberInfo:delete">
            	<a class="deleteBtn red" href="#" data-id="{{id}}" title="删除">
					<i class="ace-icon fa fa-trash-o bigger-130"></i>
				</a>
            </shiro:hasPermission>
		</div>
	</script>
	<script type="text/javascript">
		$(function(){
			$('#btnAdd').on('click',function(){
				window.location="${adminFullPath}/memberInfo/add";
			});
            $(document).on('click',".deleteBtn",function() {
				var self = this;
	        	platform.showDeleteDialog({
					beforDeleteHandler:function(dialog){
						window.location="${adminFullPath}/memberInfo/"+$(self).attr("data-id")+"/delete";
					}
				});
	        });
			$('#btnDeleBatch').on('click',function(){
				var result = getTableChecked();
				if(!!!result)
					return false;
				platform.showDeleteDialog({
					beforDeleteHandler:function(dialog){
						window.location="${adminFullPath}/memberInfo/deleteBatch?id="+result;
					}
				});
			});
			//jqgrid渲染表格配置
			$('#grid-table').jqDatagrid({
				caption: "列表",
				url:'${adminFullPath}/memberInfo/list'
			},{
				columnModel:[
		        	{header:'用户名',name:'member.memberName',index:'m.member_name',sortable:true},
		        	{header:'年龄',name:'member.age',index:'m.age',sortable:true},
		        	{header:'身高',name:'member.height',index:'m.height',sortable:true},
		        	{header:'性别',name:'member.sex',index:'m.sex',sortable:true},
		        	{header:'创建人',name:'member.createUserName',index:'m.create_user',sortable:true},
		        	{header:'修改人',name:'member.updateUserName',index:'m.update_user',sortable:true},
		        	{header:'创建时间',name:'member.createDate',index:'m.create_date',sortable:true,formatter:function(val,options,obj,oper){
                        return new Date(val).format('yyyy-MM-dd hh:mm:ss');
                    }},
		        	{header:'修改时间',name:'member.updateDate',index:'m.update_date',sortable:true,formatter:function(val,options,obj,oper){
                        return new Date(val).format('yyyy-MM-dd hh:mm:ss');
                    }},
		        	{header:'用户信息',name:'memberId',index:'mi.member_id',sortable:true},
		        	{header:'等级',name:'level',index:'mi.level',sortable:true},
		        	{header:'手机',name:'phone',index:'mi.phone',sortable:false},
		        	{header:'邮箱',name:'email',index:'mi.email',sortable:true},
		        	{header:'创建人',name:'createUserName',index:'mi.create_user',sortable:true},
		        	{header:'修改人',name:'updateUserName',index:'mi.update_user',sortable:true},
		        	{header:'创建时间',name:'createDate',index:'mi.create_date',sortable:true,formatter:function(val,options,obj,oper){
                        return new Date(val).format('yyyy-MM-dd hh:mm:ss');
                    }},
		        	{header:'修改时间',name:'updateDate',index:'mi.update_date',sortable:true,formatter:function(val,options,obj,oper){
                        return new Date(val).format('yyyy-MM-dd hh:mm:ss');
                    }},
					{header:'操作',name:'',sortable:false,title:false,classes:'no-white-space',formatter:function(val,obj,row,oper){
						return template('oper',row);
					}}
				]
			});
		});
	</script>
</body>
</html>