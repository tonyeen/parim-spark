<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<c:set var="ctxStatic" value="${pageContext.request.contextPath}/static"/>
<!DOCTYPE html>
<html class="login-page">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="decorator" content="blank"/>

    <link rel="stylesheet" href="${ctx }/static/admin/styles/main.css">
    <link rel="stylesheet" href="${ctx }/static/admin/styles/console.css">
    <link rel="stylesheet" href="${ctx }/static/admin/styles/admin.css">
    <script src="${ctx }/static/admin/scripts/vendor/modernizr.js"></script>
    
    <script src="${ctx }/static/admin/scripts/vendor.js"></script>
    <script src="${ctx }/static/admin/scripts/plugins.js"></script>
    
    <script src="${ctxStatic }/venders/jquery/jquery-1.8.3.min.js" type="text/javascript"></script>
    
    <link href="${ctxStatic }/venders/jquery-jbox/2.3/Skins/Bootstrap/jbox.min.css" rel="stylesheet" />
    <script src="${ctxStatic }/venders/jquery-jbox/2.3/jquery.jBox-2.3.js" type="text/javascript"></script>
<title>登录系统</title>
</head>
<body class="login-page">
<div class="login-page">
  <div class="login-box panel panel-default">
    <div class="panel-heading">
      <div class="panel-title text-center">登录系统</div>
    </div>
    <div class="panel-body">
      <div class="error">

      </div>
      <div class="row">
        <div class="col-md-12">
          <form class="form-horizontal" role="form" action="${ctx }/login" method="post">
            <div class="form-group">
              <label for="username" class="col-md-3 control-label text-right">用户名：</label>
              <div class="col-md-9">
                <input type="text" id="username" name="username" class="form-control" placeholder="请输入用户名"/>
              </div>
            </div>
            <div class="form-group">
              <label for="password" class="col-md-3 control-label text-right">密码：</label>
              <div class="col-md-9">
                <input type="password" id="password" name="password" class="form-control" placeholder="密码长度不小于8位"/>
              </div>
            </div>
            <div class="form-group">
              <div class="col-md-offset-3 col-md-9">
                <input type="checkbox"/>
                记住登录
              </div>
            </div>
            <div class="form-group">
              <div class="col-md-offset-3 col-md-9">
                <button type="submit" class="btn btn-primary col-md-12">登录</button>
              </div>
            </div>
          </form>
        </div>
      </div>
    </div>
  </div>
</div>
</body>
</html>