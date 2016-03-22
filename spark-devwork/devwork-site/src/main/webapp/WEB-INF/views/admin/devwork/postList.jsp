<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="main-menu" content="devwork"/>
<meta name="menu" content="menu-dev_post_list"/>

<title>开发者空间-Post列表</title>
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
              <h4>Post列表</h4>
            </div>
            <div class="pull-right">
              <a class="btn btn-default" href="${ctxAdmin }/devwork/post/list">
                <i class="glyphicon glyphicon-refresh"></i>
                刷新
              </a>
              <a href="${ctxAdmin }/devwork/post/properties" class="btn btn-primary">添加Post数据</a>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div class="row">   
        <div class="col-sm-12">
            <form id="searchForm" class="form-inline" action="${ctxAdmin }/devwork/post/findone" style="margin: 15px 0;">
                <div class="form-group">
                    <label for="">标题</label>
                    <input type="text" class="form-control" name="title" value="${post.title }" placeholder="专区名称">
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
                        <th>标题(title)</th>
                        <th>公共标识(publicSlug)</th>
                        <th>策略(category)</th>
                        <th>广播信息(broadcast)</th>
                        <th>草稿(draft)</th>
                        <th>发布时间(publishDate)</th>
                        <th>原材料(rawContent)</th>
                        <th>呈现出来的内容(renderedContent)</th>
                        <th>渲染概要(renderedSummary)</th>
                        <th class="text-right" style="width:100px;">操作</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${posts.content }" var="post">
                        <tr id="post_${post.id }" class="trcla">
                            <td><input type="checkbox" name="chk_list" value="${post.id}"></td>
                            <td><a href="${ctxAdmin }/devwork/post/properties/${post.id }">${post.title }</a></td>
                            <td>${post.publicSlug }</td>
                            <td>${post.category }</td>
                            <c:if test="${post.broadcast == true}">
                            <td>是</td>
                            </c:if>
                            <c:if test="${post.broadcast == false}">
                            <td>否</td>
                            </c:if>
                            <c:if test="${empty post.broadcast }">
                            <td></td>
　　							</c:if>
                            <c:if test="${post.draft == true}">
                            <td>是</td>
                            </c:if>
                            <c:if test="${post.draft == false}">
                            <td>否</td>
                            </c:if>
                            <c:if test="${empty post.draft }">
                            <td></td>
　　							</c:if>
                            <td>${post.publishDate }</td>
                            <td>${post.rawContent }</td>
                            <td>${post.renderedContent }</td>
                            <td>${post.renderedSummary }</td>
                            <td class="text-right">
                            	<a href="${ctxAdmin }/devwork/post/properties/${post.id }">修改</a>｜ 
                            	<a href="${ctxAdmin }/devwork/post/deleteAll/${post.id }">删除</a> 
                            	</td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty posts.content }">
                    <tr><td colspan="14"><div class="inf-blank text-center" style="height: 200px; line-height: 200px;">
                        还没有项目，你可以点击“<a href="${ctxAdmin }/devwork/post/properties">添加Post</a>”。</div></td></tr>
                    </c:if>
                </tbody>
                <c:if test="${not empty posts.content }">
                <tfoot>
                    <tr>
                        <td colspan="14">
                        <page:formpage page="${posts}"/>
                        <a href="javascript:void(0)" name="checkAll">全选</a>
                        <button class="btn btn-success" id="addBtn">新增</button>
                        <button class="btn btn-danger" id="deleteBtn">删除</button>
                        <button class="btn btn-primary" id="publishButton">发布</button>
                        </td>
                    </tr>
                </tfoot>
                </c:if>
            </table>
        </div>
    </div>
</div>

<script type="text/javascript">
	var path="post";
		//删除
		$("#deleteBtn").click(function(){
			del(path);
		})

		//新增
		$("#addBtn").click(function(){
			add(path);
		})
		//发布
		  $("#publishButton").click(function(){
			  var info0="请先选中一个要发布的项目！";
			  var info1="请选中一个要发布的项目,不能同时发布多个项目！";
			check(info0,info1);
			 if(count == 1){
					//取到被选中复选框的id
					 $(arrChk).each(function(){
					if($(this).attr("checked") == "checked")
						{
							id = $(this).val();
							//如果已经发布过
							if($(this).parents('tr').children().eq(5).html() == "否")
								{
								alert("所选项目已经处于发布状态，不可重复发布！");
								return;
								}else{
									//执行发布
									$.ajax({  
						                 url: "${ctxAdmin }/devwork/post/ajax?id="+id,  
						                 type: 'GET',  
						                 dataType: 'json',  
										    success: function(json) {
										    	location.href = '${ctxAdmin }/devwork/post/list';
										    	alert("发布成功！");
										    }
						             		})  
								}
						}
					}) 
				
				} 
		}) 
</script>
<script src="${ctx }/commonjs/common.js" type="text/javascript"></script>
</body>
</html>