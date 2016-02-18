<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="main-menu" content="2"/>
<meta name="menu" content="menu-24"/>
<title>站点属性</title>
</head>
<body>
<div class="console-container">
	<div class="row">
      <div class="col-sm-12">
        <div class="console-global-notice">
          <div class="console-global-notice-list">
            <!-- TODO: 由通知模块实时填充 -->
            <!-- 单个通知的样式模板暂时还没有采集到，留后补充 -->
          </div>
          <div class="console-title console-title-border clearfix">
            <div class="pull-left">
              <h4>${not empty site.id?'修改':'添加'}</h4>
            </div>
            <div class="pull-right">
              <a class="btn btn-default" href="${ctxAdmin }/sys/site/list?id=">
                <i class="glyphicon glyphicon-refresh"></i>
                返回站点列表
              </a>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div class="row">
    	<div class="col-sm-12">
    		<form:form id="inputForm" modelAttribute="site" action="${ctxAdmin }/sys/site/save" method="post" class="form-horizontal">
    			<form:hidden path="id"/>
    			<div class="form-group">
    				<label class="control-label col-sm-3">上级站点</label>
    				<div class="col-sm-9 row">
    					<div class="col-lg-3 col-sm-4 row">
    					<sys:treeselect id="siteselect" name="parent.id" value="${site.parent.id}" labelName="parent.name" labelValue="${site.parent.name}"
							title="站点" url="${ctxAdmin }/sys/site/treeSelectData" extId="${site.id}" cssClass="required"/>
						</div>	
    					<span class="help-inline col-lg-7 col-sm-7">选择上级站点</span>
    				</div>
    			</div>
    			<div class="form-group">
    				<label class="control-label col-sm-3"><span class="red">*</span> 站点名称</label>
    				<div class="col-sm-9 row">
    					<form:input path="name" class="col-lg-5 col-sm-5"/>
    					<span class="help-inline col-lg-7 col-sm-7"></span>
    				</div>
    			</div>
    			<div class="form-group">
    				<label class="control-label col-sm-3">站点短名称</label>
    				<div class="col-sm-9 row">
    					<form:input path="shortName" class="col-lg-5 col-sm-5"/>
    					<span class="help-inline col-lg-7 col-sm-7">必须是英文字母、数字和下划线组成</span>
    				</div>
    			</div>
    			<div class="form-group">
    				<label class="control-label col-sm-3">描述</label>
    				<div class="col-sm-9 row">
    					<form:textarea path="description" class="col-sm-7"/>
    					<span class="help-inline col-sm-10"></span>
    				</div>
    			</div>
    			<div class="form-group">
    				<button type="submit" class="btn btn-primary col-sm-offset-3">保存</button>
    				<c:if test="${not empty site.id }">
    				<a href="${ctxAdmin }/sys/site/delete/${site.id }" class="btn btn-danger">删除</a>
    				</c:if>
    				<c:if test="${empty site.id }">
    				<button type="button" click="" class="btn btn-info">保存并添加下一条</button>
    				</c:if>
    				<a href="${ctxAdmin }/sys/site/list?id=" class="btn btn-default"><i class="glyphicon glyphicon-refresh"></i>取消并返回列表</a>
    			</div>
    		</form:form>
    	</div>
    </div>
</div>
</body>
</html>	