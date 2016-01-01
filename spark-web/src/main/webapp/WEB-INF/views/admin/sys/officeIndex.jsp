<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="main-menu" content="2"/>
<meta name="menu" content="menu-5"/>
<title>菜单列表</title>
<%@ include file="/WEB-INF/views/include/treeview.jsp" %>
</head>
<body>
<div class="console-container" style="height: 100%;">
	
	<div class="row"  style="height: 100%;">
		<div class="col-sm-2"  style="height: 100%;">
			<div class="panel panel-default"  style="height: 90%; margin-top: 15px;">
				<div class="panel-heading"><h3 class="panel-title">组织</h3></div>
				<div class="panel-body" style="padding:8px;">
					<div id="ztree" class="ztree"></div>
				</div>
			</div>
		</div>
		<div class="col-sm-10" style="height: 100%;">
			<iframe id="officeContent" src="${ctxAdmin}/sys/office/list?id=&parentIds=" width="100%" height="91%" frameborder="0"></iframe>
		</div>
	</div>
	<script>
	var setting = {data:{simpleData:{enable:true,idKey:"id",pIdKey:"pid",rootPId:'0'}},
		callback:{onClick:function(event, treeId, treeNode){
				var id = treeNode.pid == '0' ? '' :treeNode.pid;
				$('#officeContent').attr("src","${ctxAdmin}/sys/office/list?id="+id+"&parentIds="+treeNode.pIds);
			}
		}
	};
	
	function refreshTree(){
		$.getJSON("${ctxAdmin}/sys/office/treeData",function(data){
			//console.log($.fn.zTree);
			$.fn.zTree.init($("#ztree"), setting, data).expandAll(true);
		});
	}
	refreshTree();
	</script>
</div>
</body>
</html>