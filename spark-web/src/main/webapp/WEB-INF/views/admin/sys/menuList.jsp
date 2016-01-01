<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="main-menu" content="2"/>
<meta name="menu" content="menu-8"/>
<title>菜单列表</title>
<%@ include file="/WEB-INF/views/include/treetable.jsp" %>
	<script type="text/javascript" src="${ctxStatic }/venders/mustache.js"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			var tpl = $("#treeTableTpl").html().replace(/(\/\/\<!\-\-)|(\/\/\-\->)/g,"");
			var data = ${fns:toJson(menuList)}, rootId = "${not empty menu.id ? menu.id : '1'}"; //rootId=1 就隐藏了功能菜单这个项，0则显示
			addRow("#treeTableList", tpl, data, rootId, true);
			$("#treeTable").treeTable({expandLevel : 2});
		});
		function addRow(list, tpl, data, pid, root){
			for (var i=0; i<data.length; i++){
				var row = data[i];
				//if (($~{fns:jsGetVal('row.parentId')}) == pid){
				if(row.parent.id == pid){
					$(list).append(Mustache.render(tpl, {
						dict: {
							type: '--'//getDictLabel($~{fns:toJson(fns:getDictList('sys_office_type'))}, row.type)
						}, pid: (root?0:pid), row: row
					}));
					addRow(list, tpl, data, row.id);
				}
			}
		}
	</script>
</head>
<body>
<div class="console-container">
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
              <h4>菜单列表</h4>
            </div>
            <div class="pull-right">
              <a class="btn btn-default">
                <i class="glyphicon glyphicon-refresh"></i>
                刷新
              </a>
              <a href="${ctxAdmin }/sys/menu/properties" class="btn btn-primary">添加菜单</a>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div class="row">
    	<div class="col-sm-12">
    		<table id="treeTable" class="table table-hover">
				<thead>
					<tr>
						<th>名称</th>
						<th>链接</th>
						<th>排序</th>
						<th>可见</th>
						<th>权限标识</th>
						<th class="text-right">操作</th>
					</tr>
				</thead>
				<tbody id="treeTableList"></tbody>
				<%-- <tbody>
					<c:forEach items="${menuList }" var="menu">
						<tr id="menu_${menu.id }">
							<td><a href="${ctxAdmin }/sys/menu/properties/${menu.id }">${menu.name }</a></td>
							<td>${menu.url }</td>
							<td>${menu.sort }</td>
							<td>${menu.isShow }</td>
							<td>${menu.permission }</td>
							<td class="text-right">修改 ｜ 删除 ｜ 添加下级菜单</td>
						</tr>
					</c:forEach>
				</tbody>
				<tfoot>
					<tr>
						<td colspan="6"></td>
					</tr>
				</tfoot> --%>
			</table>
			<script type="text/template" id="treeTableTpl">
			<tr id="{{row.id}}" pId="{{pid}}">
				<td><a href="${ctxAdmin }/sys/menu/properties/{{row.id}}">{{row.name}}</a></td>
				<td>{{row.url}}</td>
				<td>{{row.sort}}</td>
				<td>{{row.isShow}}</td>
				<td>{{row.permission}}</td>
				<td class="text-right">修改 ｜ 删除 ｜ 添加下级菜单</td>
			</tr>
			</script>
    	</div>
  	</div>
</div>
</body>
</html>