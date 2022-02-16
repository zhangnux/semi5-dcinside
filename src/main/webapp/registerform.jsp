<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" >
	<link rel = "stylesheet" href="/semi5/common/style.css">
	<title>## CONNECTING HEARTS! 디시인사이드입니다. ## </title>
</head>
<body>
<div class="dcwrap">
	<%@include file="/common/navbar.jsp" %>
		<div class="wrap_inner">
			<main class="dc_container">
				<section class="left_content">
 
         
		         	<div class="row">
		         	
		               <div class="cont_head">
		                 <h3 class="head_tit">기본 정보 입력</h3>
		               </div>
		               
		                  <fieldset>
		                  
	                  <div>
	                     <p class="blind m-3 border-bottom border-primary">회원가입 폼</p>
	                  </div>
		                   
		                <form class="m-2 border p-3 bg-light" method="post" action="register.jsp">                   
		                 <div class="mb-3 row">
		                   <label for="id" class="col-sm-2 col-form-label">아이디</label>
		                   <div class="col-sm-10">
		                     <input type="text" class="form-control" id="user-id" name="id" style="width:350px;" placeholder="아이디를 입력해 주세요." maxlength="30">
		                   </div>
		                 </div>
			                 
		                 <div class="mb-3 row">
		                   <label for="password" class="col-sm-2 col-form-label">비밀번호</label>
		                   <div class="col-sm-10">
		                     <input type="password" class="form-control" id="user-password" name="password" style="width:350px;" placeholder="비밀번호를 입력해 주세요." maxlength="20">
		                   </div>
		                 </div>
		                    <!-- 이 아래로 바꿔주세요 ~67까지 -->
		                 <div class="mb-3 row">
		                 	<label for="password" class="col-sm-2 col-form-label">이름</label>
		                  	 <div class="col-sm-10">
		                     <input type="text" class="form-control" id="user-name" name="name" style="width:350px;" placeholder="이름을 입력해주세요." maxlength="20">
		                   	 </div>
		                 </div>
		                 
		                 <div class="mb-3 row">
		                   <label for="password" class="col-sm-2 col-form-label">전화번호</label>
		                   <div class="col-sm-10">
		                     <input type="text" class="form-control" id="user-tel" name="tel" style="width:350px;" placeholder="전화번호를 입력해주세요." maxlength="20">
		                   </div>
		                 </div>
		                 
		                 <div class="mb-3 row">
		                   <label for="password" class="col-sm-2 col-form-label">이메일</label>
		                   <div class="col-sm-10">
		                     <input type="text" class="form-control" id="user-email" name="email" style="width:350px;" placeholder="이메일을 입력해주세요." maxlength="20">
		                   </div>
		                 </div>
		                 
	                        <div class="mb-3 text-end">
	                           <button type="submit" class="btn btn-primary">회원가입</button>
	                        </div>
		                  
		                   </form>                  
		              </fieldset>    
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