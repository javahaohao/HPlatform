<%@  page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include/taglib.jsp"%>
<html>
<head>
    <tags:header inplugins="${plugins.jqui},${plugins.template}" title="JavaHao"></tags:header>
	<script src="${contextPath}/static/websocket/sockjs.min.js" type="text/javascript"></script>
    <style type="text/css">
    	body{padding:0px;margin:0px;}#navbar{display:none;}
    </style>
</head>
<body>
	<div id="navbar" class="navbar navbar-default"></div>
	<iframe id="content" src="" frameborder="no"  border="0"  marginwidth="0"  marginheight="0"></iframe>
	<script id="msg-item" type="text/html">
		<li senderid="{{sender.id}}" groupid="{{if ${constants.TALK_TYPE_GROUP}==msgType}}{{group.id}}{{/if}}" msgtype="{{msgType}}" msg="{{msg}}" createDate="{{createDate | dateFormat:'yyyy-MM-dd hh:mm:ss'}}">
			<a href="#">
				<img src="${adminFullPath}/attachment/readImageStreamId?id={{if ${constants.TALK_TYPE_USER}==msgType}}{{sender.headPic}}{{else}}{{group.pic}}{{/if}}" onerror="this.src='${contextPath}/static/common/img/profile-pic.jpg'" class="msg-photo"/>
				<span class="msg-body">
					<span class="msg-title">
						<span class="blue">
							{{if ${constants.TALK_TYPE_USER}==msgType}}
								{{sender.nick}}
							{{else}}
    							{{group.group}}
							{{/if}}
						:</span>
						<span class="short-msg">{{msg}}</span>
						<span class="pull-right badge badge-info">+<span class="msg-num">1</span></span>
					</span>

					<span class="msg-time">
						<i class="ace-icon fa fa-clock-o"></i>
						<span>{{createDate | dateFormat:'yyyy-MM-dd hh:mm:ss'}}</span>
					</span>
				</span>
			</a>
		</li>
	</script>
	<script type="text/javascript">
		<c:if test="${!empty elfn:getCurrentUser()}">
		var websocket;
		var frame = document.getElementById('content');
		frame.onload = frame.onreadystatechange = function() {
			if ('WebSocket' in window) {
		        websocket = new WebSocket("ws://"+window.location.host+"${adminFullPath}/webSocketServer");
		    } else if ('MozWebSocket' in window) {
		        websocket = new MozWebSocket("ws://"+window.location.host+"${adminFullPath}/webSocketServer");
		    } else {
		        websocket = new SockJS("${adminFullPath}/sockjs/webSocketServer");
		    }
		    websocket.onopen = function (evnt) {
		    };
		    websocket.onmessage = function (evnt) {
		    	var data = $.parseJSON(evnt.data);
		    	//如果是聊天信息
		    	if(data.event==="${constants.EVENT_TALK}"
		    			&&!!document.getElementById("content").contentWindow.receiveMsg
		    			&&data.msgs.length<=0){
	   				document.getElementById("content").contentWindow.receiveMsg(data);
		    	}else if(data.event==="${constants.EVENT_TALK}"){
		    		appendNoReadMsg(data);
		    	}
		    };
		    websocket.onerror = function (evnt) {
		    };
		    websocket.onclose = function (evnt) {
		    }
		}
	    </c:if>
	    $(function(){
	    	var url=platform.getCookieUrl();
	   		document.getElementById("content").src=!!url?url:"${adminFullPath}/welcome";
	    });
	    //增加未读消息
	    function appendNoReadMsg(data){
	    	var msgcount=0;
	    	if(!!!data.msgs||data.msgs<=0)
	    		addMsg(data);
	    	else
		    	for(var i=0;i<data.msgs.length;i++)
		    		addMsg(data.msgs[i]);
	    	$('#content').contents().find('#msg-content li').each(function(){
	    		msgcount+=parseInt($(this).find('.msg-num').text());
	    	});
	    	$('#content').contents().find('.msg-count').text(msgcount);
	    }
	    function addMsg(msg){
    		var msgli = '${constants.TALK_TYPE_USER}'===msg.msgType?$('#content').contents().find('li[senderid="'+msg.sender.id+'"][msgtype="'+msg.msgType+'"]'):$('#content').contents().find('li[groupid="'+msg.group.id+'"][msgtype="'+msg.msgType+'"]');
    		if(msgli.size()>0){
    			$('.short-msg',msgli).text(msg.msg);
    			$('.msg-num',msgli).text(parseInt($('.msg-num',msgli).text())+1);
    			$('.msg-time span',msgli).text(new Date(msg.createDate.time).format('yyyy-MM-dd hh:mm:ss'));
    		}else{
    			$('#content').contents().find('#msg-content').append(template('msg-item',msg));
    		}
	    }
	</script>
</body>
</html>