<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="main-menu" content="system_management"/>
<meta name="menu" content="menu-system_user_group_management"/>
<title>菜单列表</title>
<%@ include file="/WEB-INF/views/include/treeview.jsp" %>
</head>
<body>
<div class="console-container" style="height: 100%;">
	
	<div class="row"  style="height: 100%;">
		<div class="col-sm-2"  style="height: 100%; min-width: 200px;">
			<div class="panel panel-default"  style="height: 90%; margin-top: 15px;">
				<div class="panel-heading"><h3 class="panel-title">组织</h3></div>
				<div class="panel-body" style="padding:8px;">
					<div id="ztree" class="ztree"></div>
				</div>
			</div>
		</div>
		<div class="col-sm-10" style="height: 100%;">
			<iframe id="orgContent" src="${ctxAdmin}/sys/org/list?id=&parentIds=" width="100%" height="91%" frameborder="0"></iframe>
		</div>
	</div>
	<script>
	function setIcon(responseData){
		if (responseData) {
          for(var i =0; i < responseData.length; i++) {
              if(responseData[i].objectType == 'S'){
                  //responseData[i].iconSkin = "glyphicon glyphicon-home ";
                  responseData[i].icon = "${ctxStatic}/admin/images/site.png";
              }
              if(responseData[i].objectType == 'O'){
                  //responseData[i].iconSkin = "glyphicon glyphicon-folder-open ";
                  responseData[i].icon = "${ctxStatic}/admin/images/org.png";
              }
          }
        }
        return responseData;
	}
	
	function ajaxDataFilter(treeId, parentNode, responseData) {
	    if (responseData) {
	      for(var i =0; i < responseData.length; i++) {
	    	  
	      }
	      responseData = setIcon(responseData);
	    }
	    return responseData;
	}
	
	var setting = {
			async: {
				enable: true,
				autoParam: ['id'],
				url: "${ctxAdmin}/sys/userGroupTree/children",
				dataFilter: ajaxDataFilter
			},
			data:{simpleData:{enable:false,idKey:"id",pIdKey:"pid",rootPId:'0'}},
			callback:{
				onClick:function(event, treeId, treeNode){
					var id = treeNode.id == '0' ? '' :treeNode.id;
					$('#orgContent').attr("src","${ctxAdmin}/sys/org/list?id="+id+"&parentIds="+treeNode.pIds);
				}
			}
		};
	
	function refreshTree(){
		$.getJSON("${ctxAdmin}/sys/userGroupTree/roots",function(data){
			data = setIcon(data);
			console.log(data);
			var orgTree = $.fn.zTree.init($("#ztree"), setting, data);
			//orgTree.expandAll(true);
			orgTree.expandNode(orgTree.getNodes()[0]);
		});
	}
	refreshTree();
	</script>
</div>
</body>
</html>