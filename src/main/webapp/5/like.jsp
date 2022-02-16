<%@page import="vo.BoardLiker"%>
<%@page import="vo.CoinBoard"%>
<%@page import="dao5.CoinBoardDao"%>
<%@page import="vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<body>
<%
	// 클라이언트는 게시글 추천요청을 할때 "liek.jsp?no=글번호&pageNo=페이지번호" 로 요청한다.(detail.jsp의 125번 라인 참조)
	// 요청파라미터에서 글번호와 페이지 번호를 조회한다.
	int no = Integer.parseInt(request.getParameter("no"));
	//String pageNo = request.getParameter("pageNo");
	
	// 세션객체에서 "LOGIN_USER_INFO"로 저장된 속성(사용자 인증이 완료된 사용자정보)을 조회하기
	User loginUserInfo = (User)session.getAttribute("LOGIN_USER_INFO");
	
	// 로그인한 사용자정보가 세션에 존재하지 않으면 게시글을 삭제할 수 없다.
	// 클라이언트에게 로그인 정보를 입력하는 loginform.jsp를 재요청하는 응답을 보낸다.
	// 재요청 URL에 오류원인을 포함시킨다.
	if (loginUserInfo == null) {
		response.sendRedirect("../loginform.jsp?error=login-required");
		return;
	}
	
	// 게시글 정보관련 기능을 제공하는 BoardDao객체를 획득한다.
	CoinBoardDao boardDao = CoinBoardDao.getInstance();
	
	// 게시글 번호에 해당하는 게시글 정보를 조회한다.
	CoinBoard board = boardDao.getBoardDetail(no);
	
	// 게시글의 작성자와 추천요청한 사용자의 번호가 서로 같은 경우 게시글을 추천할 수 없다.
	// 클라이언트에게 게시글 상세 정보를 요청하는 detail.jsp를 재요청하는 응답을 보낸다.
	// 재요청 URL에 오류원인을 포함시킨다.
	if (board.getWriter().getNo() == loginUserInfo.getNo()) {
		response.sendRedirect("detail.jsp?no="+no+"&error=deny-like");
		return;
	}
	
	// 게시글의 작성자와 추천를 요청한 사용자가 서로 다른 경우 게시글을 추천한다.
	
	// 글번호와 로그인한 사용자번호로 저장된 추천정보를 조회한다.
	BoardLiker savedBoardLiker = boardDao.getBoardLiker(no, loginUserInfo.getNo());
	
	// 추천정보가 존재하는 경우, 이미 추천한 게시글이기 때문에 다시 추천할 수 없다.
	// 클라이언트에게 게시글 상세 정보를 요청하는 detail.jsp를 재요청하는 응답을 보낸다.
	// 재요청 URL에 오류원인을 포함시킨다.
	if (savedBoardLiker != null) {
		response.sendRedirect("detail.jsp?no="+no+"&error=deny-like");
		return;
	}
%>
	<script type="text/javascript">
 		alert("즐겨찾기 하였습니다.");									
	</script>
<% 	
	// BoardLiker 객체를 생성해서 추천정보(게시글번호, 추천하는 사용자번호)를 저장한다.
	BoardLiker boardLiker = new BoardLiker();
	boardLiker.setBoardNo(no);
	boardLiker.setUserNo(loginUserInfo.getNo());
	// 추천정보를 테이블에 저장시킨다.
	boardDao.insertBoardLiker(boardLiker);
	
	// 현재 게시글의 추천수를 1증가시킨다.
	board.setLikeCount(board.getLikeCount() + 1);
	// 변경된 게시글 정보를 테이블에 반영시킨다.
	boardDao.updateBoard(board);
	
	// 클라이언트에게 게시글 상세정보를 요청하는 detail.jsp를 재요청하는 응답을 보낸다.
	response.sendRedirect("detail.jsp?no="+no+"&error=like&categoryNo=5");
%>
</body>
</html>