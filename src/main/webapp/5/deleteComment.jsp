<%@page import="dao5.CoinBoardDao"%>
<%@page import="vo.CoinBoard"%>
<%@page import="vo.User"%>
<%@page import="vo.BoardComment"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	

	User loginUserInfo = (User) session.getAttribute("LOGIN_USER_INFO");
	int writerNo = Integer.parseInt(request.getParameter("writerNo"));
	int boardNo = Integer.parseInt(request.getParameter("no"));
	int categoryNo = Integer.parseInt(request.getParameter("categoryNo"));
	
	int comment = Integer.parseInt(request.getParameter("commentNo"));

	if(loginUserInfo == null || loginUserInfo.getNo() != writerNo){
		response.sendRedirect("detail.jsp?error=commentId&no="+boardNo+"&categoryNo="+categoryNo);
		return;
	}
	 
	CoinBoardDao boardDao = CoinBoardDao.getInstance();
	CoinBoard board = boardDao.getBoardDetail(boardNo);
	
	board.setCommentCount(board.getCommentCount()-1);
	boardDao.updateBoard(board);
	
	boardDao.deleteComment(comment);

	response.sendRedirect("detail.jsp?no="+boardNo+"&categoryNo="+categoryNo);
%>
