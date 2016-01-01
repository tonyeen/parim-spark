<%@ page language="java" pageEncoding="UTF-8"%>
<div class="header">
	<h1>移动网大三期</h1>
	<ul>
		<li><a href="${ctx }">社区首页</a></li>
		<li><a href="${ctx }/prefecture/">专区首页</a></li>
	</ul>
	<p>
	<shiro:guest>  
	欢迎游客访问，<a href="${ctx }/login">登录</a>  
	</shiro:guest>
	<shiro:user>  
	欢迎[<shiro:principal/>]登录，<a href="${ctx }/logout">退出</a>  
	</shiro:user>
	</p>
</div>