<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="elfn" uri="/WEB-INF/tld/eltags.tld" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags/"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>
<c:set var="adminFullPath" value="${contextPath}${elfn:getAdminPath()}"></c:set>
<c:set var="siteFullPath" value="${contextPath}${elfn:getSitePath()}"></c:set>
<c:set var="plugins" value="${elfn:getPlugins()}"></c:set>
<%
	request.setAttribute("constants", com.hplatform.core.common.util.ConstantsUtil.get());
%>