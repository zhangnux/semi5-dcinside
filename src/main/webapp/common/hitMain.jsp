<%@page import="vo.Pagination"%>
<%@page import="utils.DateUtils"%>
<%@page import="vo.Hit"%>
<%@page import="java.util.List"%>
<%@page import="dao2.BoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	
	BoardDao boardDao = BoardDao.getInstance();

	int hitRecords = boardDao.getHitRecords();
	Pagination pagination = new Pagination("1",hitRecords);
	List<Hit> hitList = boardDao.getHitPost(1,4);
	
%>
<article>
	<div class="hit_content">
		<header class="hit_head">
			<h3>HIT 갤러리</h3>
		</header>
			<ul class="hit_list">
	<%
			for(Hit hit : hitList){
	%>
				<li>
					<a href="<%=hit.getBoard().getType()%>/detail.jsp?no=<%=hit.getBoard().getNo() %>">
					<%=hit.getBoard().getTitle() %></a>
					<div class="hit_info">
					<span class="hit_gall_name"><%=hit.getBoardType().getName() %></span>
					<span class="hit_date"><%=DateUtils.dateToString(hit.getBoard().getCreatedDate()) %></span>
					</div>
				</li>
	
	<% 		} %>
			</ul>
			<div class="hit_more">
			<a href="http://localhost/semi_dc/hit.jsp"><i class="fas fa-caret-square-down"></i>더보기</a>
			</div>
	</div>
</article>