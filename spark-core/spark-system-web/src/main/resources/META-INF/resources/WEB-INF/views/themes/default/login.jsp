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
	<script type="text/javascript">
    	var _ctx = '${ctx}';
    </script>
    <link rel="stylesheet" href="${ctx }/static/admin/styles/main.css">
    <link rel="stylesheet" href="${ctx }/static/admin/styles/console.css">
    <link rel="stylesheet" href="${ctx }/static/admin/styles/admin.css">
    <script src="${ctx }/static/admin/scripts/vendor/modernizr.js"></script>
    
    <script src="${ctx }/static/admin/scripts/vendor.js"></script>
    <script src="${ctx }/static/admin/scripts/plugins.js"></script>
    
    <script src="${ctxStatic }/venders/jquery/jquery-1.8.3.min.js" type="text/javascript"></script>
    
    <link href="${ctxStatic }/venders/jquery-jbox/2.3/Skins/Bootstrap/jbox.min.css" rel="stylesheet" />
    <script src="${ctxStatic }/venders/jquery-jbox/2.3/jquery.jBox-2.3.js" type="text/javascript"></script>
    <script src="${ctxStatic }/sys/login.js" type="text/javascript"></script>
    <script type="text/javascript" src="${ctx}/static/venders/jquery-validation/1.11.1/jquery.validate.min.js"></script>
	<script type="text/javascript" src="${ctx}/static/venders/jquery-validation/1.11.1/messages_bs_zh.js"></script>
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
      <div class="">
        <div class="col-md-12">
          <form class="form-horizontal" id="dataForm" role="form" action="${ctx }/login" method="post">
            <div class="form-group">
              <label for="username" class="sr-only control-label text-right">用户名：</label>
              <div class="input-group input-group-lg">
                <span class="input-group-addon"><i class="glyphicon glyphicon-envelope"></i></span>
                <input type="text" id="username" name="username" class="form-control required"  placeholder="请输入用户名"/>
              </div>
            </div>
            <div class="form-group">
              <label for="password" class="sr-only control-label text-right">密码：</label>
              <div class="input-group input-group-lg">
                <span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
                <input type="password" id="password" name="password" class="form-control required " minlength="5" placeholder="密码长度不小于8位"/>
              </div>
            </div>
            <div class="form-group row">
              <label for="password" class="sr-only control-label text-right">验证码：</label>
              <div class="input-group input-group-lg">
                
                <div class="col-xs-8"> <input type="text" id="code" name="code" class="form-control required" minlength="4" placeholder="请输入验证码"/></div>
                <div class="col-xs-4"> <img id="code-img"  src="${ctx}/kaptcha.jpg"></div>
                
              </div>
            </div>
            <div class="form-group">
              <div class="">
                <label><input type="checkbox" class=""/>记住登录</label>
              </div>
            </div>
            <div class="form-group">
              <div class="">
                <button type="submit" class="btn btn-primary btn-block btn-lg">登&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;录</button>
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