<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="zh-cn">
<head>
<title><sitemesh:write property='title'></sitemesh:write></title>
	<%@include file="/WEB-INF/include/header-import.jsp"%>
	<%@include file="/WEB-INF/include/foot-import.jsp"%>
	<script src="${contextPath}/static/common/js/lib.ui.menu.js"></script>
	<script src="${contextPath}/static/common/js/top.js"></script>
	<sitemesh:write property='head'/>
</head>
<body class='<sitemesh:write property="body.class"/> no-skin'>
	<div class="navbar navbar-default" id="navbar">
		<script type="text/javascript">
			try{ace.settings.check('navbar' , 'fixed')}catch(e){}
		</script>

		<div class="navbar-container container" id="navbar-container">
			<!-- #section:basics/sidebar.mobile.toggle -->
			<div class="navbar-header pull-left">
				<!-- #section:basics/navbar.layout.brand -->
				<a href="#" class="navbar-brand">
					<small>
						<i class="fa fa-leaf"></i>
						Ace Admin
					</small>
				</a>

				<!-- /section:basics/navbar.layout.brand -->

				<!-- #section:basics/navbar.toggle -->

				<!-- /section:basics/navbar.toggle -->
			</div>
			<div class="navbar-header" role="navigation">
	          <ul class="nav navbar-nav">
	            <li class="dropdown">
	              <a href="javascript:void(0)" class="dropdown-toggle" data-toggle="dropdown">Bootstrap3中文文档<b class="caret"></b></a>
	              <ul class="dropdown-menu">
	                <li>
	                  <a href="http://v3.bootcss.com/getting-started/" target="_blank">起步</a>
	                </li>
	                <li>
	                  <a href="http://v3.bootcss.com/css/" target="_blank">CSS</a>
	                </li>
	                <li>
	                  <a href="http://v3.bootcss.com/components/" target="_blank">组件</a>
	                </li>
	                <li>
	                  <a href="http://v3.bootcss.com/javascript/" target="_blank">JavaScript插件</a>
	                </li>
	                <li>
	                  <a href="http://v3.bootcss.com/customize/" target="_blank">定制</a>
	                </li>
	              </ul>
	            </li>
	            <li><a id="btn-jike-video" href="http://www.jikexueyuan.com/event/bootstrap.html?hmsr=bootstrap_guide_bsevent_03.06" target="_blank" onclick="_hmt.push(['_trackEvent', 'navbar', 'click', 'Bootstrap视频教程'])">Bootstrap视频教程</a></li>
	            <li><a href="/p/lesscss/" target="_blank" onclick="_hmt.push(['_trackEvent', 'navbar', 'click', 'less'])">Less 教程</a></li>
	            <li><a href="http://jquery.bootcss.com/" target="_blank" onclick="_hmt.push(['_trackEvent', 'navbar', 'click', 'jquery'])">jQuery API</a></li>
	          </ul>
	        </div>
			<div class="navbar-buttons navbar-header pull-right" role="navigation">
				<ul class="nav ace-nav">
					<li class="grey city-container">
						<a data-toggle="dropdown" class="dropdown-toggle" href="#">
							<i class="ace-icon fa fa-map-marker"></i>
							<span class="badge badge-transparent" id="marker"></span>
							<i class="ace-icon fa fa-caret-down"></i>
						</a>
						<tags:area id="changecity" name="changecity" lableId="marker" level="2" showHot="false" selected="afterSelected" load="loadCity" value="${cookie.cityId.value}"></tags:area>
					</li>
					<c:choose>
						<c:when test="${not empty elfn:getCurrentUser()}">
						<li class="purple">
							<a data-toggle="dropdown" class="dropdown-toggle" href="#">
								<i class="ace-icon fa fa-bell icon-animated-bell"></i>
								<span class="badge badge-important">8</span>
							</a>
	
							<ul class="dropdown-menu-right dropdown-navbar navbar-pink dropdown-menu dropdown-caret dropdown-close">
								<li class="dropdown-header">
									<i class="ace-icon fa fa-exclamation-triangle"></i>
									8条通知
								</li>
	
								<li>
									<a href="#">
										<div class="clearfix">
											<span class="pull-left">
												<i class="btn btn-xs no-hover btn-pink fa fa-comment"></i>
												新闻评论
											</span>
											<span class="pull-right badge badge-info">+12</span>
										</div>
									</a>
								</li>
	
								<li>
									<a href="#">
										<i class="btn btn-xs btn-primary fa fa-user"></i>
										切换为编辑登录..
									</a>
								</li>
	
								<li>
									<a href="#">
										<div class="clearfix">
											<span class="pull-left">
												<i class="btn btn-xs no-hover btn-success fa fa-shopping-cart"></i>
												新订单
											</span>
											<span class="pull-right badge badge-success">+8</span>
										</div>
									</a>
								</li>
	
								<li>
									<a href="#">
										<div class="clearfix">
											<span class="pull-left">
												<i class="btn btn-xs no-hover btn-info fa fa-twitter"></i>
												粉丝
											</span>
											<span class="pull-right badge badge-info">+11</span>
										</div>
									</a>
								</li>
	
								<li class="dropdown-footer">
									<a href="#">
										查看所有通知
										<i class="ace-icon fa fa-arrow-right"></i>
									</a>
								</li>
							</ul>
						</li>
	
						<li class="green">
							<a data-toggle="dropdown" class="dropdown-toggle" href="#">
								<i class="ace-icon fa fa-envelope icon-animated-vertical"></i>
								<span class="badge badge-success">5</span>
							</a>
	
							<ul class="dropdown-menu-right dropdown-navbar dropdown-menu dropdown-caret dropdown-close">
								<li class="dropdown-header">
									<i class="ace-icon fa fa-envelope-o"></i>
									5条消息
								</li>
	
								<li class="dropdown-content">
									<a href="#">
										<img src="" class="msg-photo" alt="Alex's Avatar" />
										<span class="msg-body">
											<span class="msg-title">
												<span class="blue">Alex:</span>
												不知道写啥 ...
											</span>
	
											<span class="msg-time">
												<i class="ace-icon fa fa-clock-o"></i>
												<span>1分钟以前</span>
											</span>
										</span>
									</a>
								</li>
	
								<li>
									<a href="#">
										<img src="" class="msg-photo" alt="Susan's Avatar" />
										<span class="msg-body">
											<span class="msg-title">
												<span class="blue">Susan:</span>
												不知道翻译...
											</span>
	
											<span class="msg-time">
												<i class="ace-icon fa fa-clock-o"></i>
												<span>20分钟以前</span>
											</span>
										</span>
									</a>
								</li>
	
								<li>
									<a href="#">
										<img src="" class="msg-photo" alt="Bob's Avatar" />
										<span class="msg-body">
											<span class="msg-title">
												<span class="blue">Bob:</span>
												到底是不是英文 ...
											</span>
	
											<span class="msg-time">
												<i class="ace-icon fa fa-clock-o"></i>
												<span>下午3:15</span>
											</span>
										</span>
									</a>
								</li>
	
								<li class="dropdown-footer">
									<a href="inbox.html">
										查看所有消息
										<i class="ace-icon fa fa-arrow-right"></i>
									</a>
								</li>
							</ul>
						</li>
	
						<li class="light-blue">
							<a data-toggle="dropdown" href="#" class="dropdown-toggle">
								<img class="nav-user-photo" src="" alt="Jason's Photo" 
								onerror="this.src='${contextPath}/static/common/img/profile-pic.jpg'" />
								<span class="user-info">
									<small>欢迎光临,</small>
									${elfn:getCurrentUser().realName}
								</span>
	
								<i class="ace-icon fa fa-caret-down"></i>
							</a>
	
							<ul class="user-menu dropdown-menu-right dropdown-menu dropdown-yellow dropdown-caret dropdown-close">
								<li>
									<a href="#">
										<i class="ace-icon fa fa-cog"></i>
										设置
									</a>
								</li>
								<shiro:hasPermission name="user:info">
								<li>
									<a href="#">
										<i class="ace-icon fa fa-user"></i>
										个人资料
									</a>
								</li>
								</shiro:hasPermission>
								<li class="divider"></li>
	
								<li>
									<a href="#">
										<i class="ace-icon fa fa-power-off"></i>
										退出
									</a>
								</li>
							</ul>
						</li>
						</c:when>
						<c:otherwise>
							<li class="light-blue">
								<a href="${adminFullPath}/">
									<i class="ace-icon fa fa-user"></i>
									<span class="badge badge-transparent">登陆</span>
								</a>
							</li>
							<li class="light-blue">
								<a href="${adminFullPath}/#signup-box">
									<i class="ace-icon fa fa-key"></i>
									<span class="badge badge-transparent">注册</span>
								</a>
							</li>
						</c:otherwise>
					</c:choose>
				</ul><!-- /.ace-nav -->
			</div><!-- /.navbar-header -->
		</div><!-- /.container -->
	</div>
	<div class="navbar navbar-default" id="navbar-header">
		<script type="text/javascript">
			try{ace.settings.check('navbar-header' , 'fixed')}catch(e){}
		</script>

		<div class="navbar-container container" id="navbar-container">
			<jsp:include page="/WEB-INF/include/headerpic.jsp"></jsp:include>
		</div><!-- /.container -->
	</div>
	<div class="main-container container" id="main-container">
		<script type="text/javascript">
			try{ace.settings.check('main-container' , 'fixed')}catch(e){}
		</script>

		<div class="main-content">
			<div class="page-content">
				<sitemesh:write property='body'></sitemesh:write>
			</div>
		</div><!-- /.main-content -->
		<jsp:include page="/WEB-INF/include/common.jsp"></jsp:include>
	</div><!-- /.main-container -->
	<div class="footer">
		<div class="footer-inner">
			<!-- #section:basics/footer -->
			<div class="footer-content">
				<div class="container">
				    <p>Designed and built with all the love in the world by <a href="https://twitter.com/mdo" target="_blank">@mdo</a> and <a href="https://twitter.com/fat" target="_blank">@fat</a>.</p>
				    <p>Maintained by the <a href="https://github.com/orgs/twbs/people">core team</a> with the help of <a href="https://github.com/twbs/bootstrap/graphs/contributors">our contributors</a>.</p>
				    <p>本项目源码受 <a rel="license" href="https://github.com/twbs/bootstrap/blob/master/LICENSE" target="_blank">MIT</a>开源协议保护，文档受 <a rel="license" href="https://creativecommons.org/licenses/by/3.0/" target="_blank">CC BY 3.0</a> 开源协议保护。</p>
	  			</div>
			</div>

			<!-- /section:basics/footer -->
		</div>
	</div><!-- footer -->
	<script type="text/javascript">
		$(function(){
		});
		function loadCity(flag){
			if(eval(flag))
				$.ajax({
				   type: "POST",
				   url: "${siteFullPath}/cuurentSite",
				   success: function(area){
					   setCookie('cityId',area.id,'h'+1);
					   $('#marker').text(area.name);
					   $('#changecity').val(area.id);
				   }
				});
		}
		function afterSelected(id,names){
			setCookie('cityId',id,'h'+1);
		}
	</script>
</body>
</html>