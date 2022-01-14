<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
.page-container{
	display:flex;
	justify-content: center;
}

.page-content_title {
	text-align: center;
} 
.page-content_title_span {
	font-size: 2rem;
	font-weight: bold;
	width: fit-content;
	margin: 0px auto;
}
.ps-slide_inner_item {
	height: 10rem;
	width: 10rem;
	overflow: hidden;
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

.ps-slide_inner_item_img {
	object-fit: cover;
	height: -webkit-fill-available;
	border-radius: 60%;
}

.division-2{
	width: 1px;
	height: 1rem;
	background-color: #dee2e6;
	align-self: center;
	margin-left: 0.5rem;
	margin-right: 0.5rem;
}
.page-content_group_items {
	margin-bottom: 8rem;
	display: flex;
	justify-content: center;
}
.page-content_group_title-span {
	text-align: center;
	color: #ccc;
	border-bottom: 1px solid #dee2e6;
	margin-bottom: .5rem;
	display: block;
	    padding-bottom: 0.5rem;
}


.item_span-2 {
	width: 3rem;
	height: 3rem;
	border-radius: 50%;
	overflow: hidden;
}

.item_span-2_a_img {
	width: -webkit-fill-available;
	height: -webkit-fill-available;
}

.item-span-option {
	background-color: #7fe7d5;
	padding: 0.5rem;
}

.item_span-2_a {
	color: #fff;
}
 
.item_span-2_a:hover {
	filter: opacity(0.7);
}

</style>
<div class="page pt-4">
	<div class="page-container">
		<div class="page-content col-4">
			<div class="page-content_title">
				<span class="page-content_title_span">가입 유형</span>
			</div>
			<div class="page-content_group"> 
				<div class="page-content_group_slide ps-slide">
					<div  class="carousel slide" data-ride="carousel">
						<div class="carousel-inner  ps-slide_inner">
							<div class="carousel-item ps-slide_inner_item" >
								<img src="/resources/slideimg/ps_slide_img_1.jpg" class="d-block w-100" alt="...">
							</div>
							<div class="carousel-item ps-slide_inner_item" >
								<img src="/resources/slideimg/ps_slide_img_2.jpg" class="d-block w-100" alt="...">
							</div>
							<div class="carousel-item ps-slide_inner_item">
								<img src="/resources/slideimg/ps_slide_img_3.jpg" class="d-block w-100" alt="...">
							</div>
						</div> 
					</div>
				</div>
		
		
				<span class="page-content_group_title-span">간편 로그인/가입</span>
				<div class="page-content_group_items group_items">	
					<span class="item_span-2 item-span-option">
						<a href="/view/signUp" class="item_span-2_a">
							<i class="fas fa-2x fa-paw"></i>	
						</a>
					</span>
					<span class="division-2"></span>  
					<span class="item_span-2"> 
						<a href="#" class="item_span-2_a" onclick="authLogin('kakao_join')">
							<img  src="/resources/icon/kakao-talk.png" class="item_span-2_a_img">
						</a>
					</span>
					<span class="division-2"></span> 
					<span class="item_span-2">
						<a href="#" class="item_span-2_a" onclick="authLogin('naver_join')">
							<img  src="/resources/icon/naver.png"  class="item_span-2_a_img">
						</a>
					</span>
				</div>
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