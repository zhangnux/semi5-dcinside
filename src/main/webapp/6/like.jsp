<%@page import="vo.BoardLiker"%>
<%@page import="vo.Board"%>
<%@page import="dao6.HotplaceBoardDao"%>
<%@page import="vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
int typeCode = Integer.parseInt(request.getParameter("typeCode"));
	int boardNo = Integer.parseInt(request.getParameter("boardNo"));
	String currentPageNo = request.getParameter("cpno");
	
	User loginUserInfo = (User)session.getAttribute("LOGIN_USER_INFO");
	
	if (loginUserInfo == null) {
		response.sendRedirect("../loginform.jsp?error=login-required");
		return;
	}
	
	HotplaceBoardDao boardDao = HotplaceBoardDao.getInstance();
	
	Board board = boardDao.getBoardDetail(boardNo);
	
	if (board.getWriter().getNo() == loginUserInfo.getNo()) {
		response.sendRedirect("detail.jsp?boardNo="+boardNo+"&cpno="+currentPageNo+"&error=deny-like");
		return;
	}
	
	BoardLiker savedBoardLiker = boardDao.getBoardLiker(boardNo, loginUserInfo.getNo());
	
	if (savedBoardLiker != null) {
		response.sendRedirect("detail.jsp?boardNo="+boardNo+"&cpno="+currentPageNo+"&error=deny-like");
		return;
	}
	
	BoardLiker boardLiker = new BoardLiker();
	boardLiker.setBoardType(typeCode);

	boardLiker.setBoardNo(boardNo);
	boardLiker.setUserNo(loginUserInfo.getNo());
	boardDao.insertBoardLiker(boardLiker);
	
	board.setLikeCount(board.getLikeCount() + 1);
	boardDao.updateBoard(board);
	
	response.sendRedirect("detail.jsp?boardNo="+boardNo+"&cpno="+currentPageNo);
%>