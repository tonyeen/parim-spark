<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="main-menu" content="12"/>
<meta name="menu" content="menu-14"/>
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
              <a href="${ctxAdmin }/prefecture/properties" class="btn btn-primary">添加专区</a>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div class="row">
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
    			<div class="form-group">
				    <label for="">名称</label>
				    <input type="text" class="form-control" name="name" value="${prefecture.name }" placeholder="专区名称">
				</div>
				<div class="form-group">
				    <label for="" class="sr-only">分类</label>
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
					<c:forEach items="${prefectures.content }" var="prefecture">
						<tr id="menu_${prefecture.id }">
							<td><a href="${ctxAdmin }/prefecture/group/properties/${prefecture.id }">${prefecture.name }</a></td>
							<td></td>
							<td>2015-02-09</td>
							<td>已发布</td>
							<td>否</td>
							<td class="text-right">修改 ｜ 删除 ｜ 添加下级菜单</td>
						</tr>
					</c:forEach>
				</tbody>
				<tfoot>
					<tr>
						<td colspan="6">
						<page:formpage page="${prefectures}"/>
						<button class="btn btn-success">新增</button>
						<button class="btn btn-primary">发布</button>
						<button class="btn btn-warning">取消发布</button>
						<button class="btn btn-primary">设置精选</button>
						<button class="btn btn-warning">取消精选</button>
						<button class="btn btn-danger">删除</button>
						</td>
					</tr>
				</tfoot>
			</table>
    	</div>
  	</div>
</div>
</body>
</html>