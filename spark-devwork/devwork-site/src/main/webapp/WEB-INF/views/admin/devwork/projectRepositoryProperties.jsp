<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="main-menu" content="devwork"/>
<meta name="menu" content="menu-dev_project_repository_list"/>
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
              <h4>${not empty projectRepository.id?'修改':'添加'}</h4>
            </div>
            <div class="pull-right">
              <a class="btn btn-default" href="${ctxAdmin }/devwork/projectRepository/list">
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
    		<form:form id="inputForm" modelAttribute="projectRepository" action="${ctxAdmin }/devwork/projectRepository/save" method="post" class="form-horizontal">
    			<form:hidden path="id"/>
    			<div class="form-group">
    				<label class="control-label col-sm-3"><span class="red">*</span> 名称(name)</label>
    				<div class="col-sm-9 row">
    					<form:input path="name" class="col-lg-5 col-sm-5" required="true"/>
    					<span class="help-inline col-lg-7 col-sm-7"></span>
    				</div>
    			</div>
    			<div class="form-group">
    				<label class="control-label col-sm-3"><span class="red">*</span> 路径(Url)</label>
    				<div class="col-sm-9 row">
    					<form:input path="Url" class="col-lg-5 col-sm-5" required="true"/>
    					<span class="help-inline col-lg-7 col-sm-7"></span>
    				</div>
    			</div>
    			<div class="form-group">
                    <label class="col-sm-4 control-label"><span class="red">*</span> 是否是快捷方式(snapshotsEnable)</label>
                    <div class="col-sm-8 controls">
                        <form:radiobuttons path="snapshotsEnable" items="${fns:getDictList('show_hide') }" itemLabel="label" itemValue="value" htmlEscape="false" class="required"/>
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