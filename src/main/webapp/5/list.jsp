<%@page import="vo.Pagination"%>
<%@page import="vo.CoinBoard"%>
<%@page import="dao5.CoinBoardDao"%>
<%@page import="java.util.List"%>
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
		<div class="wrap_inner">
			<main class="dc_container">
				<section class="left_content">
					
<!-- 게시글 제목 시작 --> <article>
							<div>
								<header>
									<div class="col d-flex justify-content-between">
										<div class="coinTitle col-3"><h2 class="fw-bold"><a href="list.jsp?categoryNo=5" style="font-size:30px;">코인 갤러리</a></h2></div>
										<div class="col-5">
											<a><img src="https://static.upbit.com/logos/BTC.png" width="20" height="20"><strong class="ms-1 fs-5">비트코인</strong></a>
											<a><img src="https://static.upbit.com/logos/ETH.png" width="20" height="20"><strong class="ms-1 fs-5">이더리움</strong></a>
											<a><img src="https://static.upbit.com/logos/DOGE.png" width="20" height="20"><strong class="ms-1 fs-5">도지코인</strong></a>
										</div>
									</div>
								</header>		
							</div>
<!-- 게시글 제목 끝 -->  </article>
						<%
							User loginUserInfo = (User)session.getAttribute("LOGIN_USER_INFO");
							int categoryNo = Integer.parseInt(request.getParameter("categoryNo"));
									    String pageNo = request.getParameter("pageNo");
										String list = request.getParameter("list");
										String register = request.getParameter("register");
									
										CoinBoardDao boardDao = CoinBoardDao.getInstance();
										
										int totalRecords = boardDao.getTotalRecords();
										
										Pagination pagination = new Pagination(pageNo, totalRecords);
										
										List<CoinBoard> boardList = null;
										
										if("view".equals(list)){
											boardList = boardDao.getBoardListByView(pagination.getBegin(), pagination.getEnd());
										}else{
											boardList = boardDao.getBoardList(pagination.getBegin(), pagination.getEnd());
										}
										
										if("completed".equals(register)){
						%>
								<script type="text/javascript">
									alert("회원가입이 완료되었습니다.");
								</script>	
							<%
								}
								%>
<!-- 게시글 시작 --> 	 <article> 		
							<div class="col d-flex justify-content-between mb-3 mt-2">
									<div>
										<a href="list.jsp?list=no&categoryNo=<%=categoryNo%>" class="btn btn-primary">전체글</a>
										<a href="list.jsp?list=view&categoryNo=<%=categoryNo%>" class="btn btn-primary">개념글</a>
									</div>						
							</div>
							<ul class="time_list">
								
								
								<table class="table table-sm">
										<thead>
											<tr class="d-flex border-top border-primary">
												<th class="col-2">번호</th>
												<th class="col-5"><div class="mx-auto" style="width: 90px;">제목</div></th>
												<th class="col-1">글쓴이</th>
												<th class="col-2">작성일</th>
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
						}else{
											for (CoinBoard board : boardList) {
						%>
											<tr class="d-flex">
												<td class="col-1"><%=board.getNo() %></td>
												<td class="col-6"><a href="detail.jsp?no=<%=board.getNo()%>&categoryNo=<%=categoryNo%>">
												<%=board.getTitle()%> 
												<%
												if(board.getCommentCount()>0){
												%>
												(<%=board.getCommentCount() %>)
												<%
												}
												%>
												</a></td>
												<td class="col-1"><%=board.getWriter().getId()%></td>
												<td class="col-2"><%=board.getCreatedDate()%></td>
												<td class="col-1"><%=board.getViewCount()%></td>
												<td class="col-1"><%=board.getLikeCount()%></td>
											</tr>
						<%
							}
						}
						%>
										</tbody>	
									</table>	
<!-- 게시글 끝 -->			</ul>
<!-- 아래 버튼 시작 -->			<div class="col d-flex justify-content-between mt-2">
							<!-- 플렉스(flex): https://getbootstrap.kr/docs/5.1/utilities/flex/ -->
												<!-- div 기준으로 양옆으로 배치 -->
												<div>
													<a href="list.jsp?list=no&categoryNo=<%=categoryNo%>" class="btn btn-primary">전체글</a>
													<a href="list.jsp?list=view&categoryNo=<%=categoryNo%>" class="btn btn-primary">개념글</a>
												</div>
												<!-- div 기준으로 끝쪽으로 배치 -->
												<div class="d-flex flex-row-reverse">
													<%
													 if(loginUserInfo==null){
													%>
														<a class="btn btn-primary ms-1" onclick="loginPlease()">글쓰기</a>
													<%
													 }
													 else{
													%>
														<a href="form.jsp" class="btn btn-primary ms-1">글쓰기</a>
													<%
													}
													%>
												</div>
<!-- 아래 버튼 끝 -->			</div>
							
<!-- 페이지버튼 시작 -->		
<div class="row mb-3">
		<div class="col-6 offset-3">
			<nav>
				<ul class="pagination justify-content-center">
					<!-- 
						Pagination객체가 제공하는 isExistPrev()는 이전 블록이 존재하는 경우 true를 반환한다.
						Pagination객체가 제공하는 getPrevPage()는 이전 블록의 마지막 페이지값을 반환한다.
					 -->
					<li class="page-item <%=!pagination.isExistPrev() ? "active" : "disabled" %>"><a class="page-link" href="list.jsp?pageNo=<%=pagination.getPrevPage()%>&list=<%=list%>&categoryNo=<%=categoryNo%>" >이전</a></li>
<%
	// Pagination 객체로부터 해당 페이지 블록의 시작 페이지번호와 끝 페이지번호만큼 페이지내비게이션 정보를 표시한다.
	for (int num = pagination.getBeginPage(); num <= pagination.getEndPage(); num++) {
%>					
					<li class="page-item <%=pagination.getPageNo() == num ? "active" : "" %>"><a class="page-link" href="list.jsp?pageNo=<%=num%>&list=<%=list%>&categoryNo=<%=categoryNo%>"><%=num %></a></li>
<%
	}
%>					
					<!-- 
						Pagination객체가 제공하는 isExistNext()는 다음 블록이 존재하는 경우 true를 반환한다.
						Pagination객체가 제공하는 getNexPage()는 다음 블록의 첫 페이지값을 반환한다.
					 -->
					<li class="page-item <%=!pagination.isExistNext() ? "active" :"disabled" %>"><a class="page-link" href="list.jsp?pageNo=<%=pagination.getNextPage()%>&list=<%=list%>&categoryNo=<%=categoryNo%>" >다음</a></li>
				</ul>
			</nav>
		</div>
	</div>	
<!-- 페이지버튼 끝 -->	    	

						</article>
					</section>
<!-- 오른쪽 섹션 시작 --><section class="right_content ms-3">

				</section>
				<section class="right_content">
					<%@include file="/common/right_section.jsp" %>
				</section>
			</main>
		</div>
		<%@include file="/common/footer.jsp" %>
	</div>			
<script type="text/javascript">
	function loginPlease(){
		alert("로그인이 필요합니다.");
	}
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>