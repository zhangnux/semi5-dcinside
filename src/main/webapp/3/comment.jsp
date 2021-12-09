<%@page import="vo.Board"%>
<%@page import="vo.User"%>
<%@page import="vo.Comment"%>
<%@page import="dao3.StockBoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	User loginUserInfo = (User)session.getAttribute("LOGIN_USER_INFO");

	
	int no = Integer.parseInt(request.getParameter("no"));
	String content = request.getParameter("content");
	String pageNo = request.getParameter("pageNo");
	
	
	if(loginUserInfo == null) {
		response.sendRedirect("loginform.jsp");
		return;
	}
	if(content == null || content.isBlank()){
		response.sendRedirect("../3/detail.jsp?no="+no+"&error=comcont");
		return;
	}
	
	StockBoardDao boardDao = StockBoardDao.getInstance();
	Board board = boardDao.getBoardDetail(no);
	
	Comment comment = new Comment();
	comment.setBoard(board);
	comment.setWriter(loginUserInfo); 
	comment.setContent(content);
	
	boardDao.insertComment(comment);
	
	boardDao.updateBoard(board);
	
	response.sendRedirect("../3/detail.jsp?no="+no+"&pageNo="+pageNo);
 
%>