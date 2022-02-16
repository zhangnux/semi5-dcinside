<%@page import="vo.BoardBookmarker"%>
<%@page import="vo.CoinBoard"%>
<%@page import="dao5.CoinBoardDao"%>
<%@page import="vo.User"%>
<%@page import="vo.BoardLiker"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">
<head>
</head>
<body>
<script type="text/javascript">
	alert("즐겨찾기 되었습니다.");									
</script>
<%
	int no = Integer.parseInt(request.getParameter("no"));
	int categoryNo = Integer.parseInt(request.getParameter("categoryNo"));
	
	// 세션객체에서 "LOGIN_USER_INFO"로 저장된 속성(사용자 인증이 완료된 사용자정보)을 조회하기
	User loginUserInfo = (User)session.getAttribute("LOGIN_USER_INFO");
	

	
	// 게시글 정보관련 기능을 제공하는 BoardDao객체를 획득한다.
	CoinBoardDao boardDao = CoinBoardDao.getInstance();
	
	// 게시글 번호에 해당하는 게시글 정보를 조회한다.
	CoinBoard board = boardDao.getBoardDetail(no);
	
	// 글번호와 로그인한 사용자번호로 저장된 추천정보를 조회한다.
	BoardLiker savedBookmark = boardDao.getBookmark(no,loginUserInfo.getNo());
	
	// 즐겨찾기가 존재하는 경우, 이미 추천한 게시글이기 때문에 다시 즐찾 할 수 없다.
	// 클라이언트에게 게시글 상세 정보를 요청하는 detail.jsp를 재요청하는 응답을 보낸다.
	// 재요청 URL에 오류원인을 포함시킨다.
	if (savedBookmark != null) {
		response.sendRedirect("detail.jsp?no="+no+"&error=deny-bookmark&categoryNo="+categoryNo);
		return;
	}
	
	// BoardLiker 객체를 생성해서 추천정보(게시글번호, 추천하는 사용자번호)를 저장한다.
	BoardBookmarker bookmark = new BoardBookmarker();
	
	bookmark.setBoardNo(no);
	bookmark.setUserNo(loginUserInfo.getNo());
	bookmark.setCategoryNo(categoryNo);
	
	boardDao.insertBookmark(bookmark);

	// 클라이언트에게 게시글 상세정보를 요청하는 detail.jsp를 재요청하는 응답을 보낸다.
	response.sendRedirect("detail.jsp?no="+no+"&categoryNo="+categoryNo);
 %>
</body>
</html>