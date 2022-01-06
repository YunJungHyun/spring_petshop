<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
.page-container{
	display:flex;
	justify-content: center;
}
/* ps-title  */
.page-content_title {
	text-align: center;
}
.page-content_title_span {
	font-size: 2rem;
	font-weight: bold;
	width: fit-content;
	margin: 0px auto;
}

.ps-slide{
	padding-top: 2rem;
	padding-bottom: 5rem;
}
.ps-slide_inner {
	height: 10rem;
	width: 10rem;
	margin: 0px auto;
	border-radius: 66%;
}
.ps-slide_inner_item {
	height: 10rem;
	width: 10rem;
	overflow: hidden;
}
 
.ps-slide_inner_item_img {
	object-fit: cover;
	height: -webkit-fill-available;
	border-radius: 60%;
}

.page-content_group_button{
	background-color: #7fe7d5;
	width: 100%;
	font-size: 1.5rem;
	font-weight: bold;
	padding: 0.5rem 1rem;
	color: #000;
	margin-bottom: 1rem;
}

</style>

<div class="page pt-4">
	<div class="page-container">
		<div class="page-content col-6">
			<div class="page-content_title">
				<span class="page-content_title_span">회원가입 완료되었습니다 !!</span>
			</div>
			<div class="page-content_group"> 
				<div class="page-content_group_slide ps-slide">
						<div id="ps-slide" class="carousel slide" data-ride="carousel">	
							<div class="carousel-inner  ps-slide_inner">
								<div class="carousel-item ps-slide_inner_item">
									<img src="/resources/slideimg/ps_slide_img_1.jpg" class="d-block w-100 ps-slide_inner_item_img" alt="...">
								</div>
								<div class="carousel-item ps-slide_inner_item">
									<img src="/resources/slideimg/ps_slide_img_2.jpg" class="d-block w-100 ps-slide_inner_item_img" alt="...">
								</div>
								<div class="carousel-item ps-slide_inner_item">
									<img src="/resources/slideimg/ps_slide_img_3.jpg" class="d-block w-100 ps-slide_inner_item_img" alt="...">
								</div>
							</div>
						</div> 
					</div>
				<a class="btn page-content_group_button"  href="/">상품 보러가기</a>
			</div>
		</div>
	</div>
</div>

<script>
$(document).ready(function(){ 
	//슬라이드 순서 랜덤
	var ranNum = Math.random();
	var num = Math.floor(ranNum*3+1);
	$(".ps-slide_inner_item").eq(num-1).addClass("active");
	
})
</script>