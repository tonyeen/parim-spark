<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="main-menu" content="devwork"/>
<meta name="menu" content="menu-dev_project_repository_list"/>
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
              <a class="btn btn-default" href="${ctxAdmin }/devwork/projectRepository/list">
                <i class="glyphicon glyphicon-refresh"></i>
                刷新
              </a>
              <a href="${ctxAdmin }/devwork/projectRepository/properties" class="btn btn-primary">添加项目库数据</a>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div class="row">   
        <div class="col-sm-12">
            <form id="searchForm" class="form-inline" action="${ctxAdmin }/devwork/projectRepository/findone" style="margin: 15px 0;">
                <div class="form-group">
                    <label for="">标题</label>
                    <input type="text" class="form-control" name="name" value="${projectRepository.name }" placeholder="专区名称">
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
                        <th>名称(name)</th>
                        <th>路径(url)</th>
                        <th>快捷方式(snapshotsEnable)</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${projectRepositories.content }" var="p">
                        <tr id="post_${p.id }" class="trcla">
                            <td><input type="checkbox" name="chk_list" value="${p.id}"></td>
                            <td><a href="${ctxAdmin }/devwork/projectRepository/properties/${p.id }">${p.name }</a></td>
                            <!-- EL表达式需要注意的使用只有一条:当get方法后的字符如果前两个都是大写时,EL表达式需要大
							写.除此之外均为小写 -->
                            <td>${p.url }</td>
                            <c:if test="${p.snapshotsEnable == true}">
                            <td>是</td>
                            </c:if>
                            <c:if test="${p.snapshotsEnable == false}">
                            <td>否</td>
                            </c:if>
                            <td class="text-right">
                            	<a href="${ctxAdmin }/devwork/projectRepository/properties/${p.id }">修改</a>｜ 
                            	<a href="${ctxAdmin }/devwork/projectRepository/delete/${p.id }">删除</a> 
                            	</td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty projectRepositories.content }">
                    <tr><td colspan="5"><div class="inf-blank text-center" style="height: 200px; line-height: 200px;">
                        还没有项目，你可以点击“<a href="${ctxAdmin }/devwork/projectRepository/properties"></a>”。</div></td></tr>
                    </c:if>
                </tbody>
                <c:if test="${not empty projectRepositories.content }">
                <tfoot>
                    <tr>
                        <td colspan="14">
                        <page:formpage page="${projectRepositories}"/>
                        <a href="javascript:void(0)" name="checkAll">全选</a>
                        <button class="btn btn-success" id="addBtn">新增</button>
                        <button class="btn btn-danger" id="deleteBtn">删除</button>
                        <!-- <button class="btn btn-primary" id="publishButton">发布</button> -->
						<!-- <button class="btn btn-warning">取消发布</button> -->
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
						 location.href = "${ctxAdmin }/devwork/projectRepository/deleteAll/"+id;
					}
					}
		}) 
		//删除
		/* $("#deleteBtn").click(function(){
			var info0="请先选择一条数据用于删除！";
			var info1="请选择一条数据，不能同时删除多条！";
			check(info0,info1);
			if(count==1)
			{
				$(arrChk).each(function(){
					if($(this).attr("checked") == "checked")
						{
						id=$(this).val();
						}
				})
				location.href = "${ctxAdmin }/devwork/projectRepository/delete/"+id;
				return;
			}
			 
		}) */
		//新增
		$("#addBtn").click(function(){
			location.href = "${ctxAdmin }/devwork/projectRepository/properties";
		})
		
		$("a[name='checkAll']").click(function(){
			var flag = true;
			arrChk=$("input[name='chk_list']");
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