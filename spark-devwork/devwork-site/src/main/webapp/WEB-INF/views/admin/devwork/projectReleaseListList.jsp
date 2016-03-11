<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="main-menu" content="devwork"/>
<meta name="menu" content="menu-dev_project_releaseList_list"/>
<title>开发者空间-项目列表</title>
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
              <h4>项目列表</h4>
            </div>
            <div class="pull-right">
              <a class="btn btn-default" href="${ctxAdmin }/devwork/projectReleaseList/list">
                <i class="glyphicon glyphicon-refresh"></i>
                刷新
              </a>
              <a href="${ctxAdmin }/devwork/projectReleaseList/properties" class="btn btn-primary">添加项目发布数据</a>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div class="row">   
        <div class="col-sm-12">
            <form id="searchForm" class="form-inline" action="${ctxAdmin }/devwork/projectReleaseList/findone" style="margin: 15px 0;">
                <div class="form-group">
                    <label for="">版本号</label>
                    <input type="text" class="form-control" name="versionName" value="${projectReleaseList.versionName }" placeholder="请输入版本号">
                </div>
                <button type="submit" class="btn btn-default">搜索</button>
            </form>
        </div>
    </div>
    <div class="row">   
        <div class="col-sm-12">
            <table class="table table-hover" >
                <thead>
                    <tr id="tr">
                        <th>选择</th>
                        <th>版本号(versionName)</th>
                        <th>库号(reponsitoryId)</th>
                        <th>文档路径(apiDocUrl)</th>
                        <th>人造ID(artifactId)</th>
                        <th>分组编号(groupId)</th>
                        <th>关联文档路径(refDocUrl)</th>
                        <th>发布状态(releaseStatus)</th>
                        <th>是否当前(isCurrent)</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${projectReleaseLists.content }" var="projectReleaseList">
                        <tr id="projectReleaseList_${projectReleaseList.id }" >
                            <td><input type="checkbox" name="chk_list" value="${projectReleaseList.id}"></td>
                            <td><a href="${ctxAdmin }/devwork/projectReleaseList/properties/${projectReleaseList.id }">${projectReleaseList.versionName }</a></td>
                            <td>${projectReleaseList.reponsitoryId }</td>
                            <td>${projectReleaseList.apiDocUrl }</td>
                            <td>${projectReleaseList.artifactId }</td>
                            <td>${projectReleaseList.groupId }</td>
                            <td>${projectReleaseList.refDocUrl }</td>
                            <td>${projectReleaseList.releaseStatus }</td>
                            <c:if test="${projectReleaseList.isCurrent == true}">
                            <td>是</td>
                            </c:if>
                            <c:if test="${projectReleaseList.isCurrent == false}">
                            <td>否</td>
                            </c:if>
                            <td class="text-right">
                            	<a href="${ctxAdmin }/devwork/projectReleaseList/properties/${projectReleaseList.id }">修改</a>｜ 
                            	<a href="${ctxAdmin }/devwork/projectReleaseList/delete/${projectReleaseList.id }">删除</a> 
                            	</td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty projectReleaseLists.content }">
                    <tr><td colspan="14"><div class="inf-blank text-center" style="height: 200px; line-height: 200px;">
                        还没有项目，你可以点击“<a href="${ctxAdmin }/devwork/projectReleaseList/properties">添加项目发布</a>”。</div></td></tr>
                    </c:if>
                </tbody>
                <c:if test="${not empty projectReleaseLists.content }">
                <tfoot>
                    <tr>
                        <td colspan="14">
                        <page:formpage page="${projectReleaseLists}"/>
                        <a href="javascript:void(0)" name="checkAll">全选</a>
                        <button class="btn btn-success" id="addBtn">新增</button>
                        <button class="btn btn-danger" id="deleteBtn">删除</button>
                        </td>
                    </tr>
                </tfoot>
                </c:if>
            </table>
        </div>
    </div>
</div>
<script type="text/javascript">
		var id="";
		var arrChk;
		var count;
		/* //删除
		$("#deleteBtn").click(function(){
			var info0="请先选择一条数据用于删除！";
			var info1="请选择一条数据，不能同时删除多条！";
			check(info0,info1);
			if(count==1)
			{
				//取到被选中复选框的id
				 $(arrChk).each(function(){
				if($(this).attr("checked") == "checked")
					{
						id = $(this).val();
					}
				})
				location.href = "${ctxAdmin }/devwork/projectReleaseList/delete/"+id;
			return;
			}
		}) */
		//批量删除备份方法
		$("#deleteBtn").click(function(){
			count = 0;
			arrChk=$("input[name='chk_list']");
			$(arrChk).each(function(){
				if($(this).attr("checked") == "checked")
					{
					id=id+$(this).val()+",";
					count++;
					}
			})
			
				if(count == 0)
					{
					alert("请选择至少一条记录!");
					return;
					}
				if(count >= 1)
					{
					 if(confirm("确定要删除"+count+"条数据吗")){
						 location.href = "${ctxAdmin }/devwork/projectReleaseList/deleteAll/"+id;
					}
					}
		}) 
		//新增
		$("#addBtn").click(function(){
			location.href = "${ctxAdmin }/devwork/projectReleaseList/properties";
		})
		
		$("a[name='checkAll']").click(function(){
			var flag = true;
			var arrChk=$("input[name='chk_list']");
		      $(arrChk).each(function(){
		         if($(this).attr("checked") != "checked")
		    	   {
		    	   		flag = false;
		    	   }
		    });  
		    //如果已经全部都被选中，则再次点击时取消全选
		     if(flag)
		    	{
		    		$("input[name='chk_list']").attr("checked",false);
		    	}else{
		    		$("input[name='chk_list']").attr("checked",true);
		    	}
		});
		
		function check(info0,info1){
			arrChk=$("input[name='chk_list']");
			count = 0;
			$(arrChk).each(function(){
				if($(this).attr("checked") == "checked")
					{
					count++;
					}
			})
			if(count>1)
				{
				alert(info1);
				return;
				}
			if(count==0)
				{
				alert(info0);
				return;
				}
		}
</script>
</body>
</html>