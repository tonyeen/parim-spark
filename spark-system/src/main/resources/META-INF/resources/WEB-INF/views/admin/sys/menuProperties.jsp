<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="main-menu" content="2"/>
<meta name="menu" content="menu-8"/>
<title>菜单属性</title>
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
              <h4>${not empty menu.id?'修改':'添加'}菜单</h4>
            </div>
            <div class="pull-right">
              <a class="btn btn-default" href="${ctxAdmin }/sys/menu/">
                <i class="glyphicon glyphicon-refresh"></i>
                返回菜单列表
              </a>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div class="row">
    	<div class="col-sm-12">
    		<div class="alert alert-info">
    		  <button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
              <i class="fa fa-info-circle sign"></i><strong>提示：</strong> 请完善以下信息！
            </div>
			<form:form id="inputForm" modelAttribute="menu" action="${ctxAdmin }/sys/menu/save" method="post" class="form-horizontal">
				<form:hidden path="id"/>
				<div class="form-group">
					<label class="col-sm-4 control-label">上级菜单:</label>
					<div class="col-sm-4 controls">
		                <sys:treeselect id="menu" name="parent.id" value="${empty menu.parent.id? 1:menu.parent.id}" labelName="parent.name" labelValue="${menu.parent.name}"
							title="菜单" url="${ctxAdmin }/sys/menu/treeData" simpleData="true" extId="${menu.id}" cssClass="required" required="true"/>
							<span class="error ${empty ERR_parentName ? 'hide':'' }">${ERR_parentName }</span>
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-4 control-label"><font color="red">*</font> 名称:</label>
					<div class="col-sm-4 controls">
						<form:input path="name" htmlEscape="false" maxlength="50" class="form-control required input-xlarge" required="true"/>
						<span class="error ${empty ERR_name ? 'hide':'' }">${ERR_name }</span>
						<span class="help-inline"></span>
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-4 control-label">链接:</label>
					<div class="col-sm-8 controls">
						<form:input path="url" htmlEscape="false" maxlength="2000" class="input-xxlarge"/>
						<span class="error ${empty ERR_url ? 'hide':'' }">${ERR_url }</span>
						<span class="help-inline">点击菜单跳转的页面</span>
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-4 control-label">目标:</label>
					<div class="col-sm-8 controls">
						<form:input path="target" htmlEscape="false" maxlength="10" class="input-small"/>
						<span class="help-inline">链接地址打开的目标窗口，默认：mainFrame</span>
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-4 control-label">图标:</label>
					<div class="col-sm-8 controls">
					<sys:iconselect id="icon" name="icon" value="${menu.icon}"/>
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-4 control-label">排序:</label>
					<div class="col-sm-8 controls">
						<form:input path="sort" value="${empty sort ? 10 : sort }" htmlEscape="false" maxlength="50" class="required digits input-small"/>
						<span class="error ${empty ERR_sort ? 'hide':'' }">${ERR_sort }</span>
						<span class="help-inline">排列顺序，升序。</span>
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-4 control-label">可见:</label>
					<div class="col-sm-8 controls">
						<form:radiobuttons path="isShow" items="${fns:getDictList('show_hide') }" itemLabel="label" itemValue="value" htmlEscape="false" class="required"/>
						<span class="help-inline">该菜单或操作是否显示到系统菜单中</span>
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-4 control-label">权限标识:</label>
					<div class="col-sm-8 controls">
						<form:input path="permission" htmlEscape="false" maxlength="100" class="input-xxlarge"/>
						<span class="help-inline">控制器中定义的权限标识，如：@RequiresPermissions("权限标识")</span>
					</div>
				</div>
				<%-- <div class="control-group">
					<label class="col-sm-4 control-label">备注:</label>
					<div class="col-sm-8 controls">
						<form:textarea path="remarks" htmlEscape="false" rows="3" maxlength="200" class="input-xxlarge"/>
					</div>
				</div> --%>
				<div class="form-actions col-sm-offset-4">
					<shiro:hasPermission name="sys:menu:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
					<input type="submit" class="btn btn-primary" value="保存">
					<c:if test="${not empty menu.id}">
					   <a class="btn btn-danger" href="${ctxAdmin }/sys/menu/delete/${menu.id }">删除</a>
					</c:if>
					
					<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
				</div>
			</form:form>
		</div>
	</div>
</div>
<script type="text/javascript">
(function($){
	function validForm(){
		$("#inputForm").validate();
	}
	
	$(function(){
		validForm();
	});
})(jQuery);
</script>			
</body>
</html>