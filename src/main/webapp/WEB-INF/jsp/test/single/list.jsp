<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/include/taglib.jsp"%>
<html>
<head>
    <tags:header inplugins="${plugins.jqgrid},${plugins.jqui},${plugins.template},${plugins.jbox}" title="测试单表生成"></tags:header>
</head>
<body>
	<div class="page-content-area">
		<div class="page-header">
			<h1>
				测试单表生成
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
					<shiro:hasPermission name="single:create">
						<button id="btnAdd" class="btn btn-info no-border">
							<i class="ace-icon fa fa-pencil align-top bigger-125"></i>
							新增
						</button>
					</shiro:hasPermission>
					<shiro:hasPermission name="single:delete">
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
			<shiro:hasPermission name="single:update">
				<a class="green" href="${adminFullPath}/single/{{id}}/update" title="修改">
					<i class="ace-icon fa fa-pencil bigger-130"></i>
				</a>
            </shiro:hasPermission>
            
            <shiro:hasPermission name="single:delete">
            	<a class="deleteBtn red" href="#" data-id="{{id}}" title="删除">
					<i class="ace-icon fa fa-trash-o bigger-130"></i>
				</a>
            </shiro:hasPermission>
		</div>
	</script>
	<script type="text/javascript">
		$(function(){
			$('#btnAdd').on('click',function(){
				window.location="${adminFullPath}/single/add";
			});
            $(document).on('click',".deleteBtn",function() {
				var self = this;
	        	platform.showDeleteDialog({
					beforDeleteHandler:function(dialog){
						window.location="${adminFullPath}/single/"+$(self).attr("data-id")+"/delete";
					}
				});
	        });
			$('#btnDeleBatch').on('click',function(){
				var result = getTableChecked();
				if(!!!result)
					return false;
				platform.showDeleteDialog({
					beforDeleteHandler:function(dialog){
						window.location="${adminFullPath}/single/deleteBatch?id="+result;
					}
				});
			});
			//jqgrid渲染表格配置
			$('#grid-table').jqDatagrid({
				caption: "列表",
				url:'${adminFullPath}/single/list'
			},{
				columnModel:[
		        	{header:'测试one',name:'testOne',index:'single.test_one',sortable:false},
		        	{header:'测试two',name:'testTwo',index:'single.test_two',sortable:true},
		        	{header:'测试three',name:'testThree',index:'single.test_three',sortable:true},
		        	{header:'创建人',name:'createUserName',index:'single.create_user',sortable:true},
		        	{header:'修改人',name:'updateUserName',index:'single.update_user',sortable:true},
		        	{header:'创建时间',name:'createDate',index:'single.create_date',sortable:true,formatter:function(val,options,obj,oper){
                        return new Date(val).format('yyyy-MM-dd hh:mm:ss');
                    }},
		        	{header:'修改时间',name:'updateDate',index:'single.update_date',sortable:true,formatter:function(val,options,obj,oper){
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