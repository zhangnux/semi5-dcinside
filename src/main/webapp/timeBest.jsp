<%@page import="dao6.HotplaceBoardDao"%>
<%@page import="vo.Board"%>
<%@page import="vo.Pagination"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="utils.DateUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
	<!-- wrap -->
	<div class="dcwrap">
		<!-- navbar Start-->
		<%@ include file="/common/navbar.jsp" %>
		<!-- navbar End-->
<%
	String pageNo = request.getParameter("pageNo");

	HotplaceBoardDao boardDao = HotplaceBoardDao.getInstance();
	
	int totalRecords = boardDao.getBoardCount();
	
	Pagination pagination = new Pagination(pageNo, totalRecords);
	
	/* TODO: 타임베스트 페이징구현 필요 */
	List<Board> timeBestboards = boardDao.getBoardsRankByVeiwCountDetail(pagination.getBegin(), pagination.getEnd());
%>			
		<!-- wrap_inner -->
		<div class="wrap_inner">
			<main class="dc_container">
				<!-- left section Start -->
				<section class="left_content">
					<article class="board">
						<h2 class="fw-bold"><a href="timeBest.jsp">베스트 갤러리</a></h2>
						<!-- board content 시작 -->
						<table class="table">
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
	for (Board board : timeBestboards) {
%>
		<tr>
			<td class="col-2" style="font-size:13px;"><%=board.getTypeName() %></td>
			<td class="listTitle col-5">	
				<!-- TODO: pageNo 실시간베스트와 각 게시판들이 이동할 목록버튼 필요 -->  			
				<a href="<%=board.getTypeCode() %>/detail.jsp?no=<%=board.getNo() %>" title="<%=board.getTitle() %>">
					<%=board.getTitle() %>
				</a>
			</td>
			<td class="col-1"><%=board.getWriter().getId() %></td>
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
						<%-- 페이징 미완료
						<nav aria-label="Page navigation">
						  <ul class="pagination justify-content-center">
						    <li class="page-item">
						      <a class="page-link" href="list.jsp?pageNo=<%=pagination.getPrevPage() %>" aria-label="Previous">
						        <span aria-hidden="<%=!pagination.isExistPrev() ? "disabled" : "" %>">&laquo;</span>
						      </a>
						    </li>
<%	
	for (int cpno = pagination.getBeginPage(); cpno <= pagination.getEndPage(); cpno++) {
%>
    	<li class="page-item <%=pagination.getPageNo() == cpno ? "active" : "" %>">
    		<a class="page-link" href="list.jsp?pageNo=<%=cpno %>">
    			<%=cpno %>
    		</a>
    	</li>
<%		
	}
%>
						    <li class="page-item">
						      <a class="page-link" href="list.jsp?pageNo=<%=pagination.getNextPage() %>" aria-label="Next">
						        <span aria-hidden="true">&raquo;</span>
						      </a>
						    </li>
						  </ul>
						</nav> 
						--%>
						<!-- pageNav End -->
					</article>
				</section>
				<!-- left section End -->
				
				<!-- right content Start -->
				<section class="right_content">
					<%@include file="common/right_section.jsp" %>
				</section>
				<!-- right content End -->
			</main>
		</div>
		<!-- wrap_inner End -->
		
		<!-- footer Start -->
		<%@ include file="/common/footer.jsp" %>
		<!-- footer End -->
		
	</div>
	<!-- wrap End-->
</body>
<!-- script -->
<%@ include file="/common/script.jsp" %>
</html>