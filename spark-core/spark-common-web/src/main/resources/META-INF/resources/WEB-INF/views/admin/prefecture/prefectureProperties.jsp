<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="main-menu" content="2"/>
<meta name="menu" content="menu-8"/>
<title>专区属性</title>
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
              <h4>${not empty prefecture.id?'修改':'添加'}</h4>
            </div>
            <div class="pull-right">
              <a class="btn btn-default" href="${ctxAdmin }/prefecture/">
                <i class="glyphicon glyphicon-refresh"></i>
                返回专区列表
              </a>
            </div>
          </div>
        </div>
      </div>
    </div>
    
    <div class="row">
    	<div class="col-sm-12">
    		<form:form id="inputForm" modelAttribute="prefecture" action="${ctxAdmin }/prefecture/save" method="post" class="form-horizontal">
				<form:hidden path="id"/>
    			<div class="form-group">
					<label class="col-sm-3 control-label"><font color="red">*</font> 名称:</label>
					<div class="col-sm-9">
						<form:input path="name" htmlEscape="false" maxlength="50" class="col-xs-10 col-sm-5 required"/>
						<span class="help-inline col-xs-12 col-sm-7">
							名称必填${ERR_name }
						</span>
					</div>
				</div>
				
				<div class="clearfix form-actions">
					<div class="col-md-offset-3 col-md-9">
						<button class="btn btn-info" type="submit">
							<i class="ace-icon fa fa-check bigger-110"></i>
							Submit
						</button>

						&nbsp; &nbsp; &nbsp;
						<button class="btn" type="reset">
							<i class="ace-icon fa fa-undo bigger-110"></i>
							Reset
						</button>
					</div>
				</div>
    		</form:form>
    	</div>
    </div>	
</div>
</body>
</html>