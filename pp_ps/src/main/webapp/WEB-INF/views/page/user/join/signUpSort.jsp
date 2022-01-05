<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="pt-4">
</div> 
  <div class="page">
	<div class="col-4">
		<div class="page-title-001">
			<span class="ps-span-001">가입 유형</span>
		</div>
		<div class="page-box"> 
		<div class="ps-slide-001">
			<div class="carousel slide" data-ride="carousel">
				<div class="carousel-inner  ps-slide-inner-001">
					<div class="carousel-item ps-slide-item-001" >
						<img src="/resources/slideimg/ps_slide_img_1.jpg" class="d-block w-100" alt="...">
					</div>
					<div class="carousel-item ps-slide-item-001" >
						<img src="/resources/slideimg/ps_slide_img_2.jpg" class="d-block w-100" alt="...">
					</div>
					<div class="carousel-item ps-slide-item-001">
						<img src="/resources/slideimg/ps_slide_img_3.jpg" class="d-block w-100" alt="...">
					</div>
				</div> 
			</div>
		</div>
		
		
			<div class="ps-title-001">간편 로그인/가입</div>
				<div class="ps-group-002">	
					<span class="ps-span-003 ps-span-004">
						<a href="/view/signUp" class="ps-btn-002" >
							<i class="fas fa-2x fa-paw"></i>
						</a>
					</span>
					<span class="ps-division-001"></span> 
					<span class="ps-span-003">
						<a href="#" class="ps-btn-002" onclick="authLogin('kakao_join')">
							<img  src="/resources/icon/kakao-talk.png">
						</a>
					</span>
					<span class="ps-division-001"></span> 
					<span class="ps-span-003">
					<a href="#" class="ps-btn-002" onclick="authLogin('naver_join')">
						<img  src="/resources/icon/naver.png">
					</a>
					</span>
				</div>
			</div>
	</div>
</div>

<script>
$(document).ready(function(){
	//슬라이드 순서 랜덤
	var ranNum = Math.random();
	var num = Math.floor(ranNum*3+1);
	$(".ps-slide-item-001").eq(num-1).addClass("active");
	
})



	

</script>