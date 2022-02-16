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
		<div class="col mb-5 mt-4">
		<h3>축구 갤러리</h3>
		</div>
		<div style="border:1px solid lightgray;">

			<form method="post" action="register.jsp">
				<table class="m-5">
				
					<thead>
						<tr>
							<th style="height:80px;">
								<input type="text" name="title" placeholder="제목을 입력해주세요." size=80 maxlength=40>
							</th>
						</tr>
					</thead>
					
					<tbody>
						<tr>
							<td>
								<textarea name="content" rows="20" cols="100" style="resize:none;"></textarea>
							</td>
						</tr>
					</tbody>
					
				</table>
				
				<div class="d-flex flex-row-reverse bd-highlight mb-4">
					<div>
						<a class="btn btn-light" data-bs-toggle="modal" data-bs-target="#cancelConfirm">취소</a>
						
								<!-- 취소 재확인 모달창 -->
								<div class="modal fade" id="cancelConfirm" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
								  <div class="modal-dialog modal-dialog-centered">
								    <div class="modal-content">
								      <div class="modal-header">
								        <h6 class="modal-title" id="exampleModalLabel">글쓰기</h6>
								        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
								      </div>
								      <div class="modal-body">
								        글 작성을 취소하시겠습니까?
								      </div>
								      <div class="modal-footer">
								        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
								        <a class="btn btn-primary" href="list.jsp">확인</a>
								      </div>
								    </div>
								  </div>
								</div>
								
							<button type="submit" class="btn btn-primary">등록</button>							
						</div>
					</div>
				</form>
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