<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<tags:header inplugins="${plugins.jqui},${plugins.validate}" title="用户信息"></tags:header>
</head>
<body>
	<div class="page-content-area">
		<div class="page-header">
			<h1>
				用户信息
				<small>
					<i class="ace-icon fa fa-angle-double-right"></i>
					个人详情
				</small>
			</h1>
		</div><!-- /.page-header -->

		<div class="row">
			<div class="col-xs-12">
				<!-- PAGE CONTENT BEGINS -->
				<div>
					<div id="user-profile-2" class="user-profile">
						<div class="tabbable">
							<ul class="nav nav-tabs padding-18">
								<li class="active">
									<a data-toggle="tab" href="#home">
										<i class="green icon-user bigger-120"></i>
										基本信息
									</a>
								</li>
								<li>
									<a data-toggle="tab" href="#works">
										<i class="blue icon-group bigger-120"></i>
										公布信息
									</a>
								</li>
								<li>
									<a data-toggle="tab" href="#edit-password">
										<i class="blue icon-key bigger-125"></i>
										账户信息
									</a>
								</li>
								<li>
									<a data-toggle="tab" href="#edit-settings">
										<i class="purple icon-cog bigger-125"></i>
										设置
									</a>
								</li>
							</ul>

							<div class="tab-content no-border padding-24">
								<div id="home" class="tab-pane active">
									<div id="user-profile-1" class="user-profile row">
										<div class="col-xs-12 col-sm-3 center">
											<div>
												<tags:webuploader id="header_pic" fileVal="photo" name="headPic" modeType="single_pic" overFormData="id:'${user.id}'"
												items="${elfn:getAttachList(user.headPic)}" superId="${user.id}" 
												server="${adminFullPath}/user/uploadHeaderPic"></tags:webuploader>
				
												<div class="space-4"></div>
				
												<div class="width-80 label label-info label-xlg arrowed-in arrowed-in-right">
													<div class="inline position-relative">
														<a href="#" class="user-title-label dropdown-toggle" data-toggle="dropdown">
															<i class="icon-circle light-green middle"></i>
															&nbsp;
															<span class="white">Alex M. Doe</span>
														</a>
				
														<ul class="align-left dropdown-menu dropdown-caret dropdown-lighter">
															<li class="dropdown-header"> Change Status </li>
				
															<li>
																<a href="#">
																	<i class="icon-circle green"></i>
																	&nbsp;
																	<span class="green">Available</span>
																</a>
															</li>
				
															<li>
																<a href="#">
																	<i class="icon-circle red"></i>
																	&nbsp;
																	<span class="red">Busy</span>
																</a>
															</li>
				
															<li>
																<a href="#">
																	<i class="icon-circle grey"></i>
																	&nbsp;
																	<span class="grey">Invisible</span>
																</a>
															</li>
														</ul>
													</div>
												</div>
											</div>
				
											<div class="space-6"></div>
				
											<div class="profile-contact-info">
												<div class="profile-contact-links align-left">
													<a class="btn btn-link" href="#">
														<i class="icon-plus-sign bigger-120 green"></i>
														Add as a friend
													</a>
				
													<a class="btn btn-link" href="#">
														<i class="icon-envelope bigger-120 pink"></i>
														Send a message
													</a>
				
													<a class="btn btn-link" href="#">
														<i class="icon-globe bigger-125 blue"></i>
														www.alexdoe.com
													</a>
												</div>
				
												<div class="space-6"></div>
				
												<div class="profile-social-links center">
													<a href="#" class="tooltip-info" title="" data-original-title="Visit my Facebook">
														<i class="middle icon-facebook-sign icon-2x blue"></i>
													</a>
				
													<a href="#" class="tooltip-info" title="" data-original-title="Visit my Twitter">
														<i class="middle icon-twitter-sign icon-2x light-blue"></i>
													</a>
				
													<a href="#" class="tooltip-error" title="" data-original-title="Visit my Pinterest">
														<i class="middle icon-pinterest-sign icon-2x red"></i>
													</a>
												</div>
											</div>
				
											<div class="hr hr12 dotted"></div>
				
											<div class="clearfix">
												<div class="grid2">
													<span class="bigger-175 blue">25</span>
				
													<br />
													Followers
												</div>
				
												<div class="grid2">
													<span class="bigger-175 blue">12</span>
				
													<br />
													Following
												</div>
											</div>
				
											<div class="hr hr16 dotted"></div>
										</div>
				
										<div class="col-xs-12 col-sm-9">
											<div class="center">
												<span class="btn btn-app btn-sm btn-light no-hover">
													<span class="line-height-1 bigger-170 blue"> 1,411 </span>
				
													<br />
													<span class="line-height-1 smaller-90"> Views </span>
												</span>
				
												<span class="btn btn-app btn-sm btn-yellow no-hover">
													<span class="line-height-1 bigger-170"> 32 </span>
				
													<br />
													<span class="line-height-1 smaller-90"> Followers </span>
												</span>
				
												<span class="btn btn-app btn-sm btn-pink no-hover">
													<span class="line-height-1 bigger-170"> 4 </span>
				
													<br />
													<span class="line-height-1 smaller-90"> Projects </span>
												</span>
				
												<span class="btn btn-app btn-sm btn-grey no-hover">
													<span class="line-height-1 bigger-170"> 23 </span>
				
													<br />
													<span class="line-height-1 smaller-90"> Reviews </span>
												</span>
				
												<span class="btn btn-app btn-sm btn-success no-hover">
													<span class="line-height-1 bigger-170"> 7 </span>
				
													<br />
													<span class="line-height-1 smaller-90"> Albums </span>
												</span>
				
												<span class="btn btn-app btn-sm btn-primary no-hover">
													<span class="line-height-1 bigger-170"> 55 </span>
				
													<br />
													<span class="line-height-1 smaller-90"> Contacts </span>
												</span>
											</div>
				
											<div class="space-12"></div>
											<form:form action="${adminFullPath}/user/updateinfo" cssClass="form-horizontal" commandName="user" method="post" id="baseInfo">
											<div class="space"></div>
											<h4 class="header blue bolder smaller">基本信息</h4>
											<div class="form-group">
									            <form:label path="name" cssClass="control-label col-xs-12 col-sm-3 no-padding-right" for="username">用户名 ：</form:label>
									            <div class="col-xs-12 col-sm-5">
													<span class="block input-icon input-icon-right">
														<form:input path="username" maxlength="50" cssClass="width-100 required" title="用户名必填"/>
														<i class="ace-icon fa fa-info-circle"></i>
													</span>
												</div>
									        </div>
									        <div class="form-group">
									            <form:label path="name" cssClass="control-label col-xs-12 col-sm-3 no-padding-right" for="realName">真实姓名 ：</form:label>
									            <div class="col-xs-12 col-sm-5">
													<span class="block input-icon input-icon-right">
														<form:input path="realName" maxlength="50" cssClass="width-100 required" title="真实姓名必填"/>
														<i class="ace-icon fa fa-info-circle"></i>
													</span>
												</div>
									        </div>
									        <div class="form-group">
									            <form:label path="name" cssClass="control-label col-xs-12 col-sm-3 no-padding-right" for="sex">性别 ：</form:label>
									            <div class="col-xs-12 col-sm-5">
													<span class="block input-icon input-icon-right">
														<form:select path="sex" items="${elfn:getChildDictById(constants.DICT_SEX_PARENT_ID)}" itemLabel="name" itemValue="id" cssClass="select2 width-100"></form:select>
													</span>
												</div>
									        </div>
									        <div class="form-group">
									            <form:label path="name" cssClass="control-label col-xs-12 col-sm-3 no-padding-right" for="idCard">身份证 ：</form:label>
									            <div class="col-xs-12 col-sm-5">
													<span class="block input-icon input-icon-right">
														<form:input path="idCard" cssClass="width-100 required" title="身份证 必填"/>
														<i class="ace-icon fa fa-info-circle"></i>
													</span>
												</div>
									        </div>
									        <div class="form-group">
									            <form:label path="name" cssClass="control-label col-xs-12 col-sm-3 no-padding-right" for="otherCard">其他证件 ：</form:label>
									            <div class="col-xs-12 col-sm-5">
													<span class="block input-icon input-icon-right">
														<form:input path="otherCard" cssClass="width-100"/>
														<i class="ace-icon fa fa-info-circle"></i>
													</span>
												</div>
									        </div>
									        <div class="form-group">
									            <form:label path="name" cssClass="control-label col-xs-12 col-sm-3 no-padding-right" for="birthday">生日 ：</form:label>
									            <div class="col-xs-12 col-sm-5">
													<span class="block input-icon input-icon-right">
														<form:input path="birthday" cssClass="width-100 input-medium date-picker" data-date-format="yyyy-mm-dd"/>
														<i class="ace-icon fa fa-calendar"></i>
													</span>
												</div>
									        </div>
									        <div class="form-group">
									            <form:label path="name" cssClass="control-label col-xs-12 col-sm-3 no-padding-right" for="mobilePhone">手机号 ：</form:label>
									            <div class="col-xs-12 col-sm-5">
													<span class="block input-icon input-icon-right">
														<form:input path="mobilePhone" cssClass="width-100"/>
														<i class="ace-icon fa fa-info-circle"></i>
													</span>
												</div>
									        </div>
									        <div class="form-group">
									            <form:label path="name" cssClass="control-label col-xs-12 col-sm-3 no-padding-right" for="phone">座机：</form:label>
									            <div class="col-xs-12 col-sm-5">
													<span class="block input-icon input-icon-right">
														<form:input path="phone" cssClass="width-100"/>
														<i class="ace-icon fa fa-info-circle"></i>
													</span>
												</div>
									        </div>
									        <div class="form-group">
									            <form:label path="name" cssClass="control-label col-xs-12 col-sm-3 no-padding-right" for="qq">QQ ：</form:label>
									            <div class="col-xs-12 col-sm-5">
													<span class="block input-icon input-icon-right">
														<form:input path="qq" cssClass="width-100"/>
														<i class="ace-icon fa fa-info-circle"></i>
													</span>
												</div>
									        </div>
									        <div class="form-group">
									            <form:label path="name" cssClass="control-label col-xs-12 col-sm-3 no-padding-right" for="msn">MSN ：</form:label>
									            <div class="col-xs-12 col-sm-5">
													<span class="block input-icon input-icon-right">
														<form:input path="msn" cssClass="width-100"/>
														<i class="ace-icon fa fa-info-circle"></i>
													</span>
												</div>
									        </div>
									        <div class="form-group">
									            <form:label path="name" cssClass="control-label col-xs-12 col-sm-3 no-padding-right" for="email">Email ：</form:label>
									            <div class="col-xs-12 col-sm-5">
													<span class="block input-icon input-icon-right">
														<form:input path="email" cssClass="width-100"/>
														<i class="ace-icon fa fa-info-circle"></i>
													</span>
												</div>
									        </div>
									        <div class="form-group">
									            <form:label path="name" cssClass="control-label col-xs-12 col-sm-3 no-padding-right" for="website">个人网址 ：</form:label>
									            <div class="col-xs-12 col-sm-5">
													<span class="block input-icon input-icon-right">
														<form:input path="website" cssClass="width-100"/>
														<i class="ace-icon fa fa-info-circle"></i>
													</span>
												</div>
									        </div>
									        <div class="form-group">
									            <form:label path="name" cssClass="control-label col-xs-12 col-sm-3 no-padding-right" for="address">地址 ：</form:label>
									            <div class="col-xs-12 col-sm-5">
													<span class="block input-icon input-icon-right city-container-input">
														<ul class="nav ace-nav">
															<li class="transparent">
																<input id="addressName" name="addressName" type="text" data-toggle="dropdown" class="dropdown-toggle width-100"/>
																<tags:area id="address" name="address" lableId="addressName" level="3" showHot="false" value="${user.address}"></tags:area>
															</li>
														</ul>
														<i class="ace-icon fa fa-info-circle"></i>
													</span>
												</div>
									        </div>
									        <div class="form-group">
									            <form:label path="name" cssClass="control-label col-xs-12 col-sm-3 no-padding-right" for="comment">座右铭 ：</form:label>
									            <div class="col-xs-12 col-sm-5">
													<span class="block input-icon input-icon-right">
														<form:input path="comment" cssClass="width-100"/>
														<i class="ace-icon fa fa-info-circle"></i>
													</span>
												</div>
									        </div>
											<div class="space-6"></div>
				
											<div class="clearfix form-actions">
												<div class="col-md-offset-3 col-md-9">
													<button class="btn btn-info" type="submit">
														<i class="ace-icon fa fa-check bigger-110"></i>
														提交
													</button>

													&nbsp; &nbsp;
													<button class="btn" type="reset">
														<i class="ace-icon fa fa-reply-all bigger-110"></i>
														重置
													</button>
												</div>
											</div>
											</form:form>
										</div>
									</div>
								</div><!-- #home -->
								<div id="works" class="tab-pane">
									<div class="space"></div>
									<h4 class="header blue bolder smaller">公布信息<small class="smaller lighter red">(为了找到您更好的合作伙伴,请尽可能的完善您的信息！)</small></h4>
									<form:form id="resumeForm" action="${adminFullPath}/resume/${empty resume.id?'create':'update'}" cssClass="form-horizontal" commandName="resume" method="post">
										<input type="hidden" name="id" value="${resume.id}">
										<input type="hidden" name="userId" value="${empty resume.userId?user.id:resume.userId}">
								        <div class="form-group">
								            <form:label path="teacheStatus" cssClass="control-label col-xs-12 col-sm-3 no-padding-right" for="teacheStatus">家教状态：</form:label>
								            <div class="col-xs-12 col-sm-5">
												<span class="block input-icon input-icon-right">
													<form:select path="teacheStatus" itemLabel="name" itemValue="id" items="${elfn:getChildDictById(constants.DICT_SERVICE_STATUS_PARENT_ID)}" cssClass="select2 width-100"></form:select>
												</span>
											</div>
								        </div>
										<div class="form-group">
								            <form:label path="called" cssClass="control-label col-xs-12 col-sm-3 no-padding-right" for="called">称呼：</form:label>
								            <div class="col-xs-12 col-sm-5">
												<span class="block input-icon input-icon-right">
													<form:input path="called" cssClass="width-100"/>
													<i class="ace-icon fa fa-info-circle"></i>
												</span>
											</div>
								        </div>
								        <div class="form-group">
								            <form:label path="phone" cssClass="control-label col-xs-12 col-sm-3 no-padding-right" for="phone">联系电话：</form:label>
								            <div class="col-xs-12 col-sm-5">
												<span class="block input-icon input-icon-right">
													<input type="text" id="phone" name="phone" value="${empty resume.phone?user.phone:resume.phone}" class="width-100"/>
													<i class="ace-icon fa fa-info-circle"></i>
												</span>
											</div>
								        </div>
								        <div class="form-group">
								            <form:label path="payroll" cssClass="control-label col-xs-12 col-sm-3 no-padding-right" for="payroll">薪酬标准：</form:label>
								            <div class="col-xs-12 col-sm-5">
												<span class="block input-icon input-icon-right">
													<form:input path="payroll" cssClass="width-100"/>
													<i class="ace-icon fa fa-info-circle"></i>
												</span>
											</div>
											<div class="col-xs-12 col-sm-2">
												<span class="help-inline">
													<span class="middle">(元/小时)</span>
												</span>
											</div>
								        </div>
								        <div class="form-group">
								            <form:label path="serviceType" cssClass="control-label col-xs-12 col-sm-3 no-padding-right" for="serviceType">服务方式：</form:label>
								            <div class="col-xs-12 col-sm-5">
												<span class="block input-icon input-icon-right">
													<form:select path="serviceType" itemLabel="name" itemValue="id" items="${elfn:getChildDictById(constants.DICT_SERVICE_TYPE_PARENT_ID)}" cssClass="select2 width-100"></form:select>
												</span>
											</div>
								        </div>
								        <div class="form-group">
								            <form:label path="teacheTime" cssClass="control-label col-xs-12 col-sm-3 no-padding-right" for="teacheTime">教学时间：</form:label>
								            <div class="col-xs-12 col-sm-5">
												<span class="block input-icon input-icon-right">
													<select class="select2 width-100" name="teacheTime" multiple="multiple">
														<c:forEach items="${elfn:getChildDictById(constants.DICT_FREE_DATE_PARENT_ID)}" var="freeDates">
															<option value="${freeDates.id}" ${fn:contains(resume.teacheTime, freeDates.id)?'selected="selected"':''}>${freeDates.name}</option>
														</c:forEach>
													</select>
												</span>
											</div>
								        </div>
								        <c:if test="${elfn:isStudent()}">
								        	<h4 class="header blue bolder smaller">学员信息</h4>
									        <div class="form-group">
									            <form:label path="classes" cssClass="control-label col-xs-12 col-sm-3 no-padding-right" for="classes">年级：</form:label>
									            <div class="col-xs-12 col-sm-5">
													<span class="block input-icon input-icon-right">
														<form:select path="classes" itemLabel="name" itemValue="id" items="${elfn:getChildDictById(constants.DICT_CLASS_PARENT_ID)}" cssClass="select2 width-100"></form:select>
													</span>
												</div>
									        </div>
								        	<div class="form-group">
									            <form:label path="address" cssClass="control-label col-xs-12 col-sm-3 no-padding-right" for="address">家教地址：</form:label>
									            <div class="col-xs-12 col-sm-5">
													<span class="block input-icon input-icon-right">
														<form:input path="address" cssClass="width-100"/>
														<i class="ace-icon fa fa-info-circle"></i>
													</span>
												</div>
									        </div>
									        <div class="form-group">
									            <form:label path="learning" cssClass="control-label col-xs-12 col-sm-3 no-padding-right" for="learning">学习状况：</form:label>
									            <div class="col-xs-12 col-sm-5">
													<span class="block input-icon input-icon-right">
														<form:select path="learning" itemLabel="name" itemValue="id" items="${elfn:getChildDictById(constants.DICT_LEARNING_PARENT_ID)}" cssClass="select2 width-100"></form:select>
													</span>
												</div>
									        </div>
									        <div class="form-group">
									            <form:label path="requestSex" cssClass="control-label col-xs-12 col-sm-3 no-padding-right" for="requestSex">性别要求：</form:label>
									            <div class="col-xs-12 col-sm-5">
													<span class="block input-icon input-icon-right">
														<form:select path="requestSex" itemLabel="name" itemValue="id" items="${elfn:getChildDictById(constants.DICT_SEX_PARENT_ID)}" cssClass="select2 width-100"></form:select>
													</span>
												</div>
									        </div>
									        <div class="form-group">
									            <form:label path="requestDiploma" cssClass="control-label col-xs-12 col-sm-3 no-padding-right" for="requestDiploma">学历要求：</form:label>
									            <div class="col-xs-12 col-sm-5">
													<span class="block input-icon input-icon-right">
														<form:select path="requestDiploma" itemLabel="name" itemValue="id" items="${elfn:getChildDictById(constants.DICT_DIPLOMA_PARENT_ID)}" cssClass="select2 width-100"></form:select>
													</span>
												</div>
									        </div>
									        <div class="form-group">
									            <form:label path="requestExpert" cssClass="control-label col-xs-12 col-sm-3 no-padding-right" for="requestExpert">科目要求：</form:label>
									            <div class="col-xs-12 col-sm-5">
													<span class="block input-icon input-icon-right">
														<form:select path="requestExpert" itemLabel="name" itemValue="id" items="${elfn:getChildDictById(constants.DICT_EXPERT_PARENT_ID)}" cssClass="select2 width-100"></form:select>
													</span>
												</div>
									        </div>
									        <div class="form-group">
									            <form:label path="otherRemark" cssClass="control-label col-xs-12 col-sm-3 no-padding-right" for="otherRemark">其他要求：</form:label>
									            <div class="col-xs-12 col-sm-5">
													<span class="block input-icon input-icon-right">
														<form:textarea path="otherRemark" cssClass="autosize-transition form-control"/>
													</span>
												</div>
									        </div>
								        </c:if>
								        <c:if test="${elfn:isTeacher()}">
								        	<h4 class="header blue bolder smaller">教员信息</h4>
									        <div class="form-group">
									            <form:label path="teacheAge" cssClass="control-label col-xs-12 col-sm-3 no-padding-right" for="teacheAge">教龄：</form:label>
									            <div class="col-xs-12 col-sm-5">
													<span class="block input-icon input-icon-right">
														<form:input path="teacheAge" cssClass="width-100"/>
														<i class="ace-icon fa fa-info-circle"></i>
													</span>
												</div>
									        </div>
									        <div class="form-group">
									            <form:label path="teacheDiploma" cssClass="control-label col-xs-12 col-sm-3 no-padding-right" for="teacheDiploma">教员学历：</form:label>
									            <div class="col-xs-12 col-sm-5">
													<span class="block input-icon input-icon-right">
														<form:select path="teacheDiploma" itemLabel="name" itemValue="id" items="${elfn:getChildDictById(constants.DICT_DIPLOMA_PARENT_ID)}" cssClass="select2 width-100"></form:select>
													</span>
												</div>
									        </div>
									        <div class="form-group">
									            <form:label path="school" cssClass="control-label col-xs-12 col-sm-3 no-padding-right" for="school">毕业院校：</form:label>
									            <div class="col-xs-12 col-sm-5">
													<span class="block input-icon input-icon-right">
														<form:input path="school" cssClass="width-100"/>
														<i class="ace-icon fa fa-info-circle"></i>
													</span>
												</div>
									        </div>
									        <div class="form-group">
									            <form:label path="special" cssClass="control-label col-xs-12 col-sm-3 no-padding-right" for="special">专业：</form:label>
									            <div class="col-xs-12 col-sm-5">
													<span class="block input-icon input-icon-right">
														<form:input path="special" cssClass="width-100"/>
														<i class="ace-icon fa fa-info-circle"></i>
													</span>
												</div>
									        </div>
									        <div class="form-group">
									            <form:label path="classes" cssClass="control-label col-xs-12 col-sm-3 no-padding-right" for="classes">年级：</form:label>
									            <div class="col-xs-12 col-sm-5">
													<span class="block input-icon input-icon-right">
														<form:select path="classes" itemLabel="name" itemValue="id" items="${elfn:getChildDictById(constants.DICT_CLASS_PARENT_ID)}" cssClass="select2 width-100"></form:select>
													</span>
												</div>
									        </div>
									        <div class="form-group">
									            <form:label path="expert" cssClass="control-label col-xs-12 col-sm-3 no-padding-right" for="expert">擅长科目：</form:label>
									            <div class="col-xs-12 col-sm-5">
													<span class="block input-icon input-icon-right">
														<form:select path="expert" itemLabel="name" itemValue="id" items="${elfn:getChildDictById(constants.DICT_EXPERT_PARENT_ID)}" cssClass="select2 width-100"></form:select>
													</span>
												</div>
									        </div>
									        <div class="form-group">
									            <form:label path="teacheExperience" cssClass="control-label col-xs-12 col-sm-3 no-padding-right" for="teacheExperience">教学经历：</form:label>
									            <div class="col-xs-12 col-sm-5">
													<span class="block input-icon input-icon-right">
														<form:textarea path="teacheExperience" cssClass="autosize-transition form-control"/>
													</span>
												</div>
									        </div>
									        <div class="form-group">
									            <form:label path="introduction" cssClass="control-label col-xs-12 col-sm-3 no-padding-right" for="introduction">自我介绍：</form:label>
									            <div class="col-xs-12 col-sm-5">
													<span class="block input-icon input-icon-right">
														<form:textarea path="introduction" cssClass="autosize-transition form-control"/>
													</span>
												</div>
									        </div>
								        </c:if>
								        <div class="space-6"></div>
				
										<div class="clearfix form-actions">
											<div class="col-md-offset-3 col-md-9">
												<button class="btn btn-info" type="submit">
													<i class="ace-icon fa fa-check bigger-110"></i>
													提交
												</button>

												&nbsp; &nbsp;
												<button class="btn" type="reset">
													<i class="ace-icon fa fa-reply-all bigger-110"></i>
													重置
												</button>
											</div>
										</div>
									</form:form>
								</div><!-- /#works -->
								<div id="edit-password" class="tab-pane">
									<c:set var="from" value="userinfo" scope="request"></c:set>
									<jsp:include page="comupdatepwd.jsp"></jsp:include>
								</div><!-- #password -->
								<div id="edit-settings" class="tab-pane">
									<div class="space-10"></div>

									<div>
										<label class="inline">
											<input type="checkbox" name="form-field-checkbox" class="ace" />
											<span class="lbl"> Make my profile public</span>
										</label>
									</div>

									<div class="space-8"></div>

									<div>
										<label class="inline">
											<input type="checkbox" name="form-field-checkbox" class="ace" />
											<span class="lbl"> Email me new updates</span>
										</label>
									</div>

									<div class="space-8"></div>

									<div>
										<label class="inline">
											<input type="checkbox" name="form-field-checkbox" class="ace" />
											<span class="lbl"> Keep a history of my conversations</span>
										</label>

										<label class="inline">
											<span class="space-2 block"></span>

											for
											<input type="text" class="input-mini" maxlength="3" />
											days
										</label>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<!-- PAGE CONTENT ENDS -->
			</div><!-- /.col -->
		</div><!-- /.row -->
	</div><!-- /.page-content-area -->
	<script type="text/javascript">
	jQuery(function($) {
		formValidate($("#resumeForm"), 'help-block inline error', 'div',{
			teacheStatus: {
				required: true
			},
			called: {
				required: true,
				maxlength:25
			},
			phone:{
				required: true,
				mobile:true
			},
			payroll:{
				required: true,
				number:true
			},
			serviceType: {
				required: true
			},
			teacheTime: {
				required: true
			}
		},{
			teacheStatus: {
				required: '家教状态必选！'
			},
			called: {
				required: '称呼必填！',
				maxlength:'称呼最大长度为25字符！'
			},
			phone:{
				required: '联系电话必填！',
				mobile:'联系电话格式不符！'
			},
			payroll:{
				required: '薪酬标准必填！',
				number:'薪酬标准不符合格式！'
			},
			serviceType: {
				required: '服务方式必选！'
			},
			teacheTime: {
				required: '教学时间必填！'
			}
		});
		//添加重置密码验证
    	formValidate($("#updatepwd"), 'help-block inline error', 'div',{
    		oldPwd:{
    			required:true,
				minlength: 6,
				remote: {
				    url: "${adminFullPath}/user/confirmOldPwd",     //后台处理程序
				    type: "post",               //数据发送方式
				    dataType: "json",           //接受数据格式   
				    data: {                     //要传递的数据
				    	password: function() {
				            return $("#updatepwd #oldPwd").val();
				        },
				        id:function(){
				        	return $('#updatepwd #id').val();
				        },
				        salt:function(){
				        	return $('#updatepwd #salt').val();
				        },
				        username:function(){
				        	return $('#updatepwd #username').val();
				        }
				    }
				}
    		},
    		password:{
    			required:true,
				minlength: 6
    		},
    		confirmPassword:{
    			required:true,
				minlength: 6,
				equalTo: "#password"
    		}
    	},{
    		oldPwd:{
    			required:'原始密码不能为空！',
				minlength: '最小长度不能小于6位！',
				remote: '输入的原始密码不一致！'
    		},
    		password:{
    			required:'新密码不能为空！',
				minlength: '最小长度不能小于6位！'
    		},
    		confirmPassword:{
    			required:'确认密码不能为空！',
				minlength: '最小长度不能小于6位！',
				equalTo: "确认密码与新密码输入不一致！"
    		}
    	});
		
	});
	</script>
</body>
</html>