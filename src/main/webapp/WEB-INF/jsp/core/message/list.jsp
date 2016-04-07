<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/include/taglib.jsp"%>
<html>
<head>
    <tags:header inplugins="${plugins.jqui},${plugins.template},${plugins.validate}" title="即时通讯"></tags:header>
    <link rel="stylesheet" href="${contextPath}/static/common/css/msg.css" />
</head>
<body>
	<div class="page-content-area">
		<div class="page-header">
			<h1>
				组件管理
				<small>
					<i class="ace-icon fa fa-angle-double-right"></i>
					 即时通讯
				</small>
			</h1>
		</div><!-- /.page-header -->
	
		<div class="row">
			<div class="col-xs-3 container-group-left">
				<div class="widget-box">
					<div class="widget-header">
						<h4 class="widget-title lighter smaller">
							<i class="ace-icon fa fa-users blue"></i>
							好友/群组
						</h4>
					</div>

					<div class="widget-body">
						<div class="widget-main no-padding">
							<!-- #section:pages/dashboard.conversations -->
							<div class="dialogs">
								<div id="tabs">
									<ul>
										<li>
											<a href="#tabs-1">好友</a>
										</li>
										<li>
											<a href="#tabs-2">群组</a>
										</li>
									</ul>
									<div id="tabs-1">
										<p>
											<button class="btn btn-white btn-info btn-bold btn-xs">
												<i class="ace-icon glyphicon glyphicon-search bigger-100 blue"></i>
												查找
											</button>
										</p>
										<c:forEach var="user" items="${users}">
											<c:if test="${elfn:getCurrentUser().id ne user.id}">
												<div class="itemdiv commentdiv message-group">
													<div class="user">
														<img alt="Alexa's Avatar" src="${adminFullPath}/attachment/readImageStreamId?id=${user.headPic}" onerror="this.src='${contextPath}/static/common/img/profile-pic.jpg'"/>
													</div>
													<div class="body friends">
														<div class="name">
															<a href="#">${user.nick}</a>
														</div>
														<div class="text green">
															在线
														</div>
														<div class="tools">
															<a href="javascript:void(0)" windowid="${user.id}" type="${constants.TALK_TYPE_USER}" nick="${user.nick}" headerpic="${user.headPic}" class="btn btn-minier btn-info open-send" title="发送消息">
																<i class="icon-only fa fa-comments-o"></i>
															</a>
														</div>
													</div>
												</div>
											</c:if>
										</c:forEach>
									</div>
									<div id="tabs-2">
										<p>
											<button class="btn btn-white btn-info btn-bold btn-xs" id="create-group" optype="create">
												<i class="ace-icon glyphicon glyphicon-plus bigger-100 blue"></i>
												新建
											</button>
											<button class="btn btn-white btn-info btn-bold btn-xs">
												<i class="ace-icon glyphicon glyphicon-search bigger-100 blue"></i>
												加群
											</button>
										</p>
										<c:forEach var="messageGroupUser" items="${messageGroupUsers}">
											<div class="itemdiv commentdiv message-group">
												<div class="user">
													<img alt="${messageGroupUser.group.group}" src="${adminFullPath}/attachment/readImageStreamId?id=${messageGroupUser.group.pic}" onerror="this.src='${contextPath}/static/common/img/profile-pic.jpg'"/>
												</div>
												<div class="body">
													<div class="name">
														<a href="#">${messageGroupUser.group.group}</a>
													</div>
													<div class="time">
														<i class="ace-icon fa fa-clock-o" title=""></i>
													</div>
													<div class="text">${messageGroupUser.group.groupRemark}</div>
													<div class="tools">
														<div class="inline position-relative">
															<button class="btn btn-minier btn-yellow btn-no-border dropdown-toggle" data-toggle="dropdown" data-position="auto">
																<i class="ace-icon fa fa-angle-down icon-only bigger-120"></i>
															</button>

															<ul class="dropdown-menu dropdown-only-icon dropdown-yellow dropdown-menu-right dropdown-caret dropdown-close">
																<li>
																	<a href="javascript:void(0)" type="${constants.TALK_TYPE_GROUP}" nick="${messageGroupUser.group.group}" windowid="${messageGroupUser.group.id}" class="tooltip-success open-send" title="发送消息">
																		<span class="green">
																			<i class="ace-icon fa fa-share bigger-110"></i>
																		</span>
																	</a>
																</li>

																<li>
																	<a href="javascript:void(0)" groupid="${messageGroupUser.group.id}" class="tooltip-warning update-group" title="修改群组">
																		<span class="orange">
																			<i class="ace-icon fa fa-pencil-square-o bigger-110"></i>
																		</span>
																	</a>
																</li>

																<li>
																	<a href="javascript:void(0)" groupid="${messageGroupUser.group.id}" class="tooltip-error delete-group" data-rel="tooltip" title="删除群组">
																		<span class="red">
																			<i class="ace-icon fa fa-trash-o bigger-110"></i>
																		</span>
																	</a>
																</li>
															</ul>
														</div>
													</div>
												</div>
											</div>
										</c:forEach>
									</div>
								</div>
								<!-- /section:pages/dashboard.conversations -->
							</div>
						</div><!-- /.widget-main -->
					</div><!-- /.widget-body -->
				</div><!-- /.widget-box -->
			</div><!-- /.col -->
			<div class="col-xs-9 container-group-right">
				<!-- PAGE CONTENT BEGINS -->
				<div class="widget-box">
					<div class="widget-header">
						<h4 class="widget-title lighter smaller">
							<i class="ace-icon fa fa-comment blue"></i>
							聊天窗口
						</h4>
					</div>

					<div class="widget-body">
						<div class="widget-main no-padding">
							<!-- #section:pages/dashboard.conversations -->
							<div class="dialogs">
								<div id="talk-tabs">
									<ul>
									</ul>
								</div>
								<!-- /section:pages/dashboard.conversations -->
								<div class="form-actions">
									<div class="input-group">
										<input placeholder="在这里输入消息 ..." type="text" autocomplete="off" class="form-control" name="message" id="message-input"/>
										<span class="input-group-btn">
											<button class="btn btn-sm btn-info no-radius" type="button" id="sendbtn">
												<i class="ace-icon fa fa-share"></i>
												发送
											</button>
										</span>
									</div>
								</div>
							</div>
						</div><!-- /.widget-main -->
					</div><!-- /.widget-body -->
				</div><!-- /.widget-box -->
			</div><!-- /.col -->
		</div><!-- /.row -->
	</div><!-- /.page-content-area -->
	<div id="edit-dialog" class="hide" style="height:100%;">
		<iframe class="" id="editgroup" frameborder="no" border="0" marginwidth="0" marginheight="0"></iframe>
	</div>
	<div id="invite-dialog" class="hide" style="height:100%;">
		<iframe class="" id="inviteusers" frameborder="no" border="0" marginwidth="0" marginheight="0"></iframe>
	</div>
	<div id="exit-group" class="hide">
		<div class="alert alert-info bigger-110">
			退出之后将无法接收该群组消息！
		</div>
	
		<div class="space-6"></div>
	
		<p class="bigger-110 bolder center grey">
			<i class="ace-icon fa fa-hand-o-right blue bigger-120"></i>
			您确认吗?
		</p>
	</div><!-- #dialog-confirm -->
	<script id="talk-li-template" type="text/html">
		<li id="li{{id}}">
			<a class="talk-label" href="{{id}}">{{nick}}</a>
			<i class="fa fa-close talk-close" windowid="{{id}}"></i>
		</li>
	</script>
	<script id="talk-msg-template" type="text/html">
		<div class="itemdiv dialogdiv">
			<div class="user">
				<img src="${adminFullPath}/attachment/readImageStreamId?id={{headPic}}" onerror="this.src='${contextPath}/static/common/img/profile-pic.jpg'"/>
			</div>
		
			<div class="body">
				<div class="time">
					<i class="ace-icon fa fa-clock-o"></i>
					<span class="green">{{createDate}}</span>
				</div>
		
				<div class="name">
					<a href="#">{{nick}}</a>
				</div>
				<div class="text">{{msg}}</div>
			</div>
		</div>
	</script>
	<script type="text/javascript">
		var talkUsers=[],currentUserId='${elfn:getCurrentUser().id}';
		$(function(){
			var msgs;
			if(!!(msgs=eval('${elfn:toJSON(messages)}'))){
				for(var i=0;i<msgs.length;i++){
					receiveMsg(msgs[i]);
				}
			}
			var tabs = $( "#tabs" ).tabs(),talktabs = $( "#talk-tabs" ).tabs();
			$('.open-send',tabs).on('click',function(){
				addTalkPanel(talktabs,{
					id:$(this).attr('windowid'),
					nick:$(this).attr('nick')
				},$(this).attr('type'));
				return false;
			});
			$('#sendbtn').on('click',function(){
				var intput = $('#message-input'),currentTab=$('.msg-content:visible',talktabs);
				sendMsg(currentTab,{
					nick:'${elfn:getCurrentUser().nick}',
					headPic:'${elfn:getCurrentUser().headPic}',
					msg:intput.val(),
					createDate:new Date().format('yyyy-MM-dd hh:mm:ss')
				});
				sendMsgToServer(currentTab.attr('receiveIds'),intput.val(),currentTab.attr('type'));
				intput.val('');
			});
			$(document).bind('keydown',function(e){
  	 			if(e.keyCode === 13){
  	 				$('#sendbtn').trigger('click');
  	 			}
  	 		});
			$('body').on( "click",'i.talk-close', function() {
				var userId = $(this).attr('windowid').replace('#','');
				$('li[id="li#'+userId+'"]',talktabs).remove();
				$('.msg-content[id="'+userId+'"]',talktabs).remove();
				talktabs.tabs( "refresh" ).tabs({ active : $('ul:first li',talktabs).size()-1 });
				talkUsers.remove(userId);
		    });
			$('#msg-content li').each(function(){
				var self = this;
				receiveMsg({
					id:self.attr('senderId'),
					msg:self.attr('msg'),
					createDate:self.attr('createDate')
				});
			});
			$('#create-group,.update-group').on('click',function(){
				editGroup($(this).attr('groupid'));
			});
			$('.delete-group').on('click',function(){
				var self = $(this);
				platform.showDeleteDialog({
					beforDeleteHandler:function(dialog){
						window.location="${adminFullPath}/message/deleteGroup?id="+self.attr('groupid');
					}
				});
			});
			$('div.message-group').on('click',function(event){
				$('.open-send',$(this)).trigger('click');
			});
		});
		//增加聊天窗口
		function addTalkPanel(tab,talkUser,talkType){
			if(talkUsers.indexOf(talkUser.id)==-1){
				talkUsers.push(talkUser.id);
				var tabs = tab.append('<div id="'+talkUser.id+'" receiveIds="'+talkUser.id+'" class="msg-content" type="'+talkType+'"><div class="msg-queue"></div></div>');
				//如果是群组聊天则显示群组成员
				if('${constants.TALK_TYPE_GROUP}'===talkType)showGroupUsers(tab,talkUser.id);
				talkUser.id='#'+talkUser.id;
				$('ul',tabs).append(template('talk-li-template',talkUser));
				tab.tabs( "refresh" ).tabs({ active : $('li'+talkUser.id,tab).index() });
			}
		}
		//展示群组成员
		function showGroupUsers(tab,talkWindowId){
			var $window = $('#'+talkWindowId);
			$window.attr('groupId',talkWindowId).find('.msg-queue').addClass('col-xs-9');
			$window.append('<div id="gu'+talkWindowId+'" class="col-xs-3 group-user"></div><div class="clearfix"></div>');
			$.ajax({
			   type: "POST",
			   url: "${adminFullPath}/message/groupusers",
			   data: "group.id="+talkWindowId,
			   success: function(groupusers){
				   var groupuserhtml=[],reveiveIds=[],groupId;
				   for(var i=0;i<groupusers.length;i++){
					   groupId = groupusers[i].group.id;
					   if(currentUserId!==groupusers[i].user.id){
						   groupuserhtml.push('<div class="user-div"><img src="${adminFullPath}/attachment/readImageStreamId?id='+groupusers[i].user.headPic+'" onerror="this.src=\'${contextPath}/static/common/img/profile-pic.jpg\'"/>'+groupusers[i].user.nick+'</div>');
						   reveiveIds.push(groupusers[i].user.id);
					   }
				   }
				   $('#gu'+talkWindowId).html('<button onClick="javascript:inviteUsers(\''+groupId+'\')" class="btn btn-app btn-info btn-xs"><i class="ace-icon fa fa-users bigger-100"></i>邀请</button><button onClick="javascript:exitGroup(\''+groupId+'\')" class="btn btn-app btn-danger btn-xs"><i class="ace-icon fa fa-frown-o bigger-100"></i>退出</button>'+groupuserhtml.join(''));
				   $window.attr('receiveIds',reveiveIds.join(','));
			   }
			});
		}
		//在聊天窗口中绘制聊天信息
		function sendMsg(currentTab,msg){
			var queue = $('.msg-queue',currentTab);
			if(!!msg&&currentTab.length>0){
				queue.append(template('talk-msg-template',msg));
				queue.scrollTop( currentTab[0].scrollHeight );
			}
		}
		//将聊天信息发送服务端
		function sendMsgToServer(receiverId,msg,msgType){
			var param = {
					sender:{id:currentUserId},
					receiver:{id:receiverId},
					msgType:msgType,
					msg:msg
				};
			if(msgType==='${constants.TALK_TYPE_GROUP}')param.groupId=$('.msg-content:visible').attr('groupId');
			top.websocket.send(JSON.stringify(param));
		}
		//接受聊天信息并显示
		function receiveMsg(msg){
			var windowId = '${constants.TALK_TYPE_GROUP}'!==msg.msgType?msg.sender.id:msg.groupId;
			var a = $('a[windowid="'+windowId+'"]'),talktabs = $( "#talk-tabs" ),
				date = new Date();
			if($('li[id="li#'+windowId+'"]',talktabs).size()<=0){
				addTalkPanel(talktabs,{
					id:windowId,
					nick:a.attr('nick')
				},msg.msgType);
			}
			date = typeof msg.createDate==='object'?new Date(msg.createDate.time):date;
			sendMsg($('.msg-content[id="'+windowId+'"]'),{
				nick:msg.sender.nick,
				headPic:msg.sender.headPic,
				msg:msg.msg,
				createDate:date.format('yyyy-MM-dd hh:mm:ss')
			});
			$.ajax({
			   type: "POST",
			   url: "${adminFullPath}/message/update",
			   data: "id="+msg.id,
			   success: function(msg){
			   }
			});
		}
		//编辑群组
		function editGroup(id){
			platform.showContentDialog({
				title:'新建群组',
				content:'#edit-dialog',
				selectedHandler:function(dialog){
					if(!document.getElementById("editgroup").contentWindow.validForm.form())
						return false;
					document.getElementById("editgroup").contentWindow.beforeSubmit();
					$('#editgroup').contents().find("#groupform").submit();
				},
				cancleHandler:function(dialog){
				},
				option:{
					width:820,
					height:600,
					open: function( event, ui ) {
						$('#editgroup').attr('src','${adminFullPath}/unlayout/editGroup?id='+(id||''));
					}
				}
			});
		}
		//邀请成员
		function inviteUsers(id){
			platform.showContentDialog({
				title:'邀请成员',
				content:'#invite-dialog',
				selectedHandler:function(dialog){
					if(!document.getElementById("inviteusers").contentWindow.beforeSubmit())
						return false;
					$('#inviteusers').contents().find("#inviteform").submit();
				},
				cancleHandler:function(dialog){
				},
				option:{
					width:720,
					height:370,
					open: function( event, ui ) {
						$('#inviteusers').attr('src','${adminFullPath}/unlayout/inviteUsers?id='+(id||''));
					}
				}
			});
		}
		//退出群组
		function exitGroup(id){
			platform.showContentDialog({
				title:'退出群组提示',
				content:'#exit-group',
				selectedHandler:function(dialog){
					window.location="${adminFullPath}/message/exitGroup?id="+(id||'');
				},
				cancleHandler:function(dialog){
				}
			});
		}
	</script>
</body>
</html>