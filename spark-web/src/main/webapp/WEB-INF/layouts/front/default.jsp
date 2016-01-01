<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ taglib prefix="sitemesh" uri="http://www.opensymphony.com/sitemesh/decorator" %>
<!DOCTYPE html>
<html style="overflow-x:auto;overflow-y:auto;">
<head>
	<title><sitemesh:title/></title>
	<%@include file="/WEB-INF/views/include/head.jsp" %>
	<%--@include file="/WEB-INF/views/${site.theme.basePath}${site.theme}layouts/head-meta.jsp" --%>
	<%@include file="/WEB-INF/views/themes/default/layouts/head-meta.jsp" %>
	<sitemesh:head/>
</head>
<body>
	<%@include file="/WEB-INF/views/themes/default/layouts/header.jsp" %>
	<sitemesh:body/>
	<%@include file="/WEB-INF/views/themes/default/layouts/footer.jsp" %>
</body>
</html>