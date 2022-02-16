<%@page import="dao.BoardDao"%>
<%@page import="dao2.DiabloBoardDao"%>
<%@page import="utils.DateUtils"%>
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
	<link rel = "stylesheet" href="../common/style.css">
	<title>## CONNECTING HEARTS! 디시인사이드입니다. ## </title>
</head>
<body>
<%
	BoardDao boardDao = BoardDao.getInstance();
	DiabloBoardDao boardDao2 = DiabloBoardDao.getInstance();

	String pageNo = request.getParameter("pageNo");
	String arrange = request.getParameter("arrange");
	
	int totalRecords = boardDao.getHitRecords();
	
	Pagination pagination = new Pagination(pageNo, totalRecords);
	
	List<Board> boardList = boardDao2.getBoardList(pagination.getBegin(), pagination.getEnd());
%>
<div class="dcwrap">
	<%@include file="/common/navbar.jsp" %>
		<div class="wrap_inner">
			<main class="dc_container">
				<section class="left_content">
				
				<!-- 게시판 제목 -->

					<div class="row">
						<div class="col mb-4 mt-2 border-bottom">
							<div class="col">
								<h2 class="fw-bold"><a href="list.jsp">디아블로 갤러리</a></h2>
							</div>
						</div>		
					</div>

					
					
					<div class="row">
						<div class="col">
							<div>
								<a href="list.jsp?pageNo=1" class="btn btn-primary">전체글</a>
								<a href="list.jsp?arrange=view&pageNo=1" class="btn btn-light">개념글</a>
							</div>
						</div>
					</div>		
					
					<div class="row mb-1">
						<div class="col border-top border-bottom border-primary border-2 mt-2 mb-2">														
							<table class="table table-sm mt-3">
								<thead>
									<tr>
										<th class="col-1">번호</th>
										<th class="col-6">제목</th>
										<th class="col-1">글쓴이</th>
										<th class="col-2 text-center">작성일</th>
										<th class="col-1">조회</th>
										<th class="col-1">추천</th>
									</tr>
								</thead>
								<tbody>				
<% 

	if("view".equals(arrange)){		
		boardList = boardDao2.getBoardArrange(pagination.getBegin(), pagination.getEnd());	
	}

	if(boardList.isEmpty()){
%>
		<tr>
			<td></td>
			<td class="text-center"> 게시글이 없습니다.</td>
		</tr>
<% 
	} 	
	
	for(Board board : boardList){

%>
						<tr>
							<td class="col-1" style="font-size:13px;"><%=board.getNo() %></td>
							<td class="col-6">
								<a href="detail.jsp?no=<%=board.getNo() %>&pageNo=<%=pagination.getPageNo()%>">
								<%=board.getTitle() %></a> (<%=board.getCommentCount() %>)
							</td>
							<td class="col-1"><%=board.getWriter().getName() %></td>
							<td class="col-2" style="font-size:13px;"><%=DateUtils.dateToString(board.getCreatedDate()) %></td>
							<td class="col-1"><%=board.getViewCount() %></td>
							<td class="col-1"><%=board.getLikeCount() %></td>
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
		<!-- 플렉스(flex): https://getbootstrap.kr/docs/5.1/utilities/flex/ -->
		<!-- div 기준으로 양옆으로 배치 -->
			<div class="col d-flex justify-content-between">				
				<div>		
					<a href="list.jsp?pageNo=1" class="btn btn-primary">전체글</a>
					<a href="list.jsp?arrange=view&pageNo=1" class="btn btn-light">개념글</a>
				</div>
<% 
	User loginUserInfo = (User)session.getAttribute("LOGIN_USER_INFO");
	if(loginUserInfo != null){
%>
				<div>
					<a href="form.jsp" class="btn btn-primary">글쓰기</a>
				</div>
<%
	}
%>
			</div>
		</div>
	</div>
	
	<!-- 페이지네이션 -->
	<div class="row">
		<div class="col">
			<nav aria-label="Page navigation example">
			  <ul class="pagination justify-content-center">
			    <li class="page-item">
			      <a class="page-link" href="list.jsp?pageNo=1" aria-label="Previous">
			        <span aria-hidden="true">&laquo;</span>
			      </a>
			    </li>
				<li class="page-item <%=!pagination.isExistPrev() ? "disabled" : "" %>"><a class="page-link" href="list.jsp?pageNo=<%=pagination.getPrevPage()%><%="view".equals(arrange)?"&arrange=view":""%>" >이전</a></li>
<%

	for (int num = pagination.getBeginPage(); num <= pagination.getEndPage(); num++) {
%>					
				<li class="page-item <%=pagination.getPageNo() == num ? "active" : "" %>"><a class="page-link" href="list.jsp?pageNo=<%=num%><%="view".equals(arrange)?"&arrange=view":""%>"><%=num %></a></li>
<%
	}
%>					

				<li class="page-item <%=!pagination.isExistNext() ? "disabled" :"" %>"><a class="page-link" href="list.jsp?pageNo=<%=pagination.getNextPage()%><%="view".equals(arrange)?"&arrange=view":""%>" >다음</a></li>
			    <li class="page-item">
			      <a class="page-link" href="list.jsp?pageNo=<%=pagination.getEnd() %>" aria-label="Next">
			        <span aria-hidden="true">&raquo;</span>
			      </a>
			    </li>
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