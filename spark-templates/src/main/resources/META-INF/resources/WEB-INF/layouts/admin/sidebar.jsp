<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<div class="sidebar-content">
  <div class="sidebar-inner">
    <div class="sidebar-fold icon-fold glyphicon glyphicon-menu-hamburger"><!--Fold/Unfold--></div>
    <c:forEach items="${fns:getMenuList() }" var="menu" varStatus="status">
    <c:if test="${menu.parent.id eq '1' && menu.isShow eq true && menu.id eq mainMenu}">
    	<c:forEach items="${fns:getMenuList() }" var="menu2" varStatus="status2">
    	<c:if test="${menu2.parent.id eq menu.id && menu2.isShow eq true}">
		    <div id="menu-${menu2.id }" data-parent="menu-${menu.id }" class="sidebar-nav sidebar-nav-${menu2.id } main-nav">
		      <div class="sidebar-title">
		        <div class="sidebar-title-inner">
		          <span class="sidebar-title-icon icon-arrow-down caret"></span> <!-- glyphicon glyphicon-triangle-bottom -->
		          <span class="sidebar-title-text">${menu2.name }</span>
		          <span class="sidebar-manage"><a class="icon-setup glyphicon glyphicon-cog"></a></span>
		        </div>
		      </div>
		      <ul class="sidebar-trans">
		      	<c:forEach items="${fns:getMenuList() }" var="menu3" varStatus="status3">
		    	<c:if test="${menu3.parent.id eq menu2.id && menu3.isShow eq true}">
		        <li id="menu-${menu3.id }" class="nav-item">
		        	<a href="${fn:indexOf(menu3.url, '://') eq -1 ? ctxAdmin : ''}${menu3.url }"
		        		target="${menu3.target }" class="sidebar-trans">
		        		<span class="nav-icon"><span class="glyphicon glyphicon-${empty menu3.icon ? 'home' : menu3.icon }"></span></span>
		        		<span class="nav-title">${menu3.name }</span>
		        	</a>
		        </li>
		        </c:if>
		        </c:forEach>
		      </ul>
		    </div>
    	</c:if>
    	</c:forEach>
    </c:if>
    </c:forEach>
    <%-- <div class="sidebar-nav sidebar-nav-1 main-nav">
      <div class="sidebar-title">
        <div class="sidebar-title-inner">
          <span class="sidebar-title-icon icon-arrow-down caret"></span>
          <span class="sidebar-title-text">Forms</span>
          <span class="sidebar-manage"><a class="icon-setup glyphicon glyphicon-cog"></a></span>
        </div>
      </div>
      <ul class="sidebar-trans">
        <li class="nav-item"><a href="/example//index.html" class="sidebar-trans"><div class="nav-icon"><span class="icon-xxx"></span></div><span class="nav-title">Components</span></a></li>
      </ul>
    </div> --%>
  </div>
</div>
