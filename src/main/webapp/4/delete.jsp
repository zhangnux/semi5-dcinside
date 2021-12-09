<%@page import="vo.Board"%>
<%@page import="dao4.SoccerBoardDao"%>
<%@page import="vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
int no = Integer.parseInt(request.getParameter("no"));
	String pageNo = request.getParameter("pageNo");
	
	User loginUserInfo = (User)session.getAttribute("LOGIN_USER_INFO");
	
	SoccerBoardDao boardDao = SoccerBoardDao.getInstance();
	
	Board board = boardDao.getBoardDetail(no);
	
	boardDao.deleteBoard(no);
	
	response.sendRedirect("list.jsp?pageNo=" + pageNo);
%>
