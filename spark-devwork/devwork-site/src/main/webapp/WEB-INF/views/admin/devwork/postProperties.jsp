<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="main-menu" content="devwork"/>
<meta name="menu" content="menu-dev_post_list"/>
<title>开发者空间-项目属性</title>
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
              <h4>${not empty post.id?'修改':'添加'}</h4>
            </div>
            <div class="pull-right">
              <a class="btn btn-default" href="${ctxAdmin }/devwork/post/list">
                <i class="glyphicon glyphicon-refresh"></i>
                返回项目列表
              </a>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div class="row">
    	<div class="col-sm-12">							
    		<form:form id="inputForm" modelAttribute="post" action="${ctxAdmin }/devwork/post/save" method="post" class="form-horizontal">
    			<form:hidden path="id"/>
    			<div class="form-group">
    				<label class="control-label col-sm-3"><span class="red">*</span> 标题(title)</label>
    				<div class="col-sm-9 row">
    					<form:input path="title" class="col-lg-5 col-sm-5" required="true"/>
    					<span class="help-inline col-lg-7 col-sm-7"></span>
    				</div>
    			</div>
    			<div class="form-group">
    				<label class="control-label col-sm-3"><span class="red">*</span> 公共标识(publicSlug)</label>
    				<div class="col-sm-9 row">
    					<form:input path="publicSlug" class="col-lg-5 col-sm-5" required="true"/>
    					<span class="help-inline col-lg-7 col-sm-7"></span>
    				</div>
    			</div>
    			<div class="form-group">
    				<label class="control-label col-sm-3"><span class="red">*</span> 策略(category)</label>
    				<div class="col-sm-9 row">
    					<form:input path="category" class="col-lg-5 col-sm-5" required="true"/>
    					<span class="help-inline col-lg-7 col-sm-7"></span>
    				</div>
    			</div>
    			<div class="form-group">
    				<label class="control-label col-sm-3"><span class="red">*</span>原材料(rawContent)</label>
    				<div class="col-sm-9 row">
    					<form:input path="rawContent" class="col-lg-5 col-sm-5" required="true"/>
    					<span class="help-inline col-lg-7 col-sm-7"></span>
    				</div>
    			</div>
    			<div class="form-group">
    				<label class="control-label col-sm-3"><span class="red">*</span>呈现出来的内容(renderedContent)</label>
    				<div class="col-sm-9 row">
    					<form:input path="renderedContent" class="col-lg-5 col-sm-5" required="true"/>
    					<span class="help-inline col-lg-7 col-sm-7"></span>
    				</div>
    			</div>
    			<div class="form-group">
    				<label class="control-label col-sm-3"><span class="red">*</span>渲染概要(renderedSummary)</label>
    				<div class="col-sm-9 row">
    					<form:input path="renderedSummary" class="col-lg-5 col-sm-5" required="true"/>
    					<span class="help-inline col-lg-7 col-sm-7"></span>
    				</div>
    			</div>
    			<div class="form-group">
                    <label class="col-sm-4 control-label"><!-- <span class="red">*</span> --> 广播信息(broadcast)</label>
                    <div class="col-sm-8 controls">
                        <form:radiobuttons path="broadcast" items="${fns:getDictList('show_hide') }" itemLabel="label" itemValue="value" htmlEscape="false" class="required"/>
                        <span class="help-inline"></span>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-4 control-label"><!-- <span class="red">*</span> --> 草稿(draft)</label>
                    <div class="col-sm-8 controls">
                        <form:radiobuttons path="draft" items="${fns:getDictList('show_hide') }" itemLabel="label" itemValue="value" htmlEscape="false" class="required"/>
                        <span class="help-inline"></span>
                    </div>
                </div>
    			<div class="form-group">
    				<button type="submit" class="btn btn-primary col-sm-offset-3">保存</button>
    			</div>
    		</form:form>
    	</div>
    </div>
</div>
</body>
</html>	