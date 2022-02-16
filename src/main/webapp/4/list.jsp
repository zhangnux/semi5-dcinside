<%@page import="vo.Board"%>
<%@page import="java.util.List"%>
<%@page import="vo.Pagination"%>
<%@page import="dao4.SoccerBoardDao"%>
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
   <div class="dcwrap">
   <%@include file="/common/navbar.jsp" %>
      <div class="wrap_inner">
         <main class="dc_container">
            <section class="left_content"> 
            
            
				<div class="row">
					<div class="col mb-4 mt-2 border-bottom">
						<div class="col">
							<h2 class="fw-bold"><a href="list.jsp">축구 갤러리</a></h2>
						</div>
					</div>		
				</div> 
<%
   String pageNo = request.getParameter("pageNo");	

   	SoccerBoardDao boardDao = SoccerBoardDao.getInstance();
   	
   	int totalRecords = boardDao.getTotalRecords();
   	
   	Pagination pagination = new Pagination(pageNo, totalRecords);
   	
   	List<Board> boardList = boardDao.getBoardList(pagination.getBegin(), pagination.getEnd());
   %>
   
	<div class="row mb-3">
		<div class="col">
			<table class="table">
				<thead>
					<tr>
						<th class="col-1">번호</th>
						<th class="col-6">제목</th>
						<th class="col-1">글쓴이</th>
						<th class="col-1">추천</th>
						<th class="col-1">조회</th>
						<th class="col-2 text-center">작성일</th>
					</tr>
				</thead>
				<tbody>
<%
if (boardList.isEmpty()) {
%>
		<tr>
			<td></td>
			<td class="text-center"> 게시글이 없습니다.</td>
		</tr>
<%
}
%>
		
<%
		for (Board board : boardList) {
		%>			
				<tr>
						<td class="col-1"><%=board.getNo()%></td>
						<td class="col-6">
							<a href="detail.jsp?no=<%=board.getNo()%>&pageNo=<%=pagination.getPageNo()%>">
							<%=board.getTitle()%></a>
						</td>
						<td class="col-1"><%=board.getWriter().getName()%></td>
						<td class="col-2"><%=board.getLikeCount()%></td>
						<td class="col-1"><%=board.getViewCount()%></td>
						<td class="col-2 text-center"><%=board.getCreatedDate()%></td>
				</tr>
<%
}
%>
				</tbody>
			</table>
			<div class="row">
				<div class="col">
					<div class="col d-flex justify-content-between">
						<div>
							<a href="list.jsp?pageNo=1" class="btn btn-primary">전체글</a>
						</div>
						<div>
<%
User loginUserInfo = (User)session.getAttribute("LOGIN_USER_INFO");

if (loginUserInfo != null) {
%>			
	<a href="form.jsp" class="btn btn-outline-primary">새 글</a>
<%
}
%>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="row">
		<div class="col">
			<nav aria-label="Page navigation example">
			  <ul class="pagination justify-content-center">
			    <li class="page-item">
			      <a class="page-link" href="list.jsp?pageNo=1" aria-label="Previous">
			        <span aria-hidden="true">&laquo;</span>
			      </a>
			    </li>
				<li class="page-item <%=!pagination.isExistPrev() ? "disabled" : ""%>"><a class="page-link" href="list.jsp?pageNo=<%=pagination.getPrevPage()%>" >이전</a></li>
<%
for (int num = pagination.getBeginPage(); num <= pagination.getEndPage(); num++) {
%>					
				<li class="page-item <%=pagination.getPageNo() == num ? "active" : ""%>"><a class="page-link" href="list.jsp?pageNo=<%=num%>"><%=num%></a></li>
<%
}
%>					

				<li class="page-item <%=!pagination.isExistNext() ? "disabled" :""%>"><a class="page-link" href="list.jsp?pageNo=<%=pagination.getNextPage()%>" >다음</a></li>
			    <li class="page-item">
			      <a class="page-link" href="list.jsp?pageNo=<%=pagination.getEnd()%>" aria-label="Next">
			        <span aria-hidden="true">&raquo;</span>
			      </a>
			    </li>
			  </ul>
			</nav>
		</div>
	</div>
		<div class="col-3 text-end">
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