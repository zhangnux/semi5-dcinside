<%@page import="dao3.StockBoardDao"%>
<%@page import="vo.Hit"%>
<%@page import="java.util.List"%>
<%@page import="vo.BoardType"%>
<%@page import="vo.Board"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

	StockBoardDao stockBoardDao = StockBoardDao.getInstance();
	
	List<Hit> silbuk = stockBoardDao.getPostCount();
	
%>				
		<div class="gall_rank">
			<header class="rank_head">
				<h3>실북갤</h3>
			</header>
			<ol class="rank_title">
<%
		for(Hit hit : silbuk) {
			if(hit.getBoard().getType()==5){
%>				
				<li><a href="http://localhost/semi5/<%=hit.getBoard().getType() %>/list.jsp?list=no&categoryNo=1 "><%=hit.getBoardType().getName() %></a><span class="count"><%=hit.getBoard().getCommentCount() %></span></li>			
<%
			} else {
%>
				<li><a href="http://localhost/semi5/<%=hit.getBoard().getType() %>/list.jsp "><%=hit.getBoardType().getName() %></a><span class="count"><%=hit.getBoard().getCommentCount() %></span></li>
<%				
			}
		}
%>				
			</ol>
		</div>