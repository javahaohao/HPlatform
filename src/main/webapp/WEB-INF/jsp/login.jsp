<%@page import="com.hplatform.core.common.util.ConstantsUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include/taglib.jsp"%>
<html>
<head>
    <tags:header inplugins="${plugins.jqui},${plugins.validate},${plugins.jbox},${plugins.datetime}" title="登录"></tags:header>
    <style>.error{color:red;}</style>
</head>
<body class="login-layout">
	<div class="main-container">
		<div class="main-content">
			<div class="row">
				<div class="col-sm-10 col-sm-offset-1">
					<div class="login-container">
						<div class="center">
							<h1>
								<i class="icon-leaf green"></i>
								<span class="red">Ace</span>
								<span class="white">Application</span>
							</h1>
							<h4 class="blue">&copy; Company Name</h4>
						</div>

						<div class="space-6"></div>

						<div class="position-relative">
							<div id="login-box" class="login-box visible widget-box no-border">
								<div class="widget-body">
									<div class="widget-main">
										<h4 class="header blue lighter bigger">
											<i class="icon-coffee green"></i>
											Please Enter Your Information
										</h4>
										<c:if test="${not empty msg}">
										<div class="alert alert-danger">
											<button type="button" class="close" data-dismiss="alert">
												<i class="icon-remove"></i>
											</button>

											<strong>
												<i class="icon-remove"></i>
												对不起!
											</strong>
												${msg}
												<c:if test="${not empty accLoginCount}">
													<br>您还有${accLoginCount}次重试机会,或者进行找回密码！
												</c:if>
												<c:if test="${showActivation}">
													,<a href="javascript:showStep(5)">激活</a>！
												</c:if>
											<br />
										</div>
										</c:if>
										<div class="space-6"></div>

										
										<form action="" method="post"  id="subForm">
											<fieldset>
												<label class="block clearfix">
													<span class="block input-icon input-icon-right">
														<input type="text" class="form-control required" placeholder="用户名/邮箱/手机号" name="username" value="<shiro:principal/>"/>
														<i class="icon-user"></i>
													</span>
												</label>

												<label class="block clearfix">
													<span class="block input-icon input-icon-right">
														<input type="password" class="form-control required" placeholder="密码" name="password"/>
														<i class="ace-icon fa fa-lock"></i>
													</span>
												</label>
												
												<label class="block clearfix">
													<span class="block input-icon input-icon-right">
														<input id="captcha" type="text" class="input-small required" placeholder="验证码" name="captcha" size="4" maxlength="4"/>
														<img title="点击更换" id="img_captcha" onclick="javascript:refreshCaptcha();" src="${contextPath}/servlet/captchaCode">
														(看不清<a href="javascript:void(0)" onclick="javascript:refreshCaptcha()">换一张</a>)
													</span>
												</label>

												<div class="space"></div>

												<div class="clearfix">
													<label class="inline">
														<input type="checkbox" class="ace" name="rememberMe"/>
														<span class="lbl">记住密码</span>
													</label>
													<button id="submit" type="submit" class="width-35 pull-right btn btn-sm btn-primary">
														<i class="icon-key"></i>
														登陆
													</button>
												</div>

												<div class="space-4"></div>
											</fieldset>
										</form>

										<div class="social-or-login center">
											<span class="bigger-110">Or Login Using</span>
										</div>

										<div class="space-6"></div>

										<div class="social-login center">
											<a class="btn btn-primary">
												<i class="ace-icon fa fa-facebook"></i>
											</a>

											<a class="btn btn-info">
												<i class="ace-icon fa fa-twitter"></i>
											</a>

											<a class="btn btn-danger">
												<i class="ace-icon fa fa-google-plus"></i>
											</a>
										</div>
									</div><!-- /widget-main -->

									<div class="toolbar clearfix">
										<div>
											<a href="#" data-target="#forgot-box" class="forgot-password-link">
												<i class="icon-arrow-left"></i>
												忘记密码
											</a>
										</div>

										<div>
											<a href="#" data-target="#signup-box" class="user-signup-link">
												注册
												<i class="ace-icon fa fa-arrow-right"></i>
											</a>
										</div>
									</div>
								</div><!-- /widget-body -->
							</div><!-- /login-box -->

							<div id="forgot-box" class="forgot-box widget-box no-border">
								<div class="widget-body">
									<div class="widget-main">
										<h4 class="header red lighter bigger">
											<i class="icon-key"></i>
											重置密码
										</h4>

										<div class="space-6"></div>
										<p>
											请输入您注册账号时的邮箱,进行密码重置操作！
										</p>

										<form id="restPwdForm" class="form-horizontal">
											<fieldset>
												<div class="form-group">
										            <div class="col-xs-12 col-sm-12">
														<span class="block input-icon input-icon-right">
															<input type="email" id="restPwdEmail" name="restPwdEmail" class="width-100" placeholder="Email" />
															<i class="icon-envelope"></i>
														</span>
													</div>
										        </div>
												<div class="clearfix">
													<button id="restBtn" type="button" class="width-35 pull-right btn btn-sm btn-danger">
														<i class="icon-lightbulb"></i>
														发送
													</button>
												</div>
											</fieldset>
										</form>
									</div><!-- /widget-main -->

									<div class="toolbar center">
										<a href="#" data-target="#login-box" class="back-to-login-link">
											返回
											<i class="icon-arrow-right"></i>
										</a>
									</div>
								</div><!-- /widget-body -->
							</div><!-- /forgot-box -->
						</div><!-- /position-relative -->
					</div><!-- /login-container -->
					<!-- signup-box -->
					<div class="signup-box widget-box no-border" id="signup-box">
						<div class="widget-header widget-header-blue widget-header-flat">
							<h4 class="lighter">用户注册</h4>
						</div>

						<div class="widget-body">
							<div class="widget-main">
								<div id="fuelux-wizard" class="row-fluid" data-target="#step-container">
									<ul class="wizard-steps">
										<li data-target="#step1" class="active">
											<span class="step">1</span>
											<span class="title">身份选择</span>
										</li>
										<li data-target="#step2">
											<span class="step">2</span>
											<span class="title">账户信息</span>
										</li>

										<li data-target="#step3">
											<span class="step">3</span>
											<span class="title">用户信息</span>
										</li>

										<li data-target="#step4">
											<span class="step">4</span>
											<span class="title">注册协议</span>
										</li>

										<li data-target="#step5">
											<span class="step">5</span>
											<span class="title">信息核实</span>
										</li>
									</ul>
								</div>

								<hr />
								<div class="step-content row-fluid position-relative" id="step-container">
									<div class="step-pane active" id="step1">
										<div class="row">
											<div class="col-md-4"></div>
											<div class="col-md-2">
												<a href="#" roleId="<%=ConstantsUtil.get().ROLE_REGISTER_TEACHER_ID%>" class="btn btn-app btn-primary no-radius">
													<i class="icon-group bigger-230"></i>
													我要当老师
												</a>
											</div>
											<div class="col-md-2">
												<a href="#" roleId="<%=ConstantsUtil.get().ROLE_REGISTER_STUDENT_ID%>" class="btn btn-app btn-primary no-radius">
													<i class="icon-book bigger-230"></i>
													我要找家教
												</a>
											</div>
											<div class="col-md-4"></div>
										</div>
									</div>
									<form class="form-horizontal" id="baseInfoForm">
									<input type="hidden" name="roleIdsStr" id="roleIdsStr">
									<div class="step-pane" id="step2">
										<h3 class="lighter green"><i class="icon-hand-right icon-animated-hand-pointer blue"></i>账户基本信息</h3>

										<div class="form-group">
											<label for="nick" class="col-xs-12 col-sm-3 control-label no-padding-right">昵称</label>
											<div class="col-xs-12 col-sm-5">
												<span class="block input-icon input-icon-right">
													<input id="nick" name="nick" type="text" class="width-100" maxlength="50"/>
													<i class="ace-icon fa fa-info-circle"></i>
												</span>
											</div>
										</div>

										<div class="form-group">
											<label for="username" class="col-xs-12 col-sm-3 col-md-3 control-label no-padding-right">账户</label>
											<div class="col-xs-12 col-sm-5">
												<span class="block input-icon input-icon-right">
													<input id="username" name="username" type="text" class="width-100"/>
													<i class="ace-icon fa fa-info-circle"></i>
												</span>
											</div>
										</div>

										<div class="form-group">
											<label for="password" class="col-xs-12 col-sm-3 control-label no-padding-right">密码</label>
											<div class="col-xs-12 col-sm-5">
												<span class="block input-icon input-icon-right">
													<input id="password" name="password" type="password" class="width-100"/>
													<i class="ace-icon fa fa-info-circle"></i>
												</span>
											</div>
										</div>

										<div class="form-group">
											<label for="inputInfo" class="col-xs-12 col-sm-3 control-label no-padding-right">密码确认</label>
											<div class="col-xs-12 col-sm-5">
												<span class="block input-icon input-icon-right">
													<input id="password2" name="password2" type="password" class="width-100"/>
													<i class="ace-icon fa fa-info-circle"></i>
												</span>
											</div>
										</div>
										<div class="form-group">
											<label for="email" class="col-xs-12 col-sm-3 control-label no-padding-right">邮箱</label>
											<div class="col-xs-12 col-sm-5">
												<span class="block input-icon input-icon-right">
													<input id="email" name="email" type="text" class="width-100"/>
													<i class="ace-icon fa fa-info-circle"></i>
												</span>
											</div>
										</div>
										<div class="form-group">
											<label for="sex" class="col-xs-12 col-sm-3 control-label no-padding-right">性别</label>
											<div class="col-xs-12 col-sm-5">
												<span class="block input-icon input-icon-right">
													<select id="sex" name="sex" class="select2 width-100">
														<c:forEach items="${elfn:getChildDictById(constants.DICT_SEX_PARENT_ID)}" var="dict">
															<option value="${dict.id}">${dict.name}</option>
														</c:forEach>
													</select>
												</span>
											</div>
										</div>
										
										<div class="form-group">
											<label for="birthday" class="col-xs-12 col-sm-3 control-label no-padding-right">生日</label>
											<div class="col-xs-12 col-sm-5">
												<span class="block input-icon input-icon-right">
													<input id="birthday" name="birthday" type="text" class="width-100 input-medium date-picker" data-date-format="yyyy-mm-dd"/>
													<i class="ace-icon fa fa-calendar"></i>
												</span>
											</div>
										</div>
										
										<div class="form-group">
											<label for="address" class="col-xs-12 col-sm-3 control-label no-padding-right">所在地</label>
											<div class="col-xs-12 col-sm-5">
												<span class="block input-icon input-icon-right city-container-input">
													<ul class="nav ace-nav">
														<li class="transparent">
															<input id="addressName" name="addressName" type="text" data-toggle="dropdown" class="dropdown-toggle width-100"/>
															<tags:area id="address" name="address" lableId="addressName" level="3" showHot="false"></tags:area>
														</li>
													</ul>
													
													<i class="ace-icon fa fa-info-circle"></i>
												</span>
											</div>
										</div>
									</div>
									</form>
									<form class="form-horizontal" id="otherInfoForm">
									<div class="step-pane" id="step3">
										<div class="row-fluid">
											<h3 class="lighter green"><i class="icon-hand-right icon-animated-hand-pointer blue"></i>用户基本信息</h3>
											<div class="form-group">
												<label for="realName" class="col-xs-12 col-sm-3 control-label no-padding-right">真实姓名</label>
												<div class="col-xs-12 col-sm-5">
													<span class="block input-icon input-icon-right">
														<input id="realName" name="realName" type="text" class="width-100"/>
														<i class="ace-icon fa fa-info-circle"></i>
													</span>
												</div>
											</div>
											<div class="form-group">
												<label for="idCard" class="col-xs-12 col-sm-3 control-label no-padding-right">身份证号</label>
												<div class="col-xs-12 col-sm-5">
													<span class="block input-icon input-icon-right">
														<input id="idCard" name="idCard" type="text" class="width-100"/>
														<i class="ace-icon fa fa-info-circle"></i>
													</span>
												</div>
											</div>
											<div class="form-group">
												<label for="mobilephone" class="col-xs-12 col-sm-3 control-label no-padding-right">手机号</label>
												<div class="col-xs-12 col-sm-5">
													<span class="block input-icon input-icon-right">
														<input id="mobilephone" name="mobilephone" type="text" class="width-100"/>
														<i class="ace-icon fa fa-info-circle"></i>
													</span>
												</div>
											</div>
											<div class="form-group">
												<label for="qq" class="col-xs-12 col-sm-3 control-label no-padding-right">QQ</label>
												<div class="col-xs-12 col-sm-5">
													<span class="block input-icon input-icon-right">
														<input id="qq" name="qq" type="text" class="width-100"/>
														<i class="ace-icon fa fa-info-circle"></i>
													</span>
												</div>
											</div>
											<div class="form-group">
												<label for="msn" class="col-xs-12 col-sm-3 control-label no-padding-right">MSN</label>
												<div class="col-xs-12 col-sm-5">
													<span class="block input-icon input-icon-right">
														<input id="msn" name="msn" type="text" class="width-100"/>
														<i class="ace-icon fa fa-info-circle"></i>
													</span>
												</div>
											</div>
											<div class="form-group">
												<label for="website" class="col-xs-12 col-sm-3 control-label no-padding-right">个人博客</label>
												<div class="col-xs-12 col-sm-5">
													<span class="block input-icon input-icon-right">
														<input id="website" name="website" type="text" class="width-100"/>
														<i class="ace-icon fa fa-info-circle"></i>
													</span>
												</div>
											</div>
											<div class="form-group">
												<label for="comment" class="col-xs-12 col-sm-3 control-label no-padding-right">个人评价</label>
												<div class="col-xs-12 col-sm-5">
													<span class="block input-icon input-icon-right">
														<input id="comment" name="comment" type="text" class="width-100" />
														<i class="ace-icon fa fa-info-circle"></i>
													</span>
												</div>
											</div>
										</div>
									</div>
									</form>

									<div class="step-pane" id="step4">
										<div class="widget-header widget-header-flat">
											<h4 class="smaller">《用户协议》</h4>
									
											<div class="widget-toolbar">
												<label>
													<small class="green">
														<b>排版</b>
													</small>
									
													<input id="id-check-horizontal" type="checkbox" class="ace ace-switch ace-switch-6" />
													<span class="lbl"></span>
												</label>
											</div>
										</div>
									
										<div class="widget-body">
											<div class="widget-main">
												<dl id="dt-list-1">
													<dt>Description lists</dt>
													<dd>A description list is perfect for defining terms.</dd>
													<dt>Euismod</dt>
													<dd>Vestibulum id ligula porta felis euismod semper eget lacinia odio sem nec elit.</dd>
													<dd>Donec id elit non mi porta gravida at eget metus.</dd>
													<dt>Malesuada porta</dt>
													<dd>Etiam porta sem malesuada magna mollis euismod.</dd>
													<dt>Felis euismod semper eget lacinia</dt>
													<dd>Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus.</dd>
												</dl>
											</div>
										</div>
										<div class="center-block">
											<label>
												<strong class="gray">
													<b>《同意注册协议》</b>
												</strong>
												<input id="agree" name="agree" class="ace ace-switch ace-switch-7" type="checkbox" />
												<span class="lbl"></span>
											</label>
										</div>
									</div>
									<form class="form-horizontal" id="checkForm">
									<div class="step-pane" id="step5">
										<div class="row-fluid">
											<div class="form-group">
												<label for="email" class="col-xs-12 col-sm-3 control-label no-padding-right">邮箱</label>
												<div class="col-xs-12 col-sm-5">
													<span class="block input-icon input-icon-right">
														<input id="checkEmail" name="checkEmail" type="text" class="width-100"/>
														<i class="ace-icon fa fa-info-circle"></i>
														<button id="sendCode" type="button" class="btn btn-xs btn-primary no-border pull-right">
															<span class="bigger-110">发送验证码</span>
															<i class="icon-arrow-right icon-on-right"></i>
														</button>
													</span>
												</div>
											</div>

											<div class="form-group">
												<label for="email" class="col-xs-12 col-sm-3 control-label no-padding-right">验证码</label>
												<div class="col-xs-12 col-sm-5">
													<span class="block input-icon input-icon-right">
														<input id="emailCode" name="emailCode" type="text" class="width-100" />
														<i class="ace-icon fa fa-info-circle"></i>
													</span>
												</div>
											</div>
										</div>
									</div>
									</form>
								</div>
								<hr />
								<div class="row-fluid wizard-actions">
									<button class="btn btn-danger" onclick="show_box('login-box')">
										<i class="ace-icon fa fa-reply"></i>
										返回
									</button>
									
									<button class="btn btn-prev">
										<i class="ace-icon fa fa-arrow-left"></i>
										上一步
									</button>

									<button class="btn btn-success btn-next" data-last="Finish ">
										下一步
										<i class="ace-icon fa fa-arrow-right"></i>
									</button>
								</div>
							</div><!-- /widget-main -->
						</div><!-- /widget-body -->
					</div><!-- /signup-box -->
				</div><!-- /.col -->
			</div><!-- /.row -->
		</div>
	</div><!-- /.main-container -->
	<script type="text/javascript">
		var registerFlag=false;
		$(function(){
			formValidate($("#subForm"), 'help-block inline error', 'div');
			formValidate($("#baseInfoForm"), 'help-block inline error', 'div',{
				nick: {
					required: true,
					maxlength:50,
					remote: {
					    url: "${adminFullPath}/user/register/checkInfo",     //后台处理程序
					    type: "post",               //数据发送方式
					    dataType: "json",           //接受数据格式   
					    data: {                     //要传递的数据
					    	nick: function() {
					            return $("#nick").val();
					        }
					    }
					}
				},
				username: {
					required: true,
					maxlength:50,
					remote: {
					    url: "${adminFullPath}/user/register/checkInfo",     //后台处理程序
					    type: "post",               //数据发送方式
					    dataType: "json",           //接受数据格式   
					    data: {                     //要传递的数据
					    	username: function() {
					            return $("#username").val();
					        }
					    }
					}
				},
				password: {
					required: true,
					minlength: 6
				},
				password2: {
					required: true,
					equalTo: "#password"
				},
				email: {
					required: true,
					email:true,
					maxlength:50,
					remote: {
					    url: "${adminFullPath}/user/register/checkInfo",     //后台处理程序
					    type: "post",               //数据发送方式
					    dataType: "json",           //接受数据格式   
					    data: {                     //要传递的数据
					    	username: function() {
					            return $("#email").val();
					        }
					    }
					}
				},
				sex:{
					required: true
				},
				birthday:{
					required: true,
					date:true
				},
				addressName:{
					required: true
				}
			},{
				nick: {
					required: '用户昵称必填！',
					maxlength:'用户昵称过长！',
					remote:'该昵称已被使用，请更换其他昵称！'
				},
				username: {
					required: '账户名称必填！',
					maxlength:'账户名称过长！',
					remote:'该用户名已存在，请更换其他用户名！'
				},
				password: {
					required: '用户密码必填！',
					minlength: '密码长度不能低于6位！'
				},
				password2: {
					required:'确认密码必填！',
					equalTo: "确认密码不一致！"
				},
				email: {
					required: '邮箱账号必填！',
					email:'邮箱格式有误！',
					maxlength:'邮箱账号最大长度为50位！',
					remote:'该邮箱已被注册，请更换其他邮箱注册！'
				},
				sex:{
					required: '性别必填！'
				},
				birthday:{
					required: '生日日期必填！',
					date:'生日格式不符！'
				},
				addressName:{
					required: '所在地必填！'
				}
			});
			formValidate($("#otherInfoForm"), 'help-block inline error', 'div',
				 {
					realName: {
						chinese:true,
						maxlength:5
					},
					idCard: {
						idcard:true,
						remote: {
						    url: "${adminFullPath}/user/register/checkInfo",     //后台处理程序
						    type: "post",               //数据发送方式
						    dataType: "json",           //接受数据格式   
						    data: {                     //要传递的数据
						    	idCard: function() {
						            return $("#idCard").val();
						        }
						    }
						}
					},
					mobilephone: {
						mobile:true,
						remote: {
						    url: "${adminFullPath}/user/register/checkInfo",     //后台处理程序
						    type: "post",               //数据发送方式
						    dataType: "json",           //接受数据格式   
						    data: {                     //要传递的数据
						    	username: function() {
						            return $("#mobilephone").val();
						        }
						    }
						}
					},
					qq: {
						maxlength:20
					},
					msn: {
						maxlength:20
					},
					website: {
						maxlength:50,
						url:true
					}
				},{
					realName: {
						chinese:'真实姓名必须为汉字！',
						maxlength:'真实姓名最大长度过长！'
					},
					idCard: {
						idcard:'身份证验证不符！',
						remote:'改身份证已经被注册过，如若忘记密码，请申请密码找回！'
					},
					mobilephone: {
						mobile:'手机格式验证不符！',
						remote:'该手机号已被注册，请更换其他手机号注册！'
					},
					qq: {
						maxlength:'QQ号长度过长！'
					},
					msn: {
						maxlength:'MSN长度过长！'
					},
					website: {
						maxlength:'博客地址长度过长！',
						url:'博客地址格式不符！'
					}
				});
			formValidate($("#checkForm"), 'help-block inline error', 'div',
					 {
						checkEmail: {
							required:true,
							email:true
						},
						emailCode:{
							required:true
						}
					},{
						checkEmail: {
							required:'邮箱账号不能为空！',
							email:'邮箱账号必须为正确格式！'
						},
						emailCode:{
							required:'验证码必填！'
						}
					});
			formValidate($("#restPwdForm"), 'help-block inline error', 'div',
					 {
						restPwdEmail: {
							required:true,
							email:true,
							remote: {
							    url: "${adminFullPath}/user/register/hasEmail",     //后台处理程序
							    type: "post",               //数据发送方式
							    dataType: "json",           //接受数据格式   
							    data: {                     //要传递的数据
							    	username: function() {
							            return $("#restPwdEmail").val();
							        }
							    }
							}
						}
					},{
						restPwdEmail: {
							required:'邮箱账号不能为空！',
							email:'邮箱账号必须为正确格式！',
							remote:'邮箱账号不存在！'
						}
					});
			$(document).on('click', '.toolbar a[data-target]', function(e) {
				e.preventDefault();
				var target = $(this).data('target');
				$('.widget-box.visible').removeClass('visible');//hide others
				$(target).addClass('visible');//show target
			 });
			//第一步选择身份
			$('#step1 a').on('click',function(){
				$('#roleIdsStr').val($(this).attr('roleId'));
				$('.btn-next').trigger("click");
			});
			//重置密码按钮邮件发送
			$('#restBtn').on('click',function(){
				var btn = $(this),time = 60*1000,intervalId,countime=60;
				if(!$("#restPwdForm").valid()){
					return false;
				}
				btn.button('loading');
				$.ajax({
				   type: "POST",
				   url: "${adminFullPath}/user/register/sendResetPwdEmailCode",
				   data: 'email='+$('#restPwdEmail').val(),
				   dataType:'text',
				   success: function(checkFlag){
					   if(checkFlag){
						   $.jBox.tip("验证码已发送到您的邮箱，请注意查收！");
					   }else{
				    		$.jBox.tip("验证码发送失败！请重新发送验证码。", 'error');
				    		return false;
					   }
					   intervalId = window.setInterval(function(){
							if(countime*1000 === 0){
								window.clearInterval(intervalId);
								btn.button('reset');
							}else{
								countime--;
								btn.text(countime+'秒后重新发送...');
							}
						},1000);
				   }
				});
			});
			//添加表单验证
			//var $validation = formValidate($("#registForm"), 'help-block inline error', 'div');
			$('#fuelux-wizard').ace_wizard().on('change' , function(e, info){
				if(info.step == 1 &&info.direction==='next') {
					if($("#roleIdsStr").val()==='') {
						$.jBox.tip('亲！请选择您要注册的身份！', 'error');
						return false;
					}
				}
				if(info.step == 2 &&info.direction==='next') {
					if(!$("#baseInfoForm").valid()) return false;
				}
				if(info.step == 3 &&info.direction==='next') {
					if(!$("#otherInfoForm").valid()) return false;
				}
				if(info.step == 4 &&info.direction==='next') {
					if(!registerFlag){
						if(!$('#agree').get(0).checked){
							$.jBox.tip('亲！请先同意注册协议才能进入下一步！', 'error');
							return false;
						}
						$.ajax({
						   type: "POST",
						   url: "${adminFullPath}/user/register/registerUser",
						   data: $('#step-container :input,#step-container select').serializeArray(),
						   async:false,
						   dataType:'text',
						   success: function(msg){
							   registerFlag=true;
							   $.jBox.tip(msg);
							   $('#checkEmail').val($('#email').val());
						   }
						});
					}
				}
			}).on('finished', function(e) {
				if(!$("#checkForm").valid())return false;
				$.ajax({
				   type: "POST",
				   url: "${adminFullPath}/user/register/checkEmailCode",
				   data: 'email='+$('#checkEmail').val()+'&code='+$('#emailCode').val(),
				   async:false,
				   dataType:'json',
				   success: function(checkFlag){
					   if(checkFlag){
						   $.jBox.tip("账户激活成功！您可以登陆系统了！");
						   show_box('login-box');
					   }else
				    		$.jBox.tip("验证码过期或者输入有误,验证失败！请重新发送验证。", 'error');
				   }
				});
			}).on('stepclick', function(e){
				//return false;//prevent clicking on steps
			});
			window.prettyPrint && prettyPrint();
			$('#id-check-horizontal').removeAttr('checked').on('click', function(){
				$('#dt-list-1').toggleClass('dl-horizontal');
			});
			$('#sendCode').on(ace.click_event, function () {
				var btn = $(this),time = 60*1000,intervalId,countime=60;
				btn.button('loading');
				$.ajax({
				   type: "POST",
				   url: "${adminFullPath}/user/register/sendEmailCode",
				   data: 'email='+$('#checkEmail').val(),
				   dataType:'text',
				   success: function(msg){
					   $.jBox.tip(msg);
					   intervalId = window.setInterval(function(){
							if(countime*1000 === 0){
								window.clearInterval(intervalId);
								btn.button('reset');
							}else{
								countime--;
								btn.text(countime+'秒后重新发送...');
							}
						},1000);
				   }
				});
			});
		});
		function showStep(step){
			show_box('signup-box');
			var wizard = $('#fuelux-wizard').data('wizard');

			 //move to step num(step)
			 wizard.currentStep = step;
			 wizard.setState();
			 
			 //determine selected step
			 //wizard.selectedItem().step;
		}
		function show_box(id) {
			jQuery('.widget-box.visible').removeClass('visible');
			jQuery('#'+id).addClass('visible');
		}
		function showError(error, element){
			var forGroup = element.closest('.form-group');
			$("div[class='help-block inline error']",forGroup).remove();
			if(element.is(':checkbox') || element.is(':radio')) {
				var controls = element.closest('div[class*="col-"]');
				if(controls.find(':checkbox,:radio').length > 1) controls.append(error);
				else error.insertAfter(element.nextAll('.lbl:eq(0)').eq(0));
			}
			else if(element.is('.select2')) {
				error.insertAfter(element.siblings('[class*="select2-container"]:eq(0)'));
			}
			else if(element.is('.chosen-select')) {
				error.insertAfter(element.siblings('[class*="chosen-container"]:eq(0)'));
			}
			else error.appendTo(forGroup);
		}
		function refreshCaptcha() {
			$('#img_captcha').attr("src","${contextPath}/servlet/captchaCode?t=" + Math.random());
		}

	</script>
</body>
</html>