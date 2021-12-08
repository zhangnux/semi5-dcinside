
<%@page import="vo.Board"%>
<%@page import="dao3.StockBoardDao"%>
<%@page import="vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
int no = Integer.parseInt(request.getParameter("no"));

	String title = request.getParameter("title");
	String content = request.getParameter("content");
	
	if(title == null || title.isBlank()){
		response.sendRedirect("form.jsp?error=title");
		return;
	}
	
	if(content == null|| content.isBlank()){
		response.sendRedirect("form.jsp?error=content");
		return;
	}
	
	User loginUserInfo = (User)session.getAttribute("LOGIN_USER_INFO");
	
	if(loginUserInfo == null){
		response.sendRedirect("loginform.jsp?error=noLogin");
		return;
	}
	
	StockBoardDao boardDao = StockBoardDao.getInstance();
	
	Board board = new Board();
	board.setNo(no);
	board.setTitle(title);
	board.setContent(content);
	
	
	boardDao.updateBoard(board);
	
	response.sendRedirect("detail.jsp?no="+no);
%>