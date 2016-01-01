<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ attribute name="page" type="org.springframework.data.domain.Page" required="true"%>
<%@ attribute name="form" type="java.lang.String"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<ul class="pagination pull-right" style="margin: 0">
	<li class="disabled"><a>共${page.totalElements }条</a></li>
	<c:if test="${page.hasPrevious() or page.hasNext() }">
		<li><a style="padding:0; margin:0;"><input style="width: 40px; text-align:center; height:29px;" type="text" id="gotoPageNo" placeholder="页码" size="4"/></a></li>
		<li><a class="btn btn-success" href="javascript:gotoPage()">跳转</a></li>
	</c:if>
	<c:if test="${page.hasPrevious() }">
		<li><a href="javascript:gotoPage(0)">首页</a></li>
		<li><a href="javascript:gotoPage(${page.number-1 })">上一页</a></li>
	</c:if>
	<c:if test="${not page.hasPrevious() }">
		<li class="disabled"><a href="javascript:void(0)">首页</a></li>
		<li class="disabled"><a href="javascript:void(0)">上一页</a></li>
	</c:if>
	
	<c:if test="${page.hasNext() }">
		<li><a href="javascript:gotoPage(${page.number+1 })">下一页</a></li>
		<li><a href="javascript:gotoPage(${page.totalPages-1 })">末页</a></li>
	</c:if>
	<c:if test="${not page.hasNext() }">
		<li class="disabled"><a href="javascript:void(0)">下一页</a></li>
		<li class="disabled"><a href="javascript:void(0)">末页</a></li>
	</c:if>
	<li class="disabled"><a>第${page.number+1 }页/共${page.totalPages }页</a></li>
</ul>
<script>
function getSearchFrom(){
	var formId = '${form }' || 'searchForm',
		form = document.getElementById(formId) || document.forms[formId];
	return form;
}

function gotoPage(pageNo){
	pageNo = pageNo || (document.getElementById("gotoPageNo").value-1) || 0;
	if(isNaN(pageNo) && pageNo<0){
		pageNo = 0;
	}

	var form = getSearchFrom();
	if(form){
		if(!form.page){
			createInput(form, 'hidden', 'page', pageNo);
		}else{
			form.page.value = pageNo;
		}
		form.submit();
		return;
	}
	
	location.href="?page="+pageNo;
}

function createInput(sfForm,type,name,value) { 
  var tmpInput = document.createElement("input"); 
  tmpInput.type = type; 
  tmpInput.name = name; 
  tmpInput.value = value; 
  sfForm.appendChild(tmpInput); 
} 
</script>