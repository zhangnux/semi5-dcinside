<%@page import="dao3.StockBoardDao"%>
<%@page import="vo.Board"%>
<%@page import="vo.User"%>
<%@page import="vo.Comment"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	Comment comment = new Comment();

	int boardNo = Integer.parseInt(request.getParameter("boardNo"));
	int writerNo = Integer.parseInt(request.getParameter("writerNo"));
	int commentNo = Integer.parseInt(request.getParameter("commentNo"));
	int order = Integer.parseInt(request.getParameter("order"));
	int groupNo = Integer.parseInt(request.getParameter("groupNo"));
	
	User loginUserInfo = (User) session.getAttribute("LOGIN_USER_INFO");
	
	if(loginUserInfo == null || loginUserInfo.getNo() != writerNo){
		response.sendRedirect("../3/detail.jsp?no="+boardNo+"&error=commentId");
		return;
	}
	
	Board board = new Board();
	StockBoardDao boardDao = StockBoardDao.getInstance();
	boardDao.deleteComment(commentNo);
	
	response.sendRedirect("../3/detail.jsp?no="+boardNo);	
	
%>