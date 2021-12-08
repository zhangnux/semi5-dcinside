
<%@page import="vo.BoardLiker"%>
<%@page import="vo.Board"%>
<%@page import="dao2.BoardDao"%>
<%@page import="vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

	int no = Integer.parseInt(request.getParameter("no"));
	String pageNo = request.getParameter("pageNo");

	User loginUserInfo = (User)session.getAttribute("LOGIN_USER_INFO");
	
	
	if(loginUserInfo == null){
		response.sendRedirect("loginform.jsp?error=noLogin");
		return;
	}
	
	BoardDao boardDao = BoardDao.getInstance();
	Board board = boardDao.getBoardDetail(no);
	
	if(board.getWriter().getNo() == loginUserInfo.getNo()){
		response.sendRedirect("detail.jsp?no="+no+"&pageNo="+pageNo+"&error=likeLogin");		
		return;
	}
	
	BoardLiker boardLiker = boardDao.getBoardLiker(no, loginUserInfo.getNo());
	
	if(boardLiker != null){
		response.sendRedirect("detail.jsp?no="+no+"&pageNo="+pageNo+"&error=alreadyLike");		
		return;		
	}
	
	boardLiker.setBoardNo(no);
	boardLiker.setUserNo(loginUserInfo.getNo());
	
	boardDao.insertBoardLiker(boardLiker);
	
	board.setLikeCount(board.getLikeCount() + 1);
	boardDao.updateBoard(board);
	
	response.sendRedirect("detail.jsp?no="+no+"&pageNo="+pageNo);
	
%>