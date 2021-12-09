<%@page import="dao3.StockBoardDao"%>
<%@page import="vo.User"%>
<%@page import="vo.Board"%>
<%@page import="java.util.List"%>
<%@page import="vo.Pagination"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" >
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">	
	<link rel = "stylesheet" href="../common/style.css">
	<title>## CONNECTING HEARTS! 디시인사이드입니다. ## </title>
</head>
<body>
<%
	StockBoardDao boardDao = StockBoardDao.getInstance();
	int totalRecords = boardDao.getTotalRecords();
	//페이징처리
	String pageNo = request.getParameter("pageNo");
	Pagination pagination = new Pagination(pageNo, totalRecords);
	User loginUserInfo = (User)session.getAttribute("LOGIN_USER_INFO");
	
	List<Board> boardList = boardDao.getBoardList(pagination.getBegin(), pagination.getEnd());
%>
<div class="dcwrap">
	<%@include file="/common/navbar.jsp" %>
		<div class="wrap_inner">
			<main class="dc_container">
				<section class="left_content">

					<div class="row">
						<div class="col mb-4 mt-2 border-bottom">
							<div class="coinTitle col">
								<h2 class="fw-bold"><a href="list.jsp">주식 갤러리</a></h2>
							</div>
						</div>		
					</div>

					
		<div class="row mb-3">
			<div class="col">
				<table class="table">
					<thead>
						<tr class="d-flex">
							<th class="col-1">번호</th>
							<th class="col-6">제목</th>
							<th class="col-2">작성자</th>
							<th class="col-1">조회수</th>
							<th class="col-2">등록일</th>
						</tr>
					</thead>
					<tbody>
<%
	for(Board board : boardList){
%>						
						<tr class="d-flex">
							<td class="col-1"><%=board.getNo() %></td>
							<td class="col-6"><a href="detail.jsp?no=<%=board.getNo()%>&pageNo=<%=pagination.getPageNo()%>"><%=board.getTitle()%></a></td>
							<td class="col-2"><%=board.getWriter().getName() %></td>
							<td class="col-1"><%=board.getViewCount() %></td>
							<td class="col-2"><%=board.getCreatedDate() %></td>
						</tr>
		
<%
	}

%>
<%
	// 로그인되지 않은 경우 새 글 버튼이 출력되지않는다.
	if (loginUserInfo != null) { 
%>
		<tr>
			<td>
				<a href="form.jsp" class="btn btn-primary">새 글</a>
			</td>
		</tr>
<%
	}
%>						
					</tbody>
				</table>
			</div>
		</div>
		<div class="row mb-3">
		<div class="col-6 offset-3">
			<nav>
				<ul class="pagination justify-content-center">
					<!-- 
						Pagination객체가 제공하는 isExistPrev()는 이전 블록이 존재하는 경우 true를 반환한다.
						Pagination객체가 제공하는 getPrevPage()는 이전 블록의 마지막 페이지값을 반환한다.
					 -->
					<li class="page-item <%=!pagination.isExistPrev() ? "disabled" : "" %>"><a class="page-link" href="list.jsp?pageNo=<%=pagination.getPrevPage()%>" >이전</a></li>
<%
	// Pagination 객체로부터 해당 페이지 블록의 시작 페이지번호와 끝 페이지번호만큼 페이지내비게이션 정보를 표시한다.
	for (int num = pagination.getBeginPage(); num <= pagination.getEndPage(); num++) {
%>					
					<li class="page-item <%=pagination.getPageNo() == num ? "active" : "" %>"><a class="page-link" href="list.jsp?pageNo=<%=num%>"><%=num %></a></li>
<%
	}
%>					
					<!-- 
						Pagination객체가 제공하는 isExistNext()는 다음 블록이 존재하는 경우 true를 반환한다.
						Pagination객체가 제공하는 getNexPage()는 다음 블록의 첫 페이지값을 반환한다.
					 -->
					<li class="page-item <%=!pagination.isExistNext() ? "disabled" :"" %>"><a class="page-link" href="list.jsp?pageNo=<%=pagination.getNextPage()%>" >다음</a></li>
				</ul>
			</nav>
		</div>
	
	</div>

				</section>
				<section class="right_content">
					<%@include file="/common/right_section.jsp" %>
				</section>
			</main>
		</div>
		<%@include file="/common/footer.jsp" %>
	</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>