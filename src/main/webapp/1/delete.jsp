<%@page import="vo.Board"%>
<%@page import="dao1.AnimalBoardDao"%>
<%@page import="vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	int no = Integer.parseInt(request.getParameter("no"));
	String pageNo = request.getParameter("pageNo");
	
	User loginUserInfo = (User)session.getAttribute("LOGIN_USER_INFO");

	if(loginUserInfo == null){
		response.sendRedirect("../loginform.jsp?error=noLogin");
		return;
	}
	
	AnimalBoardDao boardDao = AnimalBoardDao.getInstance();
	Board board = boardDao.getBoardDetail(no);
	
	boardDao.deleteBoard(no);
	
	response.sendRedirect("list.jsp");
%>