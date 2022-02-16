<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
<div class="row">
	<div class="col">
		<form method="post" action="commentRegister.jsp">
			<div class="mb-3">
				<input type="hidden" class="form-control" name="boardNo" value="" />
				<textarea rows="3" class="form-control" name="content" style="resize: vertical;"></textarea>
			</div>
			<div class="mb-3 text-end">
				<button type="submit" class="btn btn-primary btn-sm">댓글등록</button>
			</div>
		</form>
	</div>
</div>
</body>
</html>