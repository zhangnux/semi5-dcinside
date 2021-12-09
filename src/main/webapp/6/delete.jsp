<%@page import="vo.Board"%>
<%@page import="dao6.HotplaceBoardDao"%>
<%@page import="vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
int boardNo = Integer.parseInt(request.getParameter("boardNo"));
	int currentPageNo = Integer.parseInt(request.getParameter("cpno"));
	
	// 섹션에서 로그인 유저의 정보를 가져옴
	User loginUserInfo = (User) session.getAttribute("LOGIN_USER_INFO");
	
	// 로그인하지 않은 유저는 로그인부터 하게끔 유도
	if (loginUserInfo == null) {
		response.sendRedirect("../loginform.jsp?error=login-required");
		return;
	}
	
	// 선택된 게시글 정보를 가져옴
	HotplaceBoardDao boardDao = HotplaceBoardDao.getInstance();
	Board board = boardDao.getBoardDetail(boardNo);
	
	// 게시글을 작성한 유저번호와 로그인 된 유저번호를 비교
	if (board.getWriter().getNo() != loginUserInfo.getNo()) {
		response.sendRedirect("detail.jsp?boardNo="+boardNo+"&error=deny-delete");
		return;
	}
	
	// 게시글을 작성한 유저와 로그인 된 유저가 같은 유저라고 판별되면 게시글 삭제
	boardDao.deleteBoard(boardNo);
	
	// 클라이언트에게 게시글 목록을 요청하는 list.jsp를 재요청하는 응답을 보낸다.
	response.sendRedirect("list.jsp?cpno=" + currentPageNo);
%>