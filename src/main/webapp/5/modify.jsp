<%@page import="vo.CoinBoard"%>
<%@page import="dao5.CoinBoardDao"%>
<%@page import="vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// board/form.jsp에서 board/register.jsp로 제출한 폼 입력값을 조회하기
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	int no = Integer.parseInt(request.getParameter("no"));
	
	// 입력값 title이 없거나 비어있으면 게시글을 등록할 수 없다.
	// 클라이언트에게 게시글 정보를 입력하는 form.jsp를 재요청하는 응답을 보낸다.
	// 재요청 URL에 사용자인증 실패원인을 포함시킨다.
	if (title != null && title.isBlank()) {
		response.sendRedirect("form.jsp?error=empty-title");
		return;
	}
	// 입력값 content가 없거나 비어있으면 게시글을 등록할 수 없다.
	// 클라이언트에게 게시글 정보를 입력하는 form.jsp를 재요청하는 응답을 보낸다.
	// 재요청 URL에 사용자인증 실패원인을 포함시킨다.
	if (content != null && content.isBlank()) {
		response.sendRedirect("form.jsp?error=empty-content");
		return;
	}
	
	// 세션객체에서 "LOGIN_USER_INFO"로 저장된 속성(사용자 인증이 완료된 사용자정보)을 조회하기
	// User loginUserInfo = (User)session.getAttribute("LOGIN_USER_INFO");
	
	// 로그인한 사용자정보가 세션에 존재하지 않으면 게시글을 등록할 수 없다.
	// 클라이언트에게 로그인 정보를 입력하는 loginform.jsp를 재요청하는 응답을 보낸다.
	// 재요청 URL에 오류원인을 포함시킨다.
	// if (loginUserInfo == null) {
	//	response.sendRedirect("../loginform.jsp?error=login-required");
	//	return;
	// }
	
	// Board객체를 생성한다.
	// 생성한 Board객체에 제목, 작성자, 내용을 저장한다.
	// 게시글 관련 기능을 제공하는 BoardDao 객체를 획득한다.
	
	CoinBoardDao boardDao = CoinBoardDao.getInstance();
	CoinBoard boardDetail = boardDao.getBoardDetail(no);
	
	boardDetail.setTitle(title);
	boardDetail.setContent(content);
	
	// 게시글 정보를 테이블에 수정시킨다.
	boardDao.updateBoard(boardDetail);
	
	// 클라이언트에게 게시글 목록(list.jsp)은 재요청하게 하는 응답을 보내다.
	response.sendRedirect("list.jsp?categoryNo=5");
%>