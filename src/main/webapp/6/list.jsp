<%@page import="vo.Board"%>
<%@page import="vo.Pagination"%>
<%@page import="dao6.HotplaceBoardDao"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="utils.DateUtils"%>
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
<div class="dcwrap">
	<%@include file="/common/navbar.jsp" %>
<%
String pageNo = request.getParameter("pageNo");

	HotplaceBoardDao boardDao = HotplaceBoardDao.getInstance();
	
	int totalRecords = boardDao.getBoardCount();
	
	Pagination pagination = new Pagination(pageNo, totalRecords);
	
	List<Board> boards = boardDao.getBoardListByTypeCode(pagination.getBegin(), pagination.getEnd());
%>			
		<!-- wrap_inner -->
		<div class="wrap_inner">
			<main class="dc_container">
				<!-- left section Start -->
				<section class="left_content">
				
					<div class="row">
						<div class="col mb-4 mt-2 border-bottom">
							<div class="col">
								<h2 class="fw-bold"><a href="list.jsp">핫플레이스 갤러리</a></h2>
							</div>
						</div>		
					</div>
					
						<table class="table">
							<thead>
								<tr>
									<th class="col-1">번호</th>
									<th class="col-5">제목</th>
									<th class="col-2">글쓴이</th>
									<th class="col-2 text-center">작성일</th>
									<th class="col-1">조회</th>
									<th class="col-1">추천</th>
								</tr>
							</thead>
							<tbody>
<%
	for (Board board : boards) {
%>
		<tr>
			<td class="col-1"><%=board.getNo() %></td>
			<td class="listTitle col-5">
				<a href="detail.jsp?boardNo=<%=board.getNo() %>&cpno=<%=pagination.getPageNo() %>" title="<%=board.getTitle() %>">
					<%=board.getTitle() %>
				</a>
			</td>
			<td class="col-2"><%=board.getWriter().getId() %></td>
			<td class="col-2" style="font-size:13px;"><%=DateUtils.dateToString(board.getCreatedDate()) %></td>
			<td class="col-1"><%=board.getViewCount() %></td>
			<td class="col-1"><%=board.getLikeCount() %></td>
		</tr>
<% 
	}
%>
							</tbody>
						</table>
						<!-- board content End -->
						<!-- pageNav Start -->
						<nav aria-label="Page navigation">
						  <ul class="pagination justify-content-center">
						    <li class="page-item">
						      <a class="page-link" href="list.jsp?cpno=<%=pagination.getPrevPage() %>" aria-label="Previous">
						        <span aria-hidden="<%=!pagination.isExistPrev() ? "disabled" : "" %>">&laquo;</span>
						      </a>
						    </li>
<%	
	for (int cpno = pagination.getBeginPage(); cpno <= pagination.getEndPage(); cpno++) {
%>
    	<li class="page-item <%=pagination.getPageNo() == cpno ? "active" : "" %>">
    		<a class="page-link" href="list.jsp?cpno=<%=cpno %>">
    			<%=cpno %>
    		</a>
    	</li>
<%		
	}
%>
						    <li class="page-item">
						      <a class="page-link" href="list.jsp?cpno=<%=pagination.getNextPage() %>" aria-label="Next">
						        <span aria-hidden="true">&raquo;</span>
						      </a>
						    </li>
						  </ul>
						</nav>
						<!-- pageNav End -->
<% 
	User loginUserInfoByList = (User) session.getAttribute("LOGIN_USER_INFO");
	if (loginUserInfoByList != null) {
%>
		<div class="d-grid gap-2 d-md-flex justify-content-md-end">
			<a href="insertForm.jsp?cpno=<%=pagination.getPageNo()%>>" class="btn btn-primary mt-3">글쓰기</a>
		</div>
<%
	}
%>						
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