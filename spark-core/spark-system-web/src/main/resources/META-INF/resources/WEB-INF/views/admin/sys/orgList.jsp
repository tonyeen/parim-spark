<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<%-- <meta name="main-menu" content="2"/>
	<meta name="menu" content="menu-5"/> --%>
	<meta name="decorator" content="admin-blank"/>
	<title>组织机构列表</title>
	<%@ include file="/WEB-INF/views/include/treetable.jsp" %>
	<script type="text/javascript" src="${ctxStatic }/venders/mustache.js"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			var tpl = $("#treeTableTpl").html().replace(/(\/\/\<!\-\-)|(\/\/\-\->)/g,"");
			var data = ${fns:toJson(orgs)}, rootId = "${not empty org.id ? org.id : '0'}";
			addRow("#treeTableList", tpl, data, rootId, true);
			$("#treeTable").treeTable({expandLevel : 1});
		});
		function addRow(list, tpl, data, pid, root){
			for (var i=0; i<data.length; i++){
				var row = data[i];
				//if (($~{fns:jsGetVal('row.parentId')}) == pid){
				if(row.parentId == pid){
					$(list).append(Mustache.render(tpl, {
						dict: {
							type: '--'//getDictLabel($~{fns:toJson(fns:getDictList('sys_org_type'))}, row.type)
						}, pid: (root?0:pid), row: row
					}));
					addRow(list, tpl, data, row.id);
				}
			}
		}
	</script>
</head>
<body>
<div class="console-container" style="height: 100%;">
	<div class="row">
      <div class="col-sm-12">
        <div class="console-global-notice">
          <div class="console-global-notice-list">
            <!-- TODO: 由通知模块实时填充 -->
            <!-- 单个通知的样式模板暂时还没有采集到，留后补充 -->
            ${message }
          </div>
          <div class="console-title console-title-border clearfix">
            <div class="pull-left">
              <h4>组织机构列表</h4>
            </div>
            <div class="pull-right">
              <a class="btn btn-default">
                <i class="glyphicon glyphicon-refresh"></i>
                刷新
              </a>
              <a href="${ctxAdmin }/sys/org/properties" class="btn btn-primary">添加组织</a>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div class="row">
    	<div class="col-sm-12">
			<table id="treeTable" class="table table-striped table-bordered table-condensed">
				<thead><tr><th>机构名称</th><th>归属区域</th><th>机构编码</th><th>机构类型</th><th>备注</th><%-- <shiro:hasPermission name="sys:org:edit"> --%><th>操作</th><%-- </shiro:hasPermission> --%></tr></thead>
				<tbody id="treeTableList"></tbody>
			</table>
	<script type="text/template" id="treeTableTpl">
		<tr id="{{row.id}}" pId="{{pid}}">
			<td><a href="${ctxAdmin}/sys/org/properties/{{row.id}}">{{row.name}}</a></td>
			<td>{{row.area.name}}</td>
			<td>{{row.code}}</td>
			<td>{{dict.type}}</td>
			<td>{{row.remarks}}</td>
			<td>
				<a href="${ctxAdmin}/sys/org/properties/{{row.id}}">修改</a>
				<a href="${ctxAdmin}/sys/org/delete/{{row.id}}" onclick="return confirmx('要删除该机构及所有子机构项吗？', this.href)">删除</a>
				<a href="${ctxAdmin}/sys/org/form?parent.id={{row.id}}">添加下级机构</a> 
			</td>
		</tr>
	</script>
	<!-- <shiro:hasPermission name="sys:org:edit"><td>
                <a href="${ctx}/sys/org/form?id={{row.id}}">修改</a>
                <a href="${ctx}/sys/org/delete?id={{row.id}}" onclick="return confirmx('要删除该机构及所有子机构项吗？', this.href)">删除</a>
                <a href="${ctx}/sys/org/form?parent.id={{row.id}}">添加下级机构</a> 
            </td></shiro:hasPermission> -->
		</div>
	</div>
</div>
</body>
</html>