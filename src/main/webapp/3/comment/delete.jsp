
<%@page import="dao3.StockBoardDao"%>
<%@page import="vo.Board"%>
<%@page import="vo.User"%>
<%@page import="vo.Comment"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	Comment comment = new Comment();

	User loginUserInfo = (User) session.getAttribute("LOGIN_USER_INFO");
	int writerNo = Integer.parseInt("writerNo");
	int commentNo = Integer.parseInt("commentNo");
	
	if(loginUserInfo == null && loginUserInfo.getNo() != writerNo){
		response.sendRedirect("detail.jsp?error=commentId");
		return;
	}
	
	Board board = new Board();
	StockBoardDao boardDao = StockBoardDao.getInstance();
	boardDao.deleteComment(commentNo);
%>