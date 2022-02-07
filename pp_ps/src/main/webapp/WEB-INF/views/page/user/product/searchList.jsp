<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style>
.page-content-title{
	padding : 1rem;
	border-bottom : 1px solid #dee2e6;
}

.page-content-title_span{
	
	font-size: 1.25rem;
	font-weight: bold;
}
.page-sub-content-title{
	padding : .5rem;
	border-bottom : 1px solid #dee2e6;
}
.page-content-sub-title_span{
	font-size: 0.75rem;
	font-weight: bold;
	    align-self: end;
}
.sortBy-select{
	width :10rem;
}

.page-content{
	display: flex;
	flex-wrap: wrap;
}
.page-content_group{
	padding : .5rem;
}

.page-content_box{

    border-radius: 10px;
    min-height: 26rem;
}

.p-list-box {
	display: flex;
	flex-direction: column;
	padding: .5rem;
}
.img-box>img {
    width: -webkit-fill-available;
    border-radius: 10px;
}
.info-box {
	padding: .5rem;
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

.product-one:hover{
	cursor: pointer;
    filter: contrast(0.8);
    box-shadow: 1px 1px 12px 1px #dee2e6;
    border-radius: 10px;
}
</style>

<div class="page">
	<div class="page-container">
	
		<div class=" page-content-title mt-3">
			<span class="page-content-title_span">"${q}"에 대한 검색 결과</span> 
		</div>
		
		<div class=" page-sub-content-title mt-3 d-flex justify-content-between">
			<span class="page-content-sub-title_span">${fn:length(pList)} 개의 제품</span>
			<select class="custom-select sortBy-select">
				<option>정렬</option>
			</select> 
		</div>
		
		<div class="page-content py-3">
			<c:forEach items="${pList }" var ="plist">
				<div class="col-3 page-content_group ">
					<div class="page-content_box product-one" onclick="goProduct('${plist.pid}')">
						<div class="p-list-box_content img-box" >
							<img id="img-${plist.pid }"/>
							<script>
								
								var pimgStr = JSON.stringify(${plist.pimg});
								var pimgJSON = JSON.parse(pimgStr);
								var path =pimgJSON.img.path;
								var fileName = pimgJSON.img.fileName; 
								
								$("#img-${plist.pid}").attr("src" ,"/resources"+path+"/s/s_"+fileName);
							</script>
						</div> 
						<div class="p-list-box_content info-box">
							<p class="info-box_p info-pname">${plist.pname}</p>	
							
							<c:if test="${plist.psale > 0 }">
								
								<p class="info-box_p info-psale-before-pprice">
									<fmt:formatNumber pattern="###,###,###" value="${plist.pprice}"/>원
								</p>	
								<p class="info-box_p info-psale-after-pprice">
									<span class="info-psale_span info-psale_span-psale">
										<fmt:formatNumber type="percent" value="${plist.psale}"/>
									</span>
									<span class="info-psale_span info-psale_span-pprice">
										<c:set var="sale_price" value="${plist.pprice - (plist.pprice * plist.psale)}"/>
										<fmt:formatNumber type="number" pattern="###,###,###" value="${sale_price + (10-(sale_price%10))%10}"/>원 
									</span>	
								</p>	
							</c:if>
							<c:if test="${plist.psale == 0 }"> 
								<p class="info-box_p info-price">
									<fmt:formatNumber pattern="###,###,###" value="${plist.pprice}"/>원
								</p>
							</c:if>
							 
							<p class="info-box_p info-rating"> 
							
								<c:set value ="${plist.prating * 20 }" var = "rating"/>
								
								<span class="info-rating_span"> 
									<span class="rating" style="width:${rating}%"></span>
								</span>
								<span class="info-reviewCnt-span">
									${plist.reviewCnt }
								</span>
							</p>	  
						
						</div>
						
						
					</div>
				</div>
			</c:forEach>
		</div>
	</div>
</div>

<script>
function goProduct(pid){
	
	location.href="/product/"+pid;
}
</script>