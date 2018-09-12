<%@ page language="java" contentType="text/html;charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 分页导航 -->
<div class="pagination">
	<c:if test="${page.pageSum > 1}">
		<c:if test="${page.page == 1 }">
			<a title="First Page">&laquo; First</a>
			<a title="Previous Page">&laquo; Previous</a>
		</c:if>
		<c:if test="${page.page > 1}">
			<a href="${page.url }&page=1" title="First Page">&laquo; First</a>
			<a href="${page.url }&page=${page.page - 1 }" title="Previous Page">&laquo; Previous</a>
		</c:if>
		
		<c:forEach items="${page.indexs }" var="index">
			<c:if test="${page.page == index }">
				<a class="number current" title="${index}">${index }</a>
			</c:if>
			<c:if test="${page.page != index }">
				<a class="number" href="${page.url }&page=${index}" title="${index}">${index }</a>
			</c:if>
		</c:forEach>


		<c:if test="${page.page < page.pageSum }">
			<a href="${page.url }&page=${page.page + 1 }" title="Next Page">Next &raquo;</a>
			<a href="${page.url }&page=${page.pageSum }" title="Last Page">Last &raquo;</a>
		</c:if>
		<c:if test="${page.page == page.pageSum }">
			<a title="Next Page">Next &raquo;</a>
			<a title="Last Page">Last &raquo;</a>
		</c:if>
			
			当前第${page.page }页/共${page.pageSum }页  
		</c:if>
</div>