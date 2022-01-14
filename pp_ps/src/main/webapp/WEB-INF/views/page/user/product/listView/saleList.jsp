<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<style>
.swiper-button-next::after,
.swiper-button-prev::after {
  display: none;
}
.category-swiper{
	
	height: 3rem;

}
.category-swiper_wrapper{

    align-items: center;
}
.category-swiper_wrapper_slide{
	background-color:#eaeef1;
    text-align: center;
    border-radius: 30px;
    width: max-content !important;
   
    height: 2rem;
}
.slide-span{
	font-size: .75rem;

    line-height: 2.5;
     padding: 0rem 1rem;
	    height: 2rem;
    display: block;
    font-weight: bold;
    border-radius: 10rem;
}

.slide-span.select-category{
	background-color: #7fe7d552;
}
.swiper-button-prev,.swiper-button-next{
	 width: 5rem!important;
    background-color: #fff;
    color: #bbb; 
}
.swiper-button-prev{
	left:0px;
	light:auto;
}
.swiper-button-next {
    right: 0px;
    left: auto;
   
}
.swiper-btn_span {
    width: 3rem;
    text-align: center;
    background-color: #eaeef1;
    height: 2rem;
    line-height: 2;
    border-radius: 25px;
}

.swiper-button-next.swiper-button-disabled, .swiper-button-prev.swiper-button-disabled {
    opacity: 0 !important;
    cursor: auto;
    pointer-events: none;
}
.page-content-title {
    padding: .5rem;
    font-size: 1.75rem;
    font-weight: bold;
}

.sub-title-product-text{
	font-size: .75rem;
}

.page-content-sub-title{
	padding : .5rem;
	font-weight: bold;
}
.product-list{
	
	display: flex; 
	flex-wrap: wrap; 
}
.p-list-box {
	display: flex;
	flex-direction: column;

	height: inherit;
    overflow: hidden;
       margin-top: 0.5rem;
    margin-bottom: 0.5rem;
    width: 20%;
}
.p-list-box-group {
    margin:.25rem;
}
.img-box>img {
    width: -webkit-fill-available;
    border-top-right-radius: 10px;
    border-top-left-radius:10px;
}
.info-box {
    background-color: #7fe7d52e;
	border-bottom-right-radius: 10px;
    border-bottom-left-radius:10px;
	padding: 0.5rem;
	min-height: 10rem;
}
.info-box_p{

	margin: unset;
}
.info-pname{
	overflow: hidden;
  text-overflow: ellipsis;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  font-weight: bold;
}
.info-psale-before-pprice{
	font-size : .75rem;
	color : #ccc; 
	text-decoration: line-through;
}
.info-psale_span-psale{

	color : red;
	font-size : 1.25rem;
	
}
.info-psale_span-pprice , .info-price{

	color : #000;
	font-weight: bold;
	font-size : 1.25rem;
	
}
.info-rating_span{

	width:122px;
}
.info-rating_span, .info-rating_span >.rating{
	display: inline-block;
	height:26px;
	overflow: hidden;
	background: url(/resources/icon/rating.png)no-repeat;
}
.info-rating_span >.rating{
	background-position: left bottom;
	line-height: 0;
	vertical-align: top;
	
}
span.info-reviewCnt-span {
    display: inline;
    vertical-align: top;
}
.go-page:hover{
	cursor: pointer;
	filter: contrast(0.8);
    box-shadow: 1px 1px 12px 1px #dee2e6;
    border-radius: 10px;
}

span.rank-span {
    font-size: 2rem;
    position: absolute;
    background-color: #7fe7d5;
    width: 3rem;
    height: 3rem;
    text-align: center;
    border-radius: 50%;
    margin: 0.5rem;
    border: 1px solid #7fe7d5;
    color: black;
    display: inline;
    font-weight: bold;
    filter: drop-shadow(1px 1px 2px #7fe7d5);
}
.product-cnt {
    font-size: .75rem;
    margin-left: 0.25rem;
}
</style>
<div class="page">
	<div class="page-container">
		<div class="page-content page-content-title mt-3">
			<span class="page-content-title_span">최신 할인</span>
		</div>
		<div class="page-content mb-2 border-bottom">
			<div class="swiper category-swiper">
				<div class="swiper-wrapper category-swiper_wrapper">
					<div class="swiper-slide category-swiper_wrapper_slide">
						<a href="/product/view/sale">
							<span class="slide-span" id="slide-span-0">전체</span>
							
						</a>
					</div>
					<c:forEach items="${cList}" var="list">
					
						<div class="swiper-slide category-swiper_wrapper_slide">
							<a href="/product/view/sale?categoryCode=${list.ccode }">
								<span class="slide-span" id="slide-span-${list.ccode }">
									${list.cname}
									<span class="badge badge-light product-cnt">${list.productCnt}</span>
								</span>
								
							</a>
						</div>
					
					</c:forEach> 
				</div>
				<div class="swiper-button-next"><span class="swiper-btn_span"><i class="fas  fa-chevron-right"></i></span></div>
				<div class="swiper-button-prev"><span class="swiper-btn_span"><i class="fas   fa-chevron-left"></i></span></div>
			</div>
		</div>
		<div class="page-content page-content-sub-title mb-2 border-bottom">
			<span class=" sub-title-product-length">${fn:length(pList)} </span>
			<span class="sub-title-product-text">개의 제품</span>
		</div>
		<div class="page-content product-list">
			<c:forEach items="${pList}" var="list" varStatus="status">
				<div class="p-list-box ">
					<div class="p-list-box-group go-page">
					<a href="/product/${list.pid }" style="display:none"></a>
					
						<div class="p-list-box_content img-box">
							<img id="img-${status.count }" src="">
							<script>
								var pimgStr = JSON.stringify(${list.pimg});
								var pimgJSON = JSON.parse(pimgStr);
								var path =pimgJSON.img.path;
								var fileName = pimgJSON.img.fileName;				
								$("#img-${status.count}").attr("src" ,"/resources"+path+"/s/s_"+fileName);
							</script>
						</div>
						<div class="p-list-box_cotent info-box">
							<p class="info-box_p info-pname">${list.pname}</p>	
							<p class="info-box_p info-psale-before-pprice">
								<fmt:formatNumber pattern="###,###,###" value="${list.pprice}"/>원
							</p>	
							<p class="info-box_p info-psale-after-pprice">
								<span class="info-psale_span info-psale_span-psale">
									<fmt:formatNumber type="percent" value="${list.psale}"/>
								</span>
								<span class="info-psale_span info-psale_span-pprice">
								<c:set var="sale_price" value="${list.pprice - (list.pprice * list.psale)}"/>
									<fmt:formatNumber type="number" pattern="###,###,###" value="${sale_price + (10-(sale_price%10))%10}"/>원 
								</span>	
							</p>	
							<p class="info-box_p info-rating">
								<c:set value ="${list.prating * 20 }" var = "rating"/>
								<span class="info-rating_span"> 
									<span class="rating" style="width:${rating}%"></span>
								</span>
								<span class="info-reviewCnt-span">
								(${list.reviewCnt })
								</span> 
							</p>	
						</div>
					</div> 
				</div>
			</c:forEach>
		</div>
		
		
	</div>
</div>
<script src="https://unpkg.com/swiper@7/swiper-bundle.min.js"></script>

<script>


$(document).ready(function(){
	
	
	if("${selectCategory}" == 0 ){
		
		$("#slide-span-0").addClass("select-category");
	}else{
		
		
		$("#slide-span-${selectCategory}").addClass("select-category");
	}
})
var swiper = new Swiper('.swiper', {
    slidesPerView: "auto",
    spaceBetween: 5,
    navigation: {
      nextEl: '.swiper-button-next',
      prevEl: '.swiper-button-prev',
    }
  });
 
$(".go-page").on("click",function(){
	
	location.href=$(this).children("a").attr("href");
	
})



</script>

    