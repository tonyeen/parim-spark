<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="main-menu" content="system_management"/>
<meta name="menu" content="menu-system_dict_management"/>
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
              <h4>字典数据列表</h4>
            </div>
            <div class="pull-right">
              <a class="btn btn-default" href="${ctxAdmin }/sys/dict/list" >
                <i class="glyphicon glyphicon-refresh"></i>
                刷新
              </a>
              <a href="${ctxAdmin }/sys/dict/properties" class="btn btn-primary">添加字典数据</a>
            </div>
          </div>
        </div>
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
					<c:forEach items="${dicts.content}" var="dict">
						<tr id="dict_${dict.id }">
							<td><a href="${ctxAdmin }/sys/dict/properties/${dict.id }">${dict.label }</a></td>
							<td></td>
							<td>${dict.createdBy }</td>
							<td>已发布</td>
							<td>否</td>
							<td class="text-right">
                   <a href="${ctxAdmin }/sys/dict/properties/${dict.id }">修改</a> ｜ 
                   <a href="${ctxAdmin }/sys/dict/delete/${dict.id }">删除</a> ｜
						</tr>
					</c:forEach>
					<c:if test="${empty dicts }">
					<tr><td colspan="6"><div class="inf-blank text-center" style="height: 200px; line-height: 200px;">
						该组织下没有人员，你可以点击“<a href="${ctxAdmin }/sys/dict/properties">添加字典数据</a>”。</div></td></tr>
					</c:if>
				</tbody>
				<c:if test="${not empty dicts }">
				<tfoot>
					<tr>
						<td colspan="6">
						<page:formpage page="${dicts}"/>
						<button class="btn btn-success" onclick="">新增</button>
						<!-- <button class="btn btn-primary">发布</button>
						<button class="btn btn-warning">取消发布</button>
						<button class="btn btn-primary">设置精选</button>
						<button class="btn btn-warning">取消精选</button> -->
						<button class="btn btn-danger" onclick="" >删除</button>
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