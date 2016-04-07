<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include/taglib.jsp"%>
<div style="display:none;" id="rocket-to-top">
	<div style="opacity:0;display:block;" class="level-2"></div>
	<div class="level-3"></div>
	<i class="ace-icon fa fa-times close-top"></i>
</div>
<div id="dialog-delete-confirm" class="hide">
	<div class="alert alert-info bigger-110">
		这些数据将被永久删除，不能恢复。
	</div>

	<div class="space-6"></div>

	<p class="bigger-110 bolder center grey">
		<i class="ace-icon fa fa-hand-o-right blue bigger-120"></i>
		您确认吗?
	</p>
</div><!-- #dialog-confirm -->
<div id="dialog-template" class="hide">
</div><!-- #dialog-confirm -->
<!-- 百度分享代码 -->
<script>
	window._bd_share_config = {
	    "common": {
	        "bdSnsKey": {},
	        "bdText": "",
	        "bdMini": "2",
	        "bdMiniList": false,
	        "bdPic": "",
	        "bdStyle": "0",
	        "bdSize": "16"
	    },
	    "slide": {
	        "type": "slide",
	        "bdImg": "1",
	        "bdPos": "right",
	        "bdTop": "100"
	    },
	    /* "image": {
	        "viewList": ["qzone", "tsina", "tqq", "renren", "weixin"],
	        "viewText": "分享到：",
	        "viewSize": "16"
	    }, */
	    "selectShare": {
	        "bdContainerClass": null,
	        "bdSelectMiniList": ["qzone", "tsina", "tqq", "renren", "weixin"]
	    }
	};
	with(document) 0[(getElementsByTagName('head')[0] || body).appendChild(createElement('script')).src = 'http://bdimg.share.baidu.com/static/api/js/share.js?v=89860593.js?cdnversion=' + ~ ( - new Date() / 36e5)];
</script>