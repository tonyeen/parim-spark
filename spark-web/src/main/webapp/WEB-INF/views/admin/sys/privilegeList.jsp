<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="main-menu" content="2"/>
<meta name="menu" content="menu-9"/>
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
              <h4>专区列表</h4>
            </div>
            <div class="pull-right">
              <a class="btn btn-default">
                <i class="glyphicon glyphicon-refresh"></i>
                刷新
              </a>
              <a href="${ctxAdmin }/sys/privilege/properties" class="btn btn-primary">添加用户</a>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div class="row">	
    	<div class="col-sm-12">
    		<form id="searchForm" class="form-inline" action="" style="margin: 15px 0;">
    			<div class="form-group">
				    <label for="">名称</label>
				    <input type="text" class="form-control" name="name" value="${prefecture.name }" placeholder="专区名称">
				</div>
				<div class="form-group">
				    <label for="" class="sr-only">模块</label>
				    <select class="form-control" id="">
				    	<option value="0">专区分类</option>
				    </select>
				</div>
				<button type="submit" class="btn btn-default">搜索</button>
    		</form>
    	</div>
    </div>
    <div class="row">	
    	<div class="col-sm-12">
    		<table class="table table-hover">
				<thead>
					<tr>
						<th>名称</th>
						<th>分类</th>
						<th>创建时间</th>
						<th>发布</th>
						<th>精选</th>
						<th class="text-right">操作</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${privileges.content }" var="priv">
						<tr id="user_${priv.id }">
							<td><a href="${ctxAdmin }/sys/privilege/properties/${priv.id }">${priv.name }</a></td>
							<td>${priv.identifier }</td>
							<td>2015-02-09</td>
							<td>已发布</td>
							<td>否</td>
							<td class="text-right">修改 ｜ 删除 ｜ 添加下级菜单</td>
						</tr>
					</c:forEach>
					<c:if test="${empty privileges }">
					<tr><td colspan="6"><div class="inf-blank text-center" style="height: 200px; line-height: 200px;">
						该系统或模块下还没有设置权限，你可以点击“<a href="${ctxAdmin }/sys/privilege/properties">添加权限</a>”。</div></td></tr>
					</c:if>
				</tbody>
				<c:if test="${not empty privileges }">
				<tfoot>
					<tr>
						<td colspan="6">
						<page:formpage page="${privileges}"/>
						<button class="btn btn-success">新增</button>
						<button class="btn btn-primary">发布</button>
						<button class="btn btn-warning">取消发布</button>
						<button class="btn btn-primary">设置精选</button>
						<button class="btn btn-warning">取消精选</button>
						<button class="btn btn-danger">删除</button>
						</td>
					</tr>
				</tfoot>
				</c:if>
			</table>
    	</div>
  	</div>
</div>
</body>
</html>