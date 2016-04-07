<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<tags:header inplugins="${plugins.jqui},${plugins.template}" title="新闻评论信息"></tags:header>
<style type="text/css">.itemdiv .itemdiv{margin-left:42px;}</style>
</head>
<body>
		<div class="page-content-area">
		<div class="page-header">
			<h1>
				新闻
				<small>
					<i class="ace-icon fa fa-angle-double-right"></i>
					 评论信息
				</small>
			</h1>
		</div><!-- /.page-header -->
	
		<div class="row">
			<div class="col-xs-12">
				<!-- PAGE CONTENT BEGINS -->
					<div class="widget-box transparent" id="recent-box">
						<div class="widget-header">
							<h4 class="lighter smaller">
								<i class="icon-rss orange"></i>
								${news.title}
							</h4>

							<div class="widget-toolbar no-border">
								<ul class="nav nav-tabs" id="recent-tab">
									<li class="active">
										<a data-toggle="tab" href="#comment-tab">评论</a>
									</li>

									<li>
										<a data-toggle="tab" href="#member-tab">会员</a>
									</li>
								</ul>
							</div>
						</div>

						<div class="widget-body">
							<div class="widget-main padding-4">
								<div class="tab-content padding-8 overflow-visible">
									<div id="comment-tab" class="tab-pane active">
										<div class="comments">
											
										</div>

										<div class="hr hr8"></div>

										<div class="center">
											<i class="icon-comments-alt icon-2x green"></i>

											&nbsp;
											<a href="#">
												See all comments &nbsp;
												<i class="icon-arrow-right"></i>
											</a>
										</div>

										<div class="hr hr-double hr8"></div>
									</div>
									<div id="member-tab" class="tab-pane">
										<div class="clearfix">
											<div class="itemdiv memberdiv">
												<div class="user">
													<img alt="Bob Doe's avatar" src="assets/avatars/user.jpg" />
												</div>

												<div class="body">
													<div class="name">
														<a href="#">Bob Doe</a>
													</div>

													<div class="time">
														<i class="icon-time"></i>
														<span class="green">20 min</span>
													</div>

													<div>
														<span class="label label-warning label-sm">pending</span>

														<div class="inline position-relative">
															<button class="btn btn-minier bigger btn-yellow btn-no-border dropdown-toggle" data-toggle="dropdown">
																<i class="icon-angle-down icon-only bigger-120"></i>
															</button>

															<ul class="dropdown-menu dropdown-only-icon dropdown-yellow pull-right dropdown-caret dropdown-close">
																<li>
																	<a href="#" class="tooltip-success" data-rel="tooltip" title="Approve">
																		<span class="green">
																			<i class="icon-ok bigger-110"></i>
																		</span>
																	</a>
																</li>

																<li>
																	<a href="#" class="tooltip-warning" data-rel="tooltip" title="Reject">
																		<span class="orange">
																			<i class="icon-remove bigger-110"></i>
																		</span>
																	</a>
																</li>

																<li>
																	<a href="#" class="tooltip-error" data-rel="tooltip" title="Delete">
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
										</div>

										<div class="center">
											<i class="icon-group icon-2x green"></i>

											&nbsp;
											<a href="#">
												查看所有会员 &nbsp;
												<i class="icon-arrow-right"></i>
											</a>
										</div>

										<div class="hr hr-double hr8"></div>
									</div><!-- member-tab -->
								</div>
							</div><!-- /widget-main -->
						</div><!-- /widget-body -->
					</div><!-- /widget-box -->
				<!-- PAGE CONTENT ENDS -->
			</div><!-- /.col -->
		</div><!-- /.row -->
	</div><!-- /.page-content-area -->
	<script id="comment" type="text/html">
	{{if user}}
    	<div class="itemdiv commentdiv">
			<div class="user">
				<img alt="{{user.nick}}" src="${adminFullPath}/attachment/readImageStreamId?id={{user.headPic}}" 
				onerror="this.src='${contextPath}/static/common/img/profile-pic.jpg'" />
			</div>
		
			<div class="body">
				<div class="name">
					<a href="#">{{user.nick}}</a>
				</div>
		
				<div class="time">
					<i class="icon-time"></i>
					<span class="green">{{createDate}}</span>
				</div>
		
				<div class="text">
					<i class="icon-quote-left"></i>
					{{content}}
				</div>
			</div>
		
			<div class="tools">
				<div class="inline position-relative">
					<button class="btn btn-minier bigger btn-yellow dropdown-toggle" data-toggle="dropdown">
						<i class="icon-angle-down icon-only bigger-120"></i>
					</button>
		
					<ul class="dropdown-menu dropdown-only-icon dropdown-yellow pull-right dropdown-caret dropdown-close">
						<li>
							<a href="#" class="tooltip-success" data-rel="tooltip" title="Approve">
								<span class="green">
									<i class="icon-ok bigger-110"></i>
								</span>
							</a>
						</li>
		
						<li>
							<a href="#" class="tooltip-warning" data-rel="tooltip" title="Reject">
								<span class="orange">
									<i class="icon-remove bigger-110"></i>
								</span>
							</a>
						</li>
		
						<li>
							<a href="#" class="tooltip-error" data-rel="tooltip" title="Delete">
								<span class="red">
									<i class="ace-icon fa fa-trash-o bigger-110"></i>
								</span>
							</a>
						</li>
					</ul>
				</div>
			</div>
		</div>
	{{/if}}
	</script>
	<script type="text/javascript">
		var commentArray = [],idArray=[],pid,ids,eachCommentArray = [],eachItemObj = [],eachComment,rootId="0";
		function getChildPids(parentId){
			var reg = new RegExp(parentId+"[_][a-zA-Z0-9]*","g");
			return ids.match(reg);
		}
		function loadComment(childCommentIds,parentComment){
			if(!!!parentComment){
				parentComment = $('.comments');
				childCommentIds = getChildPids(rootId);
			}
			var currentItem,currentObj;
			for(var index in childCommentIds){
				currentItem = eachCommentArray[childCommentIds[index]];
				currentObj = eachItemObj[childCommentIds[index]];
				parentComment.append(currentItem);
				var childIds = getChildPids(currentObj.id);
				if($.isArray(childIds) && childIds.length > 0)
					loadComment(childIds,currentItem);
			}
		}
		<c:forEach items="${news.commentList}" var="comment">
			eachComment = eval('(${elfn:toJSON(comment)})');
			eachComment.createDate = new Date(eachComment.createDate.time).format('yyyy-MM-dd hh:mm:ss');
			eachComment.updateDate = new Date(eachComment.updateDate.time).format('yyyy-MM-dd hh:mm:ss');
			pid = eachComment.parentId+'_'+eachComment.id;
			eachCommentArray[pid] = $(template('comment', eachComment));
			eachItemObj[pid] = eachComment;
			idArray.push(pid);
		</c:forEach>
		ids = idArray.join(',');
		loadComment();
	</script>
</body>
</html>