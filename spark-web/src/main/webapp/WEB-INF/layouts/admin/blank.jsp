<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ taglib prefix="sitemesh" uri="http://www.opensymphony.com/sitemesh/decorator" %>
<!DOCTYPE html>
<html style="overflow-x:auto;overflow-y:auto;">
<head>
	<title>管理控制台：<sitemesh:title/></title>
	<meta name="description" content="管理控制台">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    
    <link rel="stylesheet" href="${ctx }/static/admin/styles/main.css">
    <link rel="stylesheet" href="${ctx }/static/admin/styles/console.css">
    <link rel="stylesheet" href="${ctx }/static/admin/styles/admin.css">
    <script src="${ctx }/static/admin/scripts/vendor/modernizr.js"></script>
    
    <script src="${ctx }/static/admin/scripts/vendor.js"></script>
    <script src="${ctx }/static/admin/scripts/plugins.js"></script>
    
    <script src="${ctxStatic }/venders/jquery/jquery-1.8.3.min.js" type="text/javascript"></script>
    
    <link href="${ctxStatic }/venders/jquery-jbox/2.3/Skins/Bootstrap/jbox.min.css" rel="stylesheet" />
	<script src="${ctxStatic }/venders/jquery-jbox/2.3/jquery.jBox-2.3.js" type="text/javascript"></script>
    
	<sitemesh:head/>
</head>
<body>
	  <div class="viewFramework-product">
	    <div class="viewFramework-product-body">
	      <sitemesh:body/>
	    </div>
	  </div>
	
    <script src="${ctx }/static/admin/scripts/main.js"></script>
    
</body>
</html>