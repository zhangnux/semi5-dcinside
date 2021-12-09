<%@page import="vo.Board"%>
<%@page import="vo.Pagination"%>
<%@page import="dao1.AnimalBoardDao"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">
<head>
   <meta charset="UTF-8">
   <meta name="viewport" content="width=device-width, initial-scale=1">
   <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" >
   <link rel="stylesheet" href="../common/style.css">
   <title>동물, 기타 메인</title>
</head>
<body>
	<div class="dcwrap">	
	<%@ include file="../common/navbar.jsp" %>
		<div class="wrap_inner">
			<main class="dc_container">
				<section class="left_content"> 
					<div class="row">
						<div class="col mb-4 mt-2 border-bottom">
							<div class="col">
								<h2 class="fw-bold"><a href="list.jsp">동물,기타 갤러리</a></h2>
							</div>
						</div>		
					</div>
					<% 
						String pageNo = request.getParameter("pageNo");
						String arrange = request.getParameter("arrange");
					
						AnimalBoardDao boardDao = AnimalBoardDao.getInstance();
						
						int totalRecords = boardDao.getTotalRecords();
						Pagination pagination = new Pagination(pageNo, totalRecords);
						
						List<Board> boardList = boardDao.getBoardList(pagination.getBegin(), pagination.getEnd());
						
						User loginUserInfo = (User)session.getAttribute("LOGIN_USER_INFO");
					%>					
					<article>
						<div class="col d-flex justify-content-between mb-2 mt-2">
							<div>
								<a href="list.jsp?pageNo=1" class="btn btn-primary">전체글</a>
								<a href="list.jsp?arrange=view&pageNo=1" class="btn btn-light">개념글</a>
							</div>						
						</div>
						<div class="time_list">
							<table class="table table-sm">
								<thead>
									<tr class="d-flex border-top border-primary text-center">
										<th class="col-1">번호</th>
										<th class="col-6"><div class="mx-auto" style="width: 90px;">제목</div></th>
										<th class="col-1">글쓴이</th>
										<th class="col-2" >작성일</th>
										<th class="col-1">조회</th>
										<th class="col-1">추천</th>
									</tr>
								</thead>
								<tbody>
								<%
									if (boardList.isEmpty()) {
								%>
									<tr>
										<td class="text-center" colspan="6">게시글이 존재하지 않습니다.</td>
									</tr>
								<% 
									} else {
										for (Board board : boardList) {
									
								%>
									<tr class="d-flex">
										<td class="col-1 text-center"><%=board.getNo() %></td>
										<td class="col-6">
								<% 
											if ("Y".equals(board.getDeleted())) {
								%>	
											<span><del>삭제된 글입니다.</del></span>
								<% 
											} else {
								%>
											<a href="detail.jsp?no=<%=board.getNo() %>&pageNo=<%=pagination.getPageNo()%>">
												<%=board.getTitle() %> 
											</a>
								<% 
											}								
								%>		
										</td>
										<td class="col-1 text-center"><%=board.getWriter().getName() %></td>
										<td class="col-2 text-center" style="font-size:13px;"><%=board.getCreatedDate() %></td>
										<td class="col-1 text-center"><%=board.getViewCount() %></td>
										<td class="col-1 text-center"><%=board.getLikeCount() %></td>
									</tr>
								<%
										}
								}
								%>

								</tbody>	
							</table>	
						</div>
						<div class="col d-flex justify-content-between mt-2">
							<div>
								<a href="list.jsp?list=no" class="btn btn-primary">전체글</a>
								<a href="list.jsp?arrange=view&pageNo=1" class="btn btn-light">개념글</a>
							</div>
							<div class="d-flex flex-row-reverse">
							<%
								// 로그인되지 않은 경우 새 글 버튼이 출력되지않는다.
								if (loginUserInfo != null) { 
							%>
								<a href="form.jsp" class="btn btn-primary ms-1">글쓰기</a>
							<%
								}
							%>
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
	
					</article>
				</section>
				<section class="right_content">
					<%@ include file="../common/right_section.jsp" %>
				</section>
			</main>
		</div>
		<%@ include file="../common/footer.jsp" %>
	</div>	
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>