<%@page import="vo.BoardComment"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="dao5.CoinBoardDao"%>
<%@page import="vo.CoinBoard"%>
<%@page import="vo.User"%>
<%
User loginUserInfo = (User) session.getAttribute("LOGIN_USER_INFO");
	int boardNo = Integer.parseInt(request.getParameter("no"));
	int categoryNo= Integer.parseInt(request.getParameter("categoryNo"));
	// 댓글 조회 파라미터
	String comment = request.getParameter("comment");
	
	if (loginUserInfo == null) {
		response.sendRedirect("detail.jsp?error=noLogin&categoryNo="+categoryNo);
		return;
	}
	if(comment == null || comment.isBlank()){
		response.sendRedirect("detail.jsp?no="+boardNo+"&error=noComment&categoryNo="+categoryNo);
		return;
	}
	
	CoinBoardDao boardDao = CoinBoardDao.getInstance();
	// 게시글 번호에 해당하는 글 정보를 조회한다.
	CoinBoard boardDetail = boardDao.getBoardDetail(boardNo);
	
	// 댓글 개수 1개 증가
	boardDetail.setCommentCount(boardDetail.getCommentCount()+1);
	boardDao.updateBoard(boardDetail);
	
	BoardComment boardcomment = new BoardComment();
		
	boardcomment.setBoard(boardDetail);
	boardcomment.setUser(loginUserInfo);
	boardcomment.setContent(comment);
	
	boardDao.insertComment(boardcomment);

	response.sendRedirect("detail.jsp?no="+boardNo+"&categoryNo="+categoryNo);
%>