<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="main-menu" content="devwork"/>
<meta name="menu" content="menu-dev_project_list"/>
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
              <a class="btn btn-default" href="${ctxAdmin }/devwork/project/list">
                <i class="glyphicon glyphicon-refresh"></i>
                刷新
              </a>
              <a href="${ctxAdmin }/devwork/project/properties" class="btn btn-primary">添加项目</a>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div class="row">   
        <div class="col-sm-12">
            <form id="searchForm" class="form-inline" action="${ctxAdmin }/devwork/project/findone" style="margin: 15px 0;">
                <div class="form-group">
                    <label for="">名称</label>
                    <input type="text" class="form-control" name="name" value="${project.name }" placeholder="专区名称">
                </div>
                <!-- <div class="form-group">
                    <label for="" class="sr-only">分类</label>
                    <select class="form-control" id="">
                        <option value="0">专区分类</option>
                    </select>
                </div> -->
                <button type="submit" class="btn btn-default">搜索</button>
            </form>
        </div>
    </div>
    <div class="row">   
        <div class="col-sm-12">
            <table class="table table-hover">
                <thead>
                    <tr>
                        <th>选择</th>
                        <th>名称</th>
                        <th>库路径</th>
                        <th>分组</th>
                        <th>站点路径</th>
                        <th>聚合项目</th>
                        <th class="text-right">操作</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${projects.content }" var="project">
                        <tr id="project_${project.id }">
                            <td><input type="checkbox" name="chk_list" value="${project.id }"></td>
                            <td><a href="${ctxAdmin }/devwork/project/properties/${project.id }">${project.name }</a></td>
                            <td>${project.repoUrl }</td>
                            <td>${project.category }</td>
                            <td>${project.siteUrl }</td>
                            <c:if test="${project.isAggregator == true }">
                            <td>是</td>
　　							</c:if>
							<c:if test="${project.isAggregator == false }">
                            <td>否</td>
　　							</c:if>
                            <td class="text-right">
                            	<a href="${ctxAdmin }/devwork/project/properties/${project.id }">修改</a>｜ 
                            	<a href="${ctxAdmin }/devwork/project/delete/${project.id }">删除</a> 
                            	</td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty projects.content }">
                    <tr><td colspan="7"><div class="inf-blank text-center" style="height: 200px; line-height: 200px;">
                        还没有项目，你可以点击“<a href="${ctxAdmin }/devwork/project/properties">添加项目</a>”。</div></td></tr>
                    </c:if>
                </tbody>
                <c:if test="${not empty projects.content }">
                <tfoot>
                    <tr>
                        <td colspan="7">
                        <page:formpage page="${projects}"/>
                        <a href="javascript:void(0)" name="checkAll">全选</a>
                        <button class="btn btn-success" id="addBtn" >新增</button>
                        <button class="btn btn-danger" id="deleteBtn" >删除</button>
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
				 location.href = "${ctxAdmin }/devwork/project/deleteAll/"+id;
			}
			}
}) 

//新增
$("#addBtn").click(function(){
	location.href = "${ctxAdmin }/devwork/project/properties";
})

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
</script>
</body>
</html>