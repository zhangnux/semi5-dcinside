<%@page import="vo.BoardLiker"%>
<%@page import="vo.Board"%>
<%@page import="dao3.StockBoardDao"%>
<%@page import="vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
int no = Integer.parseInt(request.getParameter("no"));
	
	User loginUserInfo = (User)session.getAttribute("LOGIN_USER_INFO");
	
	if(loginUserInfo == null) {
		response.sendRedirect("../loginform.jsp?error=login-required");
		return;
	}
	
	StockBoardDao boardDao = StockBoardDao.getInstance();
	
	Board board = boardDao.getBoardDetail(no);
	
	if(board.getWriter().getNo() == loginUserInfo.getNo()){
		response.sendRedirect("detail.jsp?no=no"+no+"&error=deny-like");
		return;
	}
	BoardLiker savedBoardLiker = boardDao.getBoardLiker(no, loginUserInfo.getNo());
	
	if(savedBoardLiker != null){
		response.sendRedirect("detail.jsp?no="+no+"&error=deny-like");
		return;
	}
	
	BoardLiker boardLiker = new BoardLiker();
	boardLiker.setBoardNo(no);
	boardLiker.setUserNo(loginUserInfo.getNo());
	
	boardDao.insertBoardLiker(boardLiker);
	
	board.setLikeCount(board.getLikeCount() + 1);
	
	boardDao.updateBoard(board);
	
	response.sendRedirect("detail.jsp?no="+no);
%>
