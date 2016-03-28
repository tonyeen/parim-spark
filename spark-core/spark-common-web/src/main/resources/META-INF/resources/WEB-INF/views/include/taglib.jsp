<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tagss" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fns" uri="/WEB-INF/tlds/fns.tld" %>
<%@ taglib prefix="sys" tagdir="/WEB-INF/tags/sys" %>
<%@ taglib prefix="page" tagdir="/WEB-INF/tags/page" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<c:set var="ctxAdmin" value="${pageContext.request.contextPath}/admin"/>
<c:set var="ctxStatic" value="${pageContext.request.contextPath}/static"/>