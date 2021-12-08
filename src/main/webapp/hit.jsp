<%@page import="utils.DateUtils"%>
<%@page import="vo.Hit"%>
<%@page import="java.util.List"%>
<%@page import="dao2.DiabloBoardDao"%>
<%@page import="vo.Pagination"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" >
	<link rel = "stylesheet" href="common/style.css">
	<title>## CONNECTING HEARTS! 디시인사이드입니다. ## </title>
</head>
<body>
<%
String pageNo = request.getParameter("pageNo");

	DiabloBoardDao boardDao = DiabloBoardDao.getInstance();
	BoardDao boardDao2 = BoardDao.getInstance();
	
	int hitRecords = boardDao2.getHitRecords();

	Pagination pagination = new Pagination(pageNo, hitRecords);
	
	List<Hit> hitList = boardDao2.getHitPost(pagination.getBegin(), pagination.getEnd());
%>
<div class="dcwrap">
	<%@include file="/common/navbar.jsp" %>
		<div class="wrap_inner">
			<main class="dc_container">
				<section class="left_content">
				
					<!-- 게시판 제목 -->
					<div class="row">
						<div class="col mb-4 mt-2 border-bottom">
							<div class="col-3"><h2 class="fw-bold"><a href="hit.jsp">Hit 갤러리</a></h2></div>
						</div>
					</div>
					<!-- 제목 하단 버튼 -->
					<div class="row">
						<div class="col">
							<div>
								<a href="hit.jsp?pageNo=1" class="btn btn-primary">전체글</a>
							</div>
						</div>
					</div>
						
					<div class="row mb-1">
						<div class="col border-top border-bottom border-primary border-2 mt-2 mb-2">														
							<table class="table table-sm mt-3">
								<thead>
									<tr>
										<th class="col-2">갤러리</th>
										<th class="col-5 text-center" style="width: 90px;">제목</th>
										<th class="col-1">글쓴이</th>
										<th class="col-2 text-center">작성일</th>
										<th class="col-1">조회</th>
										<th class="col-1">추천</th>
									</tr>
								</thead>
								<tbody>
						<%
						if (hitList.isEmpty()) {
						%>
									<tr>
										<td class="text-center"> 게시글이 없습니다.</td>
									</tr>
						<%
						}
											
											for (Hit hit : hitList) {
						%>
									<tr>
										<td class="col-2" style="font-size:13px;"><%=hit.getBoardType().getName()%></td>
										<td class="col-5">
											<a href="<%=hit.getBoard().getType()%>/detail.jsp?no=<%=hit.getBoard().getNo()%>">
											<%=hit.getBoard().getTitle()%></a>
											(<%=hit.getBoard().getCommentCount()%>)
										</td>
										<td class="col-1"><%=hit.getUser().getName()%></td>
										<td class="col-2" style="font-size:13px;"><%=DateUtils.dateToString(hit.getBoard().getCreatedDate())%></td>
										<td class="col-1"><%=hit.getBoard().getViewCount()%></td>
										<td class="col-1"><%=hit.getBoard().getLikeCount()%></td>
									</tr>
						<%
						}
						%>
								</tbody>	
							</table>
						</div>
					</div>
										
		<!-- 게시판 하단 버튼 -->				
		<div class="row">
			<div class="col">
				<div>
					<a href="hit.jsp?pageNo=1" class="btn btn-primary">전체글</a>
				</div>
			</div>
		</div>
							
	<!-- 페이지버튼 -->		
	<div class="row">
		<div class="col">
			<nav aria-label="Page navigation example">
			  <ul class="pagination justify-content-center">
			    <li class="page-item">
			      <a class="page-link" href="hit.jsp?pageNo=1" aria-label="Previous">
			        <span aria-hidden="true">&laquo;</span>
			      </a>
			    </li>
				<li class="page-item <%=!pagination.isExistPrev() ? "disabled" : ""%>"><a class="page-link" href="hit.jsp?pageNo=<%=pagination.getPrevPage()%>" >이전</a></li>
<%
for (int num = pagination.getBeginPage(); num <= pagination.getEndPage(); num++) {
%>					
				<li class="page-item <%=pagination.getPageNo() == num ? "active" : ""%>"><a class="page-link" href="hit.jsp?pageNo=<%=num%>"><%=num%></a></li>
<%
}
%>					

				<li class="page-item <%=!pagination.isExistNext() ? "disabled" :""%>"><a class="page-link" href="hit.jsp?pageNo=<%=pagination.getNextPage()%>" >다음</a></li>
			    <li class="page-item">
			      <a class="page-link" href="hit.jsp?pageNo=<%=pagination.getEnd()%>" aria-label="Next">
			        <span aria-hidden="true">&raquo;</span>
			      </a>
			    </li>
			  </ul>
			</nav>
		</div>
	</div>

				</section>
				<section class="right_content">
					<%@include file="common/right_section.jsp" %>
				</section>
			</main>
		</div>
		<%@include file="common/footer.jsp" %>
	</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>