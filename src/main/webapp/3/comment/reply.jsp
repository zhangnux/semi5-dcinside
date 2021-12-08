<%@page import="dao3.StockBoardDao"%>
<%@page import="vo.Board"%>
<%@page import="vo.User"%>
<%@page import="vo.Comment"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	User loginUserInfo = (User)session.getAttribute("LOGIN_USER_INFO");
	
	int no = Integer.parseInt(request.getParameter("no"));
	int order = Integer.parseInt(request.getParameter("order"));
	int group = Integer.parseInt(request.getParameter("group"));
	
	String content = request.getParameter("content");
	
	if(loginUserInfo == null) {
		response.sendRedirect("../loginform.jsp");
		return;
	}
	if(content == null || content.isBlank()){
		response.sendRedirect("../stock/detail.jsp?no="+no);
	}
	
	StockBoardDao boardDao = StockBoardDao.getInstance();
	Board board = boardDao.getBoardDetail(no);
	
	Comment comment = new Comment();
	comment.setBoard(board);
	comment.setOrder(order);
	comment.setContent(content);
	comment.setWriter(loginUserInfo);
	comment.setGroup(group);
	boardDao.insertCommentReply(comment);
	
	boardDao.updateBoard(board);
	
	response.sendRedirect("../stock/detail.jsp?no="+no);
%>