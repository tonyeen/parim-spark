<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>业务表管理</title>
	<meta name="decorator" content="default"/>
	<meta name="main-menu" content="25"/>
	<meta name="menu" content="menu-29"/>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#comments").focus();
			$("#inputForm").validate({
				submitHandler: function(form){
					loading('正在提交，请稍等...');
					$("input[type=checkbox]").each(function(){
						$(this).after("<input type=\"hidden\" name=\""+$(this).attr("name")+"\" value=\""
								+($(this).attr("checked")?"1":"0")+"\"/>");
						$(this).attr("name", "_"+$(this).attr("name"));
					});
					form.submit();
				},
				errorContainer: "#messageBox",
				errorPlacement: function(error, element) {
					$("#messageBox").text("输入有误，请先更正。");
					if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append")){
						error.appendTo(element.parent().parent());
					} else {
						error.insertAfter(element);
					}
				}
			});
		});
	</script>
</head>
<body>
	<div class="console-container">
	    <sys:message content="${message }" type="${message.type }"></sys:message>
		<form:form id="inputForm" modelAttribute="genScheme" action="${ctxAdmin}/gen/genScheme/generate/step2" method="post" class="form-horizontal">
			<form:hidden path="id"/>
			<%-- <sys:message content="${message}"/> --%>
			<br/>
			<div class="control-group">
				<label class="control-label">项目路径:</label>
				<div class="controls">
					<form:input path="projectDir"/>
				</div>
				<div class="form-actions">
					<input id="btnSubmit" class="btn btn-primary" type="submit" value="生成"/>&nbsp;
					<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
				</div>
			</div>
		</form:form>
	</div>
</body>
</html>
