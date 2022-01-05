<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div class="pt-4">
</div>
<div class="page">
	<div class="col-6">
		<div class="page-title-001">
			<span class="ps-span-001">회원가입 완료되었습니다 !!</span>
		</div>
		<div class="page-box"> 
		<div class="ps-slide-001">
					<div class="carousel slide" data-ride="carousel">	
						<div class="carousel-inner  ps-slide-inner-001">
							<div class="carousel-item ps-slide-item-001">
								<img src="/resources/slideimg/ps_slide_img_1.jpg" class="d-block w-100" alt="...">
							</div>
							<div class="carousel-item ps-slide-item-001">
								<img src="/resources/slideimg/ps_slide_img_2.jpg" class="d-block w-100" alt="...">
							</div>
							<div class="carousel-item ps-slide-item-001">
								<img src="/resources/slideimg/ps_slide_img_3.jpg" class="d-block w-100" alt="...">
							</div>
						</div>
					</div>
				</div>
		
		<a class="btn ps-btn ps-btn-001"  href="/">상품 보러가기</a>
	
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