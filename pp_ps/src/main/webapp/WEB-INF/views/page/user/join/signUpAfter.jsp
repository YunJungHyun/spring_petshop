<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<div class="page py-5">
	<div class="ps-container col-lg-6">
		<div class="page-title">
			<h2 class="text-center">회원가입 완료되었습니다 !!</h2>
		</div>
		<div class="page-box"> 
		<div class="ps-login-slide-box py-5">
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
		
		<a class="btn btn-block ps-btn-1"  href="/">상품 보러가기</a>
	
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