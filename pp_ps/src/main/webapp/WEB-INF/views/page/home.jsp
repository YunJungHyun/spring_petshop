<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<style>
.main-slide {
    margin-top: 1rem!important;
    margin-bottom: 1rem!important;
    background-color: #7fe7d52e;
    padding-top: 2rem;
    padding-bottom: 2rem;
    filter: drop-shadow(3px 6px 9px #7fe7d5);
}
.main-slide_inner{ 
	height: 10rem;
}

.main-slide_inner_item{
	
	height :100%;
	overflow: hidden;
	
}

.main-slide_inner_item_img{
	object-fit: cover;
    width: auto;
    height: inherit;
    margin: 0px auto; 
    
} 

.division-1 { 
	margin: 1rem 0px; 
	height: 1px;
	background-color: #dee2e6; 
}
.page_content_group_title{
	    padding: 0.5rem 1rem 0.25rem 1.5rem;
    font-weight: bold;
    border-bottom: 1px solid #dee2e6;
}
</style> 
<div class="page">
	<div class="page_content main-slide">
		<div id="main-slide" class="carousel" data-ride="carousel">
  			<div class="carousel-inner main-slide_inner">
				
				<div class="carousel-item active main-slide_inner_item">
					<img src="/resources/slideimg/dog_1.png" class="d-block main-slide_inner_item_img" >
				</div>
				<div class="carousel-item main-slide_inner_item">
					<img src="/resources/slideimg/dog_2.png" class="d-block main-slide_inner_item_img" >
				</div>
				<div class="carousel-item main-slide_inner_item">
					<img src="/resources/slideimg/dog_3.png" class="d-block main-slide_inner_item_img" >
				</div>
				
			</div>
		</div>  
	</div>
	<div class="division-1"></div>
	<div class="page_content">
		<div class="page_content_group">
			<h2 class="page_content_group_title">할인</h2>
		</div>
		<div class="page_content_group">
			<h2 class="page_content_group_title">신상품</h2>
		</div>
		<div class="page_content_group">
			<h2 class="page_content_group_title">랭킹</h2>
		</div>
		<div class="page_content_group">
			<h2 class="page_content_group_title">브랜드</h2>
		</div>
	</div>
</div>