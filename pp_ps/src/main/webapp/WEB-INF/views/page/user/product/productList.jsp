<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<style>
.page-container {
	display: flex;
}

.page-content-left {
	padding-top: .5rem;
	padding-bottom: .5rem;
	border-right: 1px solid #dee2e6;
}

.page-content-left_category {
	
}

.c-list_ul_li_span {
	display: block;
	font-weight: bold;
	padding: 0.75rem .5rem;
}

.c-list_ul_li_span:hover {
	background-color: #c1e9e387;
	cursor: pointer;
}

.c-list_ul_li.show {
	border-bottom: 1px solid #dee2e6;
}

.c-list_ul_li.show>.c-list_ul_li_span {
	border-bottom: 1px solid #dee2e6;
	color: red;
}

.c-list_sub_ul {
	display: none;
}

.c-list_sub_ul_li {
	
	text-indent: 1rem;
}

.c-list_sub_ul_li:hover {
	background-color: #c1e9e387;
	font-weight: bold;
	cursor: pointer;
}

.c-list_sub_ul_li_span {
	display: block;
	padding-top: 0.5rem;
	padding-bottom: 0.5rem;
}
/* right  */
.page-content-right_title {
	border-bottom: 1px solid #dee2e6;
}

.page-content-right_title.title-1 {
	padding: 1.65rem 1rem 0rem;
	font-weight: bold;
	font-size: 1.25rem;
}

.page-content-right_title.title-2 {
	display: flex;
	justify-content: space-between;
	padding: 1rem 1rem .25rem;
}

.title-2_span {
	align-self: self-end;
	font-weight: bold;
	font-size: .75rem;
}

.title-2_select {
	width: 7rem;
	font-size: .75rem;
}

.page-content-right_product {
	padding: 1rem;
	display: flex;
	flex-wrap: wrap;
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

.open {
	font-weight: bold;
	color: red;
}

</style>

<div class="page">
	<div class="page-container"> 
		<div class="page-content-left col-2">
			<div class="page-content-left_category c-list">
				<ul class="c-list_ul">
					<li class="c-list_ul_li">
						<span class="c-list_ul_li_span" id="all-category">전체</span>
					</li>
					<c:forEach var="clist" items="${cList}">
					
					<c:if test="${clist.level == 1 }">
					<li class="c-list_ul_li">
						<span id="category-${clist.ccode}" class="c-list_ul_li_span">
							${clist.cname}
							<i class="fas fa-arrow-circle-down float-right" style="color :#ccc"></i>
						</span>
						 
						<ul class="c-list_sub_ul"> 
							<li class="c-list_sub_ul_li" >
								<span id="category-sub-${clist.ccode}" class="c-list_sub_ul_li_span">전체</span>
							</li>
							<c:forEach var="clist_sub" items="${cList }">
								<c:if test="${clist_sub.level == 2 && clist.ccode == clist_sub.ccoderef}">
									<li class="c-list_sub_ul_li" >
										<span  id="category-sub-${clist.ccode}${clist_sub.ccode}" class="c-list_sub_ul_li_span">
										${clist_sub.cname}
										</span>
									</li>
								</c:if>
							</c:forEach>
						</ul>
					</li>
					</c:if>
					</c:forEach>
				</ul>
			</div>
		</div>
		<div class="page-content-right col-10">
			<div class="page-content-right_title title-1">
			</div>
			<div class="page-content-right_title title-2"> 
				<span class="title-2_span">
					${pTotal}개의 제품
				</span>  
				<select class="custom-select title-2_select" id="productSortBy">
					<option value="ORDER_BY_REGDATE_DESC" <c:if test="${openSortBy == 'ORDER_BY_REGDATE_DESC' ||  openSortBy == ''}">selected</c:if>>최신순</option>
					<option value="ORDER_BY_PPRICE_DESC" <c:if test="${openSortBy == 'ORDER_BY_PPRICE_DESC' }">selected</c:if>>가격높은순</option>
					<option value="ORDER_BY_PPRICE_ASC" <c:if test="${openSortBy == 'ORDER_BY_PPRICE_ASC' }">selected</c:if>>가격낮은순</option>
					<option value="ORDER_BY_PRATING_DESC" <c:if test="${openSortBy == 'ORDER_BY_PRATING_DESC' }">selected</c:if>>평점높은순</option>
					<option value="ORDER_BY_REVIEW_CNT_DESC" <c:if test="${openSortBy == 'ORDER_BY_REVIEW_CNT_DESC' }">selected</c:if>>후기많은순</option>
					
				</select>
			</div> 
			
			<div class="page-content-right_product p-list">
				<c:forEach  var="plist" items="${pList }">
					<div class="col-3 p-list-box" id="${plist.pid }" > 
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
				</c:forEach>
			</div>
	
			<c:forEach begin="${paging.startPage }" end="${paging.endPage }" var="p">
				<c:choose>  
					<c:when test="${p == paging.nowPage }">
						<b>${p }</b> 
					</c:when>
					<c:when test="${p != paging.nowPage }">
						<a href="/category/${openCcode}?page=${p }">${p }</a>
					</c:when>
				</c:choose>
			</c:forEach>
		
		</div>
	</div>
</div> 

<script> 



$(document).ready(function(){
	var oc = "${openCcode}";
	var categoryName = "";
	if(oc != 000){
		if(oc.length >=3 && oc.length <= 4){ // 상위카테고리를 선택했을경우
		 
				$("#category-"+oc).parent().addClass("show");
				$("#category-"+oc).next("ul").slideToggle(100);
				categoryName = $("#category-"+oc).text();
		}else{ 
		
			var ccoderef= oc.substr(0,oc.length/2);
			var ccode= oc.substr(oc.length/2,oc.length); 
		
			$("#category-"+ccoderef).parent().addClass("show");
			$("#category-"+ccoderef).next("ul").slideToggle(100);
			categoryName = $("#category-sub-"+oc).text();
		} 
		
		$("#category-sub-"+oc).addClass("open"); 
		
	}else{ 
		
		$("#all-category").parent().addClass("show");
		$("#all-category").addClass("open"); 
		categoryName = "전체";
	}
	$(".c-list_ul_li.show").find("svg").replaceWith("<i class='fas fa-arrow-circle-up float-right' style='color :#7fe7d5'></i>");
	$(".title-1").append(categoryName.trim());
	
	
	/* ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡratingㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ  */
	
	
})
$(".c-list_ul_li_span").on("click",function(e){
	
	 
	if($(this).attr("id") =="all-category"){ 
		location.href="/category/000?page=1&sortBy=0"; 
		
	}
	
	$(this).next("ul").stop().slideToggle(100);
	
	/* icon  */
	/* 열 때  */
	if(!$(this).parent("li").hasClass("show")){
		
		$(this).parent("li").addClass("show");
		$(this).find("svg").replaceWith("<i class='fas fa-arrow-circle-up float-right' style='color :#7fe7d5'></i>");
	
	/* 닫을 때 */
	}else{
		

		$(this).parent("li").removeClass("show");
		$(this).find("svg").replaceWith("<i class='fas fa-arrow-circle-down float-right' style='color :#ccc'></i>");
	}

})

$(".c-list_sub_ul_li_span").on("click", function(e){
	var ccode = $(this).attr("id").split("-")[2]; 
	location.href="/category/"+ccode+"?page=1&sortBy=0";
}) 

$(document).on("click",".p-list-box",function(){
	
	location.href="/product/"+$(this).attr("id");
})

$("#productSortBy").on("change",function(){
	
	var sortBy= $(this).val();
	var oc ="${openCcode}";
	location.href="/category/"+oc+"?page=1&sortBy="+sortBy;
})
</script>