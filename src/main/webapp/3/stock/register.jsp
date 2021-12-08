
<%@page import="dao3.StockBoardDao"%>
<%@page import="vo.Board"%>
<%@page import="vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	User loginUserInfo = (User)session.getAttribute("LOGIN_USER_INFO");
	
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	
	if(title != null && title.isBlank()){
		response.sendRedirect("form.jsp?error=empty-title");
		return;
	}
	if(content != null && content.isBlank()){
		response.sendRedirect("form.jsp?error=empty-content");
		return;
	}
	
	
	if (loginUserInfo == null) {
		response.sendRedirect("../loginform.jsp?error=login-required");
		return;
	}
	
	
	
	Board board = new Board();
	board.setTitle(title);
	board.setWriter(loginUserInfo);
	board.setContent(content);
	
	StockBoardDao boardDao = StockBoardDao.getInstance();
	boardDao.insertBoard(board);
	
	response.sendRedirect("list.jsp");
%>