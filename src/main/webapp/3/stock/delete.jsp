
<%@page import="dao3.StockBoardDao"%>
<%@page import="vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int no = Integer.parseInt(request.getParameter("no"));
	
	User loginUserInfo = (User)session.getAttribute("LOGIN_USER_INFO");

	if(loginUserInfo == null){
		response.sendRedirect("../loginform.jsp?=login-required");
	}
	
	StockBoardDao boardDao = StockBoardDao.getInstance();
	
	boardDao.deleteBoard(no);	

	
	response.sendRedirect("list.jsp");
%>