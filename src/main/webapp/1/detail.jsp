<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">
<head>
   <meta charset="UTF-8">
   <meta name="viewport" content="width=device-width, initial-scale=1">
   <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" >
   <link rel="stylesheet" href="../common/style.css">
   <title>동물, 기타 본문</title>
</head>
<body>
	<div class="dcwrap">	
	<%@ include file="../common/navbar.jsp" %>
		<div class="wrap_inner">
			<main class="dc_container">
				<section class="left_content"> 
					<header>
						<div class="list_head">
							<h2>동물, 기타갤러리</h2>
						</div>
					</header>
					<article>
						
						<table class="table">
							<thead class="table-light">
								<tr><th>게임 하고싶다</th></tr>
							</thead>	
							<tbody>
								<tr>
									<td>
										<div class="col">
											<div class="col d-flex justify-content-between mb-3">
												<div>
													<a>2</a> 
													<a>2021-12-07</a>
												</div>						
												<div class="d-flex flex-row-reverse">
													<a class="ms-2">조회 100</a>
													<a>추천 10</a>				
												</div>
											</div>
										</div>
									</td>
								</tr>
								<tr class="d-flex h-auto">		
									<td style="height: 400px" class="col row ms-2">게임하고싶다!!!!!!!! 
										<div class="d-flex justify-content-center align-self-end">
											<div class="border p-3 bg-light"style="height: 100px; width: 250px;">	
												<div class="row">
													<div class="col-3">
														<p class="text-danger fs-1">40</p>
													</div>
													
													<div class="col-3">
														<a href="like.jsp"><img class="m-1" src="../resources/images/like.png"></a>
													</div>
													<div class="col-3">
														<a href="detail.jsp"><img class="m-1" src="../resources/images/unlike.png"></a>
													</div>
													
													<div class="col-3">
														<p class="text-secondary fs-1">0</p>
													</div>
												</div>
											</div>	
										</div>
								    </td>
								</tr>
							</tbody>				
						</table>
						
						<div class="row mb-3 mt-3">
							<div class="col">
								<div class="col d-flex justify-content-between mb-3">
									<div>
										<a href="list.jsp?list=no" class="btn btn-primary">전체글</a>
										<a href="list.jsp?list=view" class="btn btn-outline-primary">개념글</a>
									</div>						
									<div class="d-flex flex-row-reverse">
									
											<a href="form.jsp" class="btn btn-primary ms-1">글쓰기</a>
											<a href="delete.jsp" class="btn btn-danger ms-1">삭제</a>
											<a href="modifyform.jsp" class="btn btn-primary ms-1">수정</a>
												
									</div>
								</div>
							</div>
						</div>
					
					</article>
					<article>
						<div class="time_list">
							<table class="table table-sm">
								<thead>
									<tr class="d-flex border-top border-primary">
										<th class="col-1">번호</th>
										<th class="col-6"><div class="mx-auto" style="width: 90px;">제목</div></th>
										<th class="col-1">글쓴이</th>
										<th class="col-2">작성일</th>
										<th class="col-1">조회</th>
										<th class="col-1">추천</th>
									</tr>
								</thead>
								<tbody>
									<tr class="d-flex">
										<td class="col-1">100</td>
										<td class="col-6"><a href="detail.jsp">가나다라마바사</a></td>
										<td class="col-1">초코우유</td>
										<td class="col-2">2021-12-07</td>
										<td class="col-1">500</td>
										<td class="col-1">97</td>
									</tr>
				
								</tbody>	
							</table>	
						</div>
						<div class="col d-flex justify-content-between mt-2">
							<div>
								<a href="list.jsp?list=no" class="btn btn-primary">전체글</a>
								<a href="list.jsp?list=view" class="btn btn-outline-primary">개념글</a>
							</div>
							<div class="d-flex flex-row-reverse">
								<a href="form.jsp" class="btn btn-primary ms-1">글쓰기</a>
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