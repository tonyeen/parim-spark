<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="main-menu" content="system_management"/>
<meta name="menu" content="menu-users_management"/>
<title>菜单列表</title>
<%@ include file="/WEB-INF/views/include/treeview.jsp" %>
</head>
<body>
<div class="console-container" style="height: 100%;">
	
	<div class="row"  style="height: 100%;">
		<div class="col-sm-2"  style="height: 100%;">
			<div class="panel panel-default"  style="height: 90%; margin-top: 15px;">
				<div class="panel-heading"><h3 class="panel-title">组织</h3></div>
				<div class="panel-body" style="padding: 0px;">
				    <div class="toolbar" style="background: #eee; padding: 5px 8px;">
				        <a href="#" class=""><img src="${ctxStatic}/admin/images/site.png"/></a>
				        <a href="#" class=""><img src="${ctxStatic}/admin/images/org.png"/></a>
				    </div>
					<div id="ztree" class="ztree" style="padding:8px;"></div>
				</div>
			</div>
		</div>
		<div class="col-sm-10" style="height: 100%;">
		    <div class="row hide" style="margin-top: 15px;">
		      <div class="col-sm-12">
		        <ul class="nav nav-pills">
		            <li class="active"><a href="#">属性</a></li>
		            <li><a href="#">目标</a></li>
		            <li><a href="#">许可</a></li>
		            <li><a href="#">用户管理</a></li>
		            <li role="presentation" class="dropdown">
		                <a class="dropdown-toggle" data-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false">
		                              更多... <span class="caret"></span>
		                </a>
		                <ul class="dropdown-menu">
		                 <li><a href="#">折扣率</a></li>
		                 <li><a href="#">预付学费订单</a></li>
		                </ul>
		              </li>
		        </ul>
		      </div>
		    </div>
			<iframe id="orgContent" src="${ctxAdmin}/sys/user/list?id=&parentIds=" width="100%" height="91%" frameborder="0"></iframe>
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
                    var type = treeNode.objectType == '' ? '':treeNode.objectType;
                    $('#orgContent').attr("src","${ctxAdmin}/sys/user/list?id="+id+"&objectType="+type);
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