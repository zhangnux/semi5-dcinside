<%@page import="vo.User"%>
<%@page import="vo.Board"%>
<%@page import="dao2.DiabloBoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
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
		response.sendRedirect("../loginform.jsp?error=noLogin");
		return;
	}
	
	Board board = new Board();
	
	content = content.replace("\r\n","<br>");
	
	board.setTitle(title);
	board.setContent(content);
	board.setWriter(loginUserInfo);
	
	DiabloBoardDao boardDao = DiabloBoardDao.getInstance();
	boardDao.insertBoard(board);
	
	response.sendRedirect("list.jsp");
%>