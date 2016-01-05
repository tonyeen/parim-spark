<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>生成方案管理</title>
	<meta name="decorator" content="default"/>
	<meta name="main-menu" content="25"/>
	<meta name="menu" content="menu-29"/>
	<script type="text/javascript">
		$(document).ready(function() {
			
		});
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
	</script>
</head>
<body>
<div class="console-container">
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctxAdmin}/gen/genScheme/">生成方案列表</a></li>
		<%-- <shiro:hasPermission name="gen:genScheme:edit"> --%><li><a href="${ctxAdmin}/gen/genScheme/form">生成方案添加</a></li><%-- </shiro:hasPermission> --%>
	</ul>
	<form:form id="searchForm" modelAttribute="genScheme" action="${ctxAdmin}/gen/genScheme/" method="post" class="breadcrumb form-search">
		<label>方案名称 ：</label><form:input path="name" htmlEscape="false" maxlength="50" class="input-medium"/>
		&nbsp;<input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/>
	</form:form>
	<%-- <sys:message content="${message}"/> --%>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead><tr><th>方案名称</th><th>生成模块</th><th>模块名</th><th>功能名</th><th>功能作者</th>
			<%-- <shiro:hasPermission name="gen:genScheme:edit"> --%><th>操作</th><%-- </shiro:hasPermission> --%></tr></thead>
		<tbody>
		<c:forEach items="${page.content}" var="genScheme">
			<tr>
				<td><a href="${ctxAdmin}/gen/genScheme/form?id=${genScheme.id}">${genScheme.name}</a></td>
				<td>${genScheme.packageName}</td>
				<td>${genScheme.moduleName}${not empty genScheme.subModuleName?'.':''}${genScheme.subModuleName}</td>
				<td>${genScheme.functionName}</td>
				<td>${genScheme.functionAuthor}</td>
				<%-- <shiro:hasPermission name="gen:genScheme:edit"> --%><td>
    				<a href="${ctxAdmin}/gen/genScheme/form?id=${genScheme.id}">修改</a>
					<a href="${ctxAdmin}/gen/genScheme/delete?id=${genScheme.id}" onclick="return confirmx('确认要删除该生成方案吗？', this.href)">删除</a>
				    <a href="${ctxAdmin}/gen/genScheme/generate/step1?id=${genScheme.id}">生成代码</a>
				</td><%-- </shiro:hasPermission> --%>
			</tr>
		</c:forEach>
		</tbody>
	</table>
</div>
</body>
</html>
