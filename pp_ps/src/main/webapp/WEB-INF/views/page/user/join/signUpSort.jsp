<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

  <div class="page py-5">
	<div class="ps-container col-lg-4">
		<div class="page-title">
			<h2 class="text-center">가입 유형</h2>
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
		
		
		<div class="auth-login-title">간편 로그인/가입</div>
		<div class="auth-login-btn-group">
			
			<a href="/view/signUp" class="mx-2 icon-a-1 ps-icon-a-1">
				<i class="fas fa-4x fa-paw p-3"></i>
			</a>
						
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



	

</script>