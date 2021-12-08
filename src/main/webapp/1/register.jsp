<%@page import="com.dc.board.vo.User"%>
<%@page import="com.dc.board.dao.AnimalBoardDao"%>
<%@page import="com.dc.board.vo.Board"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
// 폼 입력값 조회
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	
	// title이 없거나 비어있으면 에러 발생
	if (title != null && title.isBlank()) {
		response.sendRedirect("form.jsp?error=empty-title");
		return;
	}

	// content가 없거나 비어있으면 에러 발생
	if (content != null && content.isBlank()) {
		response.sendRedirect("form.jsp?error=empty-content");
		return;
	}
	
	// 세션객체에서 "LOGIN_USER_INFO"로 저장된 속성(사용자 인증이 완료된 사용자정보)을 조회하기
	User loginUserInfo = (User)session.getAttribute("LOGIN_USER_INFO");
		
	// 로그인한 사용자의 정보가 세션객체에 없다면 게시글을 등록할 수 없다.
	// 클라이언트에게 로그인 정보를 입력하는 loginform.jsp를 재요청하는 응답을 보낸다.
	// 재요청 URL에 오류원인을 포함시킨다.
	if (loginUserInfo == null) {
		response.sendRedirect("../loginform.jsp?error=login-required");
		return;
	}
	
	// Board객체를 생성하여 제목, 작성자, 내용을 저장한다.
	Board board = new Board();
	board.setTitle(title);
	board.setWriter(loginUserInfo);
	board.setContent(content);
	
	// 게시글 관련 기능을 제공하는 BoardDao객체 획득
	AnimalBoardDao boardDao = AnimalBoardDao.getInstance();
	
	// 게시글 정보를 테이블에 저장
	boardDao.insertBoard(board);
	
	// 클라이언트에게 게시글 목록(list.jsp)을 재요청하게 하는 응답을 보낸다.
	response.sendRedirect("list.jsp");
%>