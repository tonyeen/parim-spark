<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="main-menu" content="system_management"/>
<meta name="menu" content="menu-site_management"/>
<title>站点列表</title>
<%@ include file="/WEB-INF/views/include/treetable.jsp" %>
	<script type="text/javascript" src="${ctxStatic }/venders/mustache.js"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			var tpl = $("#treeTableTpl").html().replace(/(\/\/\<!\-\-)|(\/\/\-\->)/g,"");
			var data = ${fns:toJson(sites)}, rootId = "${not empty site.id ? site.id : '0'}";
			//console.log(data)
			addRow("#treeTableList", tpl, data, rootId, true);
			$("#treeTable").treeTable({expandLevel : 2});
		});
		function addRow(list, tpl, data, pid, root){
			for (var i=0; i<data.length; i++){
				var row = data[i];
				//if (($~{fns:jsGetVal('row.parentId')}) == pid){
				if(row.parentId == pid){
					$(list).append(Mustache.render(tpl, {
						pid: (root?0:pid), row: row
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
              <h4>站点列表</h4>
            </div>
            <div class="pull-right">
              <a class="btn btn-default">
                <i class="glyphicon glyphicon-refresh"></i>
                刷新
              </a>
              <a href="${ctxAdmin }/sys/site/properties" class="btn btn-primary">添加站点</a>
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
						<th>简码</th>
						<th>描述</th>
						<th>创建人</th>
						<th>创建时间</th>
						<th class="text-right">操作</th>
					</tr>
				</thead>
				<tbody id="treeTableList"></tbody>
			</table>
			<script type="text/template" id="treeTableTpl">
			<tr id="{{row.id}}" pId="{{pid}}">
				<td><a href="${ctxAdmin }/sys/site/properties/{{row.id}}">{{row.name}}</a></td>
				<td>{{row.shortName}}</td>
				<td>{{row.description}}</td>
				<td>{{row.createdBy.firstName}}</td>
				<td>{{row.createDate}}</td>
				<td class="text-right">
					<a href="${ctxAdmin }/sys/site/properties/{{row.id}}">修改</a> 
					｜ <a href="${ctxAdmin }/sys/site/delete/{{row.id}}">删除</a>
					｜ <a href="${ctxAdmin }/sys/site/properties?parent_id={{row.id}}">添加子站点</td>
			</tr>
			</script>
    	</div>
  	</div>
</div>
</body>
</html>