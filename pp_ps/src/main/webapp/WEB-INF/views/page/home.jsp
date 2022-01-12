<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
.page_content_group_title_h{
	    padding: 0.5rem 1rem 0.25rem 1rem;
    font-weight: bold;
    border-bottom: 1px solid #dee2e6;
}

.swiper {
	min-height : 20rem;
 	 height: auto;
    
    border-radius: 8px;
  
}
.swiper-slide {
	
	display:flex; /* 내용을 중앙정렬 하기위해 flex 사용 */
	align-items:center; /* 위아래 기준 중앙정렬 */
	justify-content:center; /* 좌우 기준 중앙정렬 */
}

.p-list-box {
	display: flex;
	flex-direction: column;

	height: inherit;
    overflow: hidden;
       margin-top: 0.5rem;
    margin-bottom: 0.5rem;

}
.img-box>img {
    width: -webkit-fill-available;
    border-top-right-radius: 10px;
    border-top-left-radius:10px;
}
.info-box {
    background-color: #7fe7d52e;
    height: 100%;
	border-bottom-right-radius: 10px;
    border-bottom-left-radius:10px;
	    padding: 0.5rem;
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
.swiper-button-next {
   
      background-position: center;
    padding: 2rem;
    filter: drop-shadow(6px 6px 6px gray);
    background-color: #7fe7d5;
    border-radius: 50%;
    color: #fff;
}

.swiper-button-prev {
     background-position: center;
    padding: 2rem;
    filter: drop-shadow(6px 6px 6px gray);
    background-color: #7fe7d5;
    border-radius: 50%;
    color: #fff;
}

.swiper-button-next::after,
.swiper-button-prev::after {
  display: none;
}

.go-page:hover{
	cursor: pointer;
	filter: contrast(0.8);
    box-shadow: 1px 1px 12px 1px #dee2e6;
    border-radius: 10px;
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
	
	<div class="page_content">
		<div class="page_content_group mb-4">
			<div class="page_content_group_title">
				<h4 class="page_content_group_title_h">최신 할인 제품 
					<span class="badge float-right product-more-sapn">
						<a href="#">더 보기&nbsp;<i class="fas fa-chevron-right"></i></a>
					</span>
				</h4>
			</div>
			<div class="page_content_group_content">
				
				<div class="swiper">
					<div class="swiper-wrapper">
						<c:forEach items="${saleList }" var="list" varStatus="status">
							<div class="swiper-slide">
								<div class="p-list-box go-page">
									<a href="/product/${list.pid }" style="display:none"></a>
									<div class="p-list-box_content img-box" >
										<img id="sale-img-${status.count}"/>
										<script>
										var pimgStr = JSON.stringify(${list.pimg});
										var pimgJSON = JSON.parse(pimgStr);
										var path =pimgJSON.img.path;
										var fileName = pimgJSON.img.fileName;
								
										$("#sale-img-${status.count}").attr("src" ,"/resources"+path+"/s/s_"+fileName);
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
					<div class="swiper-button-next"><i class="fas fa-2x fa-chevron-right"></i></div>
					<div class="swiper-button-prev"><i class="fas fa-2x  fa-chevron-left"></i></div>
				</div>
				
			</div>
		</div>
		<div class="page_content_group mb-4">
			<div class="page_content_group_title">
				<h4 class="page_content_group_title_h">신규 제품
					<span class="badge float-right product-more-sapn">
						<a href="#">더 보기&nbsp;<i class="fas fa-chevron-right"></i></a>
					</span>
				</h4>
			</div>
			<div class="page_content_group_content">
				<div class="swiper">
					<div class="swiper-wrapper">
						<c:forEach items="${recentList }" var="list" varStatus="status">
							<div class="swiper-slide">
								<div class="p-list-box go-page">
									<a href="/product/${list.pid }" style="display:none"></a>
									<div class="p-list-box_content img-box" >
										<img id="recent-img-${status.count}"/>
										<script>
										var pimgStr = JSON.stringify(${list.pimg});
										var pimgJSON = JSON.parse(pimgStr);
										var path =pimgJSON.img.path;
										var fileName = pimgJSON.img.fileName;
								
										$("#recent-img-${status.count}").attr("src" ,"/resources"+path+"/s/s_"+fileName);
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
										<%--   <span class="info-reviewCnt-span">
											(${list.reviewCnt })
											</span>  --%>
										</p>	
									</div> 
								</div>
							</div>
						</c:forEach>
					</div>
					<div class="swiper-button-next"><i class="fas fa-2x fa-chevron-right"></i></div>
					<div class="swiper-button-prev"><i class="fas fa-2x  fa-chevron-left"></i></div>
				</div>
			</div>
		</div>
		<div class="page_content_group mb-4">
			<div class="page_content_group_title">
				<h4 class="page_content_group_title_h">주문 많은 제품
					<span class="badge float-right product-more-sapn">
						<a href="#">더 보기&nbsp;<i class="fas fa-chevron-right"></i></a>
					</span>
				</h4>
			</div>
			<div class="page_content_group_content">
				<div class="swiper">
					<div class="swiper-wrapper">
						<c:forEach items="${rankList }" var="list" varStatus="status">
							<div class="swiper-slide">
								<div class="p-list-box go-page">
									<a href="/product/${list.pid }" style="display:none"></a>
									<div class="p-list-box_content img-box" >
										<img id="rank-img-${status.count}"/>
										<script>
										var pimgStr = JSON.stringify(${list.pimg});
										var pimgJSON = JSON.parse(pimgStr);
										var path =pimgJSON.img.path;
										var fileName = pimgJSON.img.fileName;
								
						 				$("#rank-img-${status.count}").attr("src" ,"/resources"+path+"/s/s_"+fileName);
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
										  <%-- <span class="info-reviewCnt-span">
											(${list.reviewCnt })
											</span>  --%>
										</p>	
									</div> 
								</div>
							</div>
						</c:forEach>
					</div>
					<div class="swiper-button-next"><i class="fas fa-2x fa-chevron-right"></i></div>
					<div class="swiper-button-prev"><i class="fas fa-2x  fa-chevron-left"></i></div>
				</div>
			</div>
		</div>
			<div class="page_content_group">
				<h3 class="page_content_group_title">브랜드</h3>
			</div>
	</div>
</div>

<script src="https://unpkg.com/swiper@7/swiper-bundle.min.js"></script>

<!-- Initialize Swiper -->
<script>
var swiper = new Swiper('.swiper', {
        slidesPerView: 5,
        spaceBetween: 30,
        navigation: {
          nextEl: '.swiper-button-next',
          prevEl: '.swiper-button-prev',
        }
      });

$(".go-page").on("click",function(){
	
	location.href=$(this).children("a").attr("href");
	
})
</script>

