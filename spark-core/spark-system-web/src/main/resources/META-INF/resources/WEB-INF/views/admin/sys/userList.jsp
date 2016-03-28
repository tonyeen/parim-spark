<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%-- <meta name="main-menu" content="12"/>
<meta name="menu" content="menu-14"/> --%>
<meta name="decorator" content="admin-blank"/>
<title>菜单列表</title>
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
              <h4>用户列表</h4>
            </div>
            <div class="pull-right">
              <a class="btn btn-default">
                <i class="glyphicon glyphicon-refresh"></i>刷新
              </a>
              <a href="${ctxAdmin }/sys/user/properties" class="btn btn-primary">添加用户</a>
              <a href="${ctxAdmin }/sys/user/properties" class="btn btn-primary">复制用户</a>
              <a data-toggle="modal" href="#importContent" class="btn btn-success">批量导入</a>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div class="row hide">
    	<div class="col-sm-12">
    		<ul class="nav nav-tabs">
    			<li class="${empty tabActive or tabActive eq 'all' ? 'active' : '' }"><a href="${ctxAdmin }/prefecture/">全部(89)</a></li>
    			<li class="${tabActive eq 'published' ? 'active' : '' }"><a href="${ctxAdmin }/prefecture/published">已发布(40)</a></li>
    			<li><a href="?all">精选(15)</a></li>
    			<li><a href="?all">待审核(7)</a></li>
    		</ul>
    	</div>
    </div>
    <div class="row">	
    	<div class="col-sm-12">
    		<form id="searchForm" class="form-inline" action="" style="margin: 15px 0;">
    		    <input type="hidden" name="id" value="${param.id }"/>
    		    <input type="hidden" name="objectType" value="${param.objectType }"/>
    			<div class="form-group">
				    <label for="">过滤</label>
				    <input type="text" class="form-control" name="username" value="${user.username }" placeholder="过滤关键词">
				</div>
				<div class="form-group">
				    <label for="" class="sr-only">深度</label>
				    <select class="form-control" id="">
				    	<option value="0">仅显示当前节点</option>
				    	<option value="1">递归当前节点</option>
				    </select>
				</div>
				<button type="submit" class="btn btn-default">搜索</button>
				
				<div class="pull-right">
	              <a href="${ctxAdmin }/sys/user/properties" class="btn btn-default">导出列表</a>
	            </div>
    		</form>
    	</div>
    </div>
    <div class="row">	
    	<div class="col-sm-12">
    		<table class="table table-hover">
				<thead>
					<tr>
						<th>选择</th>
						<th>登录名</th>
						<th>姓</th>
						<th>名</th>
						<th>电子邮件</th>
						<th>组织</th>
						<th>状态</th>
						<th class="text-right">操作</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${users.content }" var="user">
						<tr id="user_${user.id }">
						    <td><input type="checkbox" name="id" value="${user.id }" /></td>
							<td><a href="${ctxAdmin }/sys/user/properties/${user.id }">${user.username }</a></td>
							<td>${user.firstName }</td>
							<td>${user.lastName }</td>
							<td>${user.email }</td>
							<td>${user.userGroup.name }</td>
							<td>启动<!-- 启用/锁定/到期 --></td>
							<td class="text-right">修改 ｜ 删除</td>
						</tr>
					</c:forEach>
					<c:if test="${empty users.content }">
					<tr><td colspan="7"><div class="inf-blank text-center" style="height: 200px; line-height: 200px;">
						该组织下没有人员，你可以点击“<a href="${ctxAdmin }/sys/user/properties">添加人员</a>”。</div></td></tr>
					</c:if>
				</tbody>
				<c:if test="${not empty users.content }">
				<tfoot>
					<tr>
						<td colspan="7">
						<page:formpage page="${users}"/>
						<button class="btn btn-success">新增</button>
						<button class="btn btn-primary">禁用</button>
						<button class="btn btn-warning">启用</button>
						<button class="btn btn-danger">删除</button>
						</td>
					</tr>
				</tfoot>
				</c:if>
			</table>
    	</div>
  	</div>
</div>

    <!-- 导入EXCEL标签样式 -->
    <div class="modal fade" id="importContent">
       <div class="modal-dialog">
          <div class="modal-content">
             <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title" id="myModalLabel">导入用户信息</h4>
             </div>
             <div class="modal-body">
               <script type="text/javascript">
                   function importUser() {
                       if($.trim($("#uploadFile").val()) == "") {
                           alert("导入文件不能为空。");
                           return;
                       }
                       $("#importForm").submit();
                       
                       /* $("#importForm").ajaxSubmit({
                       
                       }); */
                   }
               </script>
               <form id="importForm" action="${ctxAdmin }/sys/user/import" method="post" enctype="multipart/form-data"><br/>
                   <input id="uploadFile" name="file" type="file" style="width:330px"/><br/><br/>　　
                   <a href="${domain}/demo/admin/getTemplate">下载模板</a><br/>
                   <p>导入文件不能超过5M，仅允许导入“xls”或“xlsx”格式文件</p>
               </form>
             </div>
             <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" onclick="importUser()">导入</button>
             </div>
          </div><!-- <div class="modal-content"> -->
        </div><!-- <div class="modal-dialog"> -->
    </div>
</body>
</html>