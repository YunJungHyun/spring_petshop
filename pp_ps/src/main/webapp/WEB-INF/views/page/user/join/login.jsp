<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<div class="page py-5">
	<div class="ps-container col-lg-4">
		<div class="page-title">
			<h2 class="text-center">로그인</h2>
		</div>
		<div class="page-box"> 
		<div class="ps-login-slide-box pt-5 pb-3">
			<div class="carousel slide" data-ride="carousel">
				<div class="carousel-inner  ps-login-slide-inner">
					<div class="carousel-item ps-login-slide-item" id="1">
						<img src="/resources/slideimg/ps_slide_img_1.jpg" class="d-block w-100" alt="...">
					</div>
					<div class="carousel-item ps-login-slide-item" id="2">
						<img src="/resources/slideimg/ps_slide_img_2.jpg" class="d-block w-100" alt="...">
					</div>
					<div class="carousel-item ps-login-slide-item" id="3">
						<img src="/resources/slideimg/ps_slide_img_3.jpg" class="d-block w-100" alt="...">
					</div>
				</div>
			</div>
		</div>
		<form class="form-signIn">


			<div class="form-ps-group-1">
				<input type="text" id="userid" placeholder="아이디"  autofocus>

			</div>

			<div class="form-ps-group-1"> 
				<input type="password" id="userpw" placeholder="패스워드" >

			</div>


			<button class="btn btn-block ps-btn-1" id="signIn-btn" type="button">로그인</button>

		</form>
		
		<div class="user-info-find-group">
			<a href="#">아이디 찾기</a>
			<span class="division-line-1"></span>
			<a href="#">비밀번호 찾기</a>
		</div>
		<div class="auth-login-title">간편 로그인/가입</div>
		<div class="auth-login-btn-group">
		
			<a href="#" class="mx-2 icon-a-1" onclick="authLogin('kakao_join')">
				<img  src="/resources/icon/kakao-talk.png">
			</a>
			
			<a href="#" class="mx-2 icon-a-1" onclick="authLogin('naver_join')">
				<img  src="/resources/icon/naver.png">
			</a>
		</div>
	</div>
	</div>
</div>

<script>
$(document).ready(function(){
	//슬라이드 순서 랜덤
	var ranNum = Math.random();
	var num = Math.floor(ranNum*3+1);
	$(".ps-login-slide-item").eq(num-1).addClass("active");
	
})



$("#signIn-btn").on("click",function(){
	
	
	var userid = $("#userid").val();
	var userpw = $("#userpw").val();
	
/* 	if(userid == ""){
		
		alert("아이디를 입력해주세요");
		 $("#userid").focus();
		return false;
	}
	
	if(userpw == ""){
		
		alert("비밀번호를 입력해주세요");
		$("#userpw").focus();
		return false;
		
	} */
	
	 
	$.ajax({
		
		url : "/join/petShop/login",
		data : {
			
			"userid" : userid,
			"userpw" : userpw
		},
		success: function(data){
			
			if(data == "idFail"){
				
				alert("아이디가 존재하지 않습니다.");
				$("#userid").focus();
			}else if(data=="pwFail"){
				
				alert("비밀번호가 맞지 않습니다.");
				$("#userpw").focus();
			}else if(data =="success"){
				
				location.href="/";
			}
			
		}
		
	})
	
})

</script>
