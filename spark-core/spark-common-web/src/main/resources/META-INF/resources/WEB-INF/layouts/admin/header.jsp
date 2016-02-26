<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<div class="console-topbar">
  <div class="topbar-wrap topbar-clearfix">
    <div class="topbar-head topbar-left">
      <a href="${ctx }/admin/" class="topbar-logo"><i class="icon icon-logo"></i></a>
      <a href="${ctx }/admin/" class="topbar-home-link topbar-btn">管理控制台</a>
    </div>

    <div class="topbar-nav topbar-left hidden">
      <a href="#" class="dropdown-toggle topbar-btn topbar-nav-btn" data-toggle="dropdown">
        <span class="ng-binding">产品与服务</span> <span class="icon-arrow-down caret"></span>
      </a>
      <div class="dropdown-menu topbar-nav-list topbar-clearfix">
        <ul class="dropdown-menu1 col-1">
          <li><a href="#">Action</a></li>
          <li><a href="#">Another action</a></li>
          <li><a href="#">Something else here</a></li>
          <li role="separator" class="divider"></li>
          <li><a href="#">Separated link</a></li>
          <li role="separator" class="divider"></li>
          <li><a href="#">One more separated link</a></li>
        </ul>
      </div>
    </div>
    
    <%-- <div class="topbar-nav topbar-left">
    	<c:forEach items="${fns:getMenuList() }" var="menu">
    		<c:if test="${menu.parent.id eq '1' && menu.isShow eq true}">
    			<c:if test="${empty menu.url }">
    				<a id="menu-${menu.id }" class="topbar-btn topbar-nav-btn" href="javascript:void(0)" data-href="?menu_id=${menu.id }">${menu.name }</a>
    			</c:if>
    			<c:if test="${not empty menu.url }">
    				<a id="menu-${menu.id }" class="topbar-btn topbar-nav-btn" href="${fn:indexOf(menu.url, '://') eq -1 ? ctxAdmin : ''}${menu.url }" target="${menu.target }">${menu.name }</a>
    			</c:if>
    		</c:if>
    	</c:forEach>
    </div> --%>
    
    <div class="topbar-nav topbar-left">
        <c:forEach items="${fns:getTopLevelMenus() }" var="menu">
            <c:if test="${menu.isShow eq true}">
                <c:if test="${empty menu.url }">
                    <a id="menu-${menu.id }" class="topbar-btn topbar-nav-btn" href="javascript:void(0)" data-href="?menu_id=${menu.id }">${menu.name }</a>
                </c:if>
                <c:if test="${not empty menu.url }">
                    <a id="menu-${menu.id }" class="topbar-btn topbar-nav-btn" href="${fn:indexOf(menu.url, '://') eq -1 ? ctxAdmin : ''}${menu.url }" target="${menu.target }">${menu.name }</a>
                </c:if>
            </c:if>
        </c:forEach>
    </div>

    <div class="topbar-info topbar-right"><!-- navbar-right 解决最后一个dropdown定位超出屏幕外的问题 -->
      <div class="dropdown user-info topbar-info-item hide">
        <a href="#" class="topbar-btn">消息 <span class="badge">37</span></a>
      </div>
      <div class="dropdown user-info topbar-info-item hide">
        <a href="#" class="dropdown-toggle topbar-btn" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">帮助 <span class="caret"></span></a>
        <ul class="dropdown-menu">
          <li><a href="#">Action</a></li>
          <li><a href="#">Another action</a></li>
          <li><a href="#">Something else here</a></li>
          <li role="separator" class="divider"></li>
          <li><a href="#">Separated link</a></li>
        </ul>
      </div>
      <shiro:user>
      <div class="dropdown user-info topbar-info-item">
        <a href="#" class="dropdown-toggle topbar-btn" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><shiro:principal property="email"/> <span class="caret"></span></a>
        <ul class="dropdown-menu">
          <li><a href="#">个人信息</a></li>
          <li role="separator" class="divider"></li>
          <li><a href="${ctx }/logout">退出</a></li>
        </ul>
      </div>
      </shiro:user>
    </div>
  </div>
</div>