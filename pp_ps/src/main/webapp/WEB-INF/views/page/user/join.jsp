<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<div class="page">
	<div class="container">
		<div class="page-contents page-join d-flex flex-column justify-content-center col-lg-8 ">
			
			
			<div class="page-banner-box">
				<h1 class="page-banner-title">회원가입</h1>
			</div>
			<div class="page-box"> 
		 		
		 		<form>
		 			<div class="form-group join-form-group">
		 				<div class="row">
		 					<label class="col-sm-2 mr-auto" for="userName">아이디</label>
		 					<input type="text" class="form-control col-sm-10" id="userName" aria-describedby="useridHelp" placeholder="이름을 입력하세요.">
		 				</div>
		 				<div class="join-guide-text col-sm-10">
		 					<small id="useridHelp" class="form-text text-muted">중복된 아이디입니다.</small>
		 					<small id="useridHelp" class="form-text text-muted">사용가능한 아이디입니다.</small>
		 				</div>  
		 			</div>
		 			<div class="form-group join-form-group">
		 				<div class="row">
		 					<label class="col-sm-2 m-auto" for="userName">비밀번호</label>
		 					<input type="text" class="form-control col-sm-10" id="userName" aria-describedby="useridHelp" placeholder="이름을 입력하세요.">
		 				</div>
		 				<div class="join-guide-text col-sm-10 ">
		 					<small id="useridHelp" class="form-text text-muted">비밀번호는 문자와 숫자를 6 ~ 18자로 작성해주세요.</small>
		 				</div>  
		 			</div>
		 			<div class="form-group join-form-group">
		 				<div class="row">
		 					<label class="col-sm-2 m-auto" for="userName">비밀번호 확인</label>
		 					<input type="text" class="form-control col-sm-10" id="userName" aria-describedby="useridHelp" placeholder="이름을 입력하세요.">
		 				</div>
		 				<div class="join-guide-text col-sm-10">
		 					<small id="useridHelp" class="form-text text-muted">비밀 번호가 확인되었습니다.</small>
		 					<small id="useridHelp" class="form-text text-muted">입력하신 비밀번호가 다릅니다.</small>
		 				</div> 
		 			</div>
		 			<div class="form-group join-form-group">
		 				<div class="row">
		 					<label class="col-sm-2 m-auto" for="userName">이름</label>
		 					<input type="text" class="form-control col-sm-10" id="userName" aria-describedby="useridHelp" placeholder="이름을 입력하세요.">
		 				</div>
		 				<div class="join-guide-text col-sm-10">
		 					<small id="useridHelp" class="form-text text-muted">회원님의 이름을 작성해주세요.</small>
		 				</div>
		 			</div>
		 			<div class="form-group join-form-group">
		 				<div class="d-flex">
		 					<label class="my-auto" for="userName">반려동물 추가</label>
		 				
		 					<button class="d-flex  justify-content-center petAdd-btn">
		 						<i class="fas fa-paw fa-2x align-self-center"></i>
		 					</button> 
		 					 
		 				</div>
		 				<div class="petNameAdd-form">
		 						<div class="petNameAdd-list d-flex flex-column"> 
		 					
		 						</div>  
		 					</div>
		 			</div>  
		 		 	
		 		</form>
		 		
		  		<button>회원가입완료</button>
			</div> 
		</div> 
	</div>
</div> 

<script> 

	$(".petAdd-btn").on("click",function(e){
		e.preventDefault();   
		var html = "<div class='d-flex my-1'>";
			html += "<select class='form-control petSort my-1'>";
			html += "<option>선택</option>";
			html += "<option>강아지</option>";
			html += "<option>고양이</option>";
			html += "<option>기타</option>";
			html += "</select>";
			html += "<input type='text' class='form-control petName my-1' placeholder='이름을 입력하세요.'>";
			html += "<button class='petRemove-btn'><i class='fas fa-minus fa-2x align-self-center'></i>"
			html += "</button></div>";
			
		$(".petNameAdd-list").append(html);
	})
	
	
	$(document).on("click", ".petRemove-btn", function() {
    	
		$(this).parent("div").remove();
    	
	});
	
</script>