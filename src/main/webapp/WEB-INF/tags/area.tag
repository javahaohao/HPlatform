<%@ tag language="java" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include/taglib.jsp"%>
<%@ attribute name="id" type="java.lang.String" required="true" description="隐藏域的id"%>
<%@ attribute name="name" type="java.lang.String" required="true" description="隐藏域的name"%>
<%@ attribute name="lableId" type="java.lang.String" required="true" description="显示名称控件的id"%>
<%@ attribute name="lableName" type="java.lang.String" required="false" description="显示名称控件的name"%>
<%@ attribute name="showHot" type="java.lang.Boolean" required="false" description="是否显示热门城市,默认不显示"%>
<%@ attribute name="level" type="java.lang.Integer" required="true" description="显示几级"%>
<%@ attribute name="multi" type="java.lang.Boolean" required="false" description="是否多级展示"%>
<%@ attribute name="value" type="java.lang.String" required="false" description="选中值"%>
<%@ attribute name="selected" type="java.lang.String" required="false" description="选中值触发事件"%>
<%@ attribute name="load" type="java.lang.String" required="false" description="加载完成之后触发事件"%>
<input id="${id}" name="${name}" type="hidden"/>
<!-- #section:elements.tab -->
<ul class="dropdown-menu-right dropdown-navbar dropdown-menu dropdown-caret dropdown-close" id="cityArea">
	<li class="dropdown-header">
		<i class="ace-icon fa fa-paper-plane-o"></i>
		切换城市
	</li>
	<li>
		<div class="tabbable">
			<ul class="nav nav-tabs" id="cityTab">
				<c:if test="${showHot}">
					<li class="active">
						<a data-toggle="tab" href="#hotable">
							热门
						</a>
					</li>
				</c:if>
				<c:if test="${level>=1}">
					<li ${showHot?"":"class='active'"}>
						<a data-toggle="tab" level="1" href="#prov">
							省份
						</a>
					</li>
				</c:if>
				<c:if test="${level>=2}">
					<li>
						<a data-toggle="tab" level="2" href="#city">
							城市
						</a>
					</li>
				</c:if>
				<c:if test="${level>=3}">
					<li>
						<a data-toggle="tab" level="3" href="#county">
							县区
						</a>
					</li>
				</c:if>
				<c:if test="${level>=4}">
					<li>
						<a data-toggle="tab" level="4" href="#street">
							街道
						</a>
					</li>
				</c:if>
			</ul>
		
			<div class="tab-content">
				<c:if test="${showHot}">
					<div id="hotable" class="tab-pane in active">
					</div>
				</c:if>
				<c:if test="${level>=1}">
					<div id="prov" class='tab-pane in ${showHot?"":"active"}' level="1"></div>
				</c:if>
				<c:if test="${level>=2}">
					<div id="city" class="tab-pane in" level="2"></div>
				</c:if>
				<c:if test="${level>=3}">
					<div id="county" class="tab-pane in" level="3"></div>
				</c:if>
				<c:if test="${level>=4}">
					<div id="street" class="tab-pane in" level="4"></div>
				</c:if>
			</div>
		</div>
	</li>
</ul>
<!-- /section:elements.tab -->
<script src="${contextPath}/static/aui-artTemplate/dist/template.js"></script>
<script id="comment" type="text/html">
	{{each areas as value index}}  
       	<a class="city" kid="{{value.id}}" pid="{{value.parentId}}" pids="{{value.parentIds}}">{{value.name}}</a>  
    {{/each}}  
</script>
<script type="text/javascript">
	$(function() {
		$('div.tab-pane').on('click','a.city',function(event){
			var tab = $(this).closest('div.tab-pane');
			var tabPanes = tab.nextAll('div.tab-pane'),kid=$(this).attr('kid');
			clearSelected(tab,tabPanes);
			
			$(this).addClass('selected');
			if(!!!tab.attr('level')||tabPanes.size()==0){
				setValue(kid);
			}else if(!!tabPanes&&tabPanes.size()>0){
				findAreas(kid,tabPanes.first());
				return false;
			}
		});
		<c:set var="map" value="${elfn:getBrotherArea(value)}"></c:set>
		<c:forEach items="${map.brotherAreas}" var="areaMap">
			var data = {
				areas:eval('${elfn:toJSON(areaMap.value)}')
			};
			$('div[level="${areaMap.key}"]',$('.tab-content')).append(template('comment', data));
		</c:forEach>
		<c:forEach items="${map.selectedAreas}" var="check">
			$('a[kid="${check}"]').addClass('selected');
		</c:forEach>
		setValue('${value}');
		//加载完成之后触发事件
		eval('${load}("${empty value}")');
	});
	function clearSelected(tab,nextPanes){
		if(!!!tab.attr('level')){
			$('a',$('.tab-content')).removeClass("selected");
			$('div[level]:gt(0)',$('.tab-content')).html('');
		}else{
			$('a',tab).removeClass("selected");
			$('a',$('#hotable')).removeClass("selected");
			nextPanes.html('');
		}
	}
	function setValue(kid){
		var name = [],namestr;
		$('#cityArea a.selected').each(function(){
			name.push($(this).text());
			if(!!!$(this).closest('div.tab-pane').attr('level')){
				return false;
			}
		});
		$('#${id}').val(kid);
		namestr = !negatedParam('${multi}')?name[name.length-1]:name.join('/')
		$('#${lableId}').val(namestr).text(namestr);
		//执行选中事件
		eval('${selected}("'+kid+'","'+namestr+'")');
	}
	function findAreas(pid,nextPane){
		var data={};
		$('#cityTab a[href="#'+nextPane.attr('id')+'"]').tab('show');
		$.ajax({
		   type: "POST",
		   url: "${siteFullPath}/findAreas",
		   data: "parentId="+pid+"&level="+nextPane.attr('level'),
		   loading:{
			   container:nextPane
		   },
		   success: function(areas){
			   data.areas=areas;
			   nextPane.append(template('comment', data));
		   }
		});
	}
</script>