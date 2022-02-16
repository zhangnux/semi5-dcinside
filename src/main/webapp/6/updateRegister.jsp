<%@page import="vo.Board"%>
<%@page import="dao6.HotplaceBoardDao"%>
<%@page import="vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String title = request.getParameter("title");
	String content = request.getParameter("content");
	int boardNo = Integer.parseInt(request.getParameter("boardNo"));
	int currentPageNo = Integer.parseInt(request.getParameter("cpno"));
	
	User loginUserInfo = (User)session.getAttribute("LOGIN_USER_INFO");
	
	if (loginUserInfo == null) {
		response.sendRedirect("../loginform.jsp?fail=required");
		return;
	}
	
	HotplaceBoardDao boardDao = HotplaceBoardDao.getInstance();
	Board board = boardDao.getBoardDetail(boardNo);
	board.setTitle(title);
	board.setContent(content);
	
	boardDao.updateBoard(board);
	
	response.sendRedirect("detail.jsp?boardNo=" + boardNo + "&cpno=" + currentPageNo);
%>