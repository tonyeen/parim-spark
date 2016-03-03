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
    
    <%-- <script src="${ctxStatic }/venders/jquery/jquery-1.8.3.min.js" type="text/javascript"></script> --%>
    <script src="${ctx }/static/admin/scripts/vendor.js"></script>
    <script src="${ctx }/static/admin/scripts/plugins.js"></script>
    
    
    <script src="${ctxStatic }/venders/jquery/jquery-migrate-1.2.1.js"></script>
    <link href="${ctxStatic }/venders/jquery-jbox/2.3/Skins/Bootstrap/jbox.min.css" rel="stylesheet" />
    <script src="${ctxStatic }/venders/jquery-jbox/2.3/jquery.jBox-2.3.js" type="text/javascript"></script>
    
    <style type="text/css">
		.topbar-btn.active{background-color: #0086b3;}
	</style>
	<sitemesh:head/>
</head>
<body>
	<!--[if lt IE 10]>
      <p class="browsehappy">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> to improve your experience.</p>
    <![endif]-->
    <c:set var="mainMenu" scope="request"> 
		<sitemesh:getProperty property='meta.main-menu' />
	</c:set>
    
    <div class="viewFramework-topbar">
	  <%@include file="/WEB-INF/layouts/admin/header.jsp" %>
	</div>
	<div class="viewFramework-body viewFramework-sidebar-full">
	  <div class="viewFramework-sidebar">
	    <%@include file="/WEB-INF/layouts/admin/sidebar.jsp" %>
	  </div>
	  <div class="viewFramework-product">
	    <div class="viewFramework-product-body">
	      <sitemesh:body/>
	    </div>
	  </div>
	</div>
	<%@include file="/WEB-INF/layouts/admin/footer.jsp" %>
	
	<c:if test="${not empty message }">
	<div id="_backMessageBox" class="hide">
	   ${message }
	</div>
	<script>
	   
	</script>
	</c:if>
	
	<c:set var="selectedMenu" scope="request"> 
		<sitemesh:getProperty property='meta.menu' />
	</c:set>
	<script type="text/javascript">
		var SELECTED_MENU="${selectedMenu }";
		$(function(){
			if(SELECTED_MENU==""){
				$(".topbar-home-link").addClass("active");
			}
			setActiveMenu(SELECTED_MENU);
		});
	</script>
	
    <script src="${ctx }/static/admin/scripts/main.js"></script>
    
	
</body>
</html>