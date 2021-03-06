<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<style>
.myPageBody-list-oneLine{
	border-bottom : 1px solid #dee2e6;
	padding : 1rem;
	display: flex;
}

.product-img{
	width : 7rem;
}
.list-content-box{
	padding : .5rem 1rem ;
	display: flex;
    justify-content: space-between;
    width: 100%;
}


.list-content-box_ul{
	     font-size: .75rem;
}
.list-content-box_li{
	margin-bottom: .25rem;
}
.list-content-box_li.pname{
	font-weight: bold;
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
    font-size:1rem;
}
.add-sale-before{

	color : gray;
	text-decoration: line-through;
}
.add-sale-percent{
	font-size: 1rem;
	color:red;
}
.price-span{
	font-weight: bold;
}
ul.list-content-box_ul{

	display: flex;
	flex-direction:column;
	justify-content: space-between;
	height: 100%;
}
.helper{
	    display: inline-block;
    height: 100%;
    vertical-align: middle;
}

</style>

<%@ include file="/WEB-INF/views/page/user/my/myPageHeader.jsp"%>
<div class="d-flex">
	<%@ include file="/WEB-INF/views/page/user/my/myPageLeftMenu.jsp"%>
	<div class="myPageBody col-10">
		<div class="myPageBody_title-group">
			<span class="myPageBody_title-group_span">나의 쇼핑 - 관심</span>
		</div>
		
		<div class="myPageBody">
			<c:if test="${fn:length(wishList) == 0 }">
				<div class="empty-info">등록된 관심 제품이 없습니다.</div> 
			</c:if>
			
			<c:forEach items="${wishList }" var="list" varStatus="status">
				<div class="myPageBody-list-oneLine">
					<div class="list-img-box">
						<img src="" id="img-${status.count }" class="product-img">
						<script>
							var pimgStr = JSON.stringify(${list.pimg}); 
							var pimgJSON = JSON.parse(pimgStr);
							var path =pimgJSON.img.path;
							var fileName = pimgJSON.img.fileName;
							$("#img-${status.count}").attr("src" ,"/resources"+path+"/s/s_"+fileName);
						</script>
					</div>
					<div class="list-content-box">
						<ul class="list-content-box_ul">
							<li class="list-content-box_li pname">
								<a href="/product/${list.pid }">${list.pname }</a></li> 
							<c:if test="${list.psale == 0 }">
								<li class="list-content-box_li ">
									<span class="price-span"><fmt:formatNumber value="${list.pprice}" pattern="###,###,###"/>원</span></li>
							</c:if>
							<c:if test="${list.psale > 0 }">
								<li class="list-content-box_li add-sale-before"><fmt:formatNumber value="${list.pprice}" pattern="###,###,###"/>원</li>
								<li class="list-content-box_li">
									<span class="add-sale-percent">
										<fmt:formatNumber type="percent" value="${list.psale}"/>
									</span>
									<span class="add-sale-after price-span">
										<c:set var="sale_price" value="${list.pprice - (list.pprice * list.psale)}"/>
										<fmt:formatNumber type="number" pattern="###,###,###" value="${sale_price + (10-(sale_price%10))%10}"/>원 
									</span>
								</li> 
							</c:if>
							
							<li class="list-content-box_li info-rating">
								<c:set value ="${list.prating * 20 }" var = "rating"/>
						 			<span class="info-rating_span"> 
										<span class="rating" style="width:${rating}%"></span>
									</span>
									<span class="info-reviewCnt-span">
											(${list.reviewCnt })
									</span> 
							</li>
							
						</ul>
							<div class="list-active-box">
								<div class="helper"></div>
								<button class="btn  btn-outline-primary list-active-box_btn" onclick="wishCart('${list.pid}','${list.pcnt }')">장바구니 담기</button>
								<button class="btn btn-outline-danger list-active-box_btn" onclick="deletLike('${list.pid}')">삭제</button>
							</div>
					</div>
				
				</div>
			</c:forEach>
		</div>
	</div>

</div>

<script>

function deletLike(pid){
	
	
	$.ajax({
		
		url : "/like/delete",
		type : "post",
		data : {
			
			"pid" : pid
		},success: function(data){
			
			if( data>=1){
				
				location.reload();
			}else{
				
				alert("관심 목록 삭제에 실패하였습니다.");
				location.reload();
			}
		}
		
	}) 
}

function wishCart(pid,pcnt){
	
	
	if( pcnt ==0){
		
		alert("선택하신 제품의 재고가 없습니다. ");
		return false;
	}
	
	var userInfo = '${userInfo}';
	
	var cnt=$("#ps-cnt").val();
	
	if(userInfo == ""){
		
		alert("로그인 후 이용 가능 합니다.");
		location.href="/view/login?go=login";
	}else{
		
			
			var con = confirm("장바구니에 담으시겠습니까?");
				if(con == true){
					
					$.ajax({
						
						url : "/like/delete",
						type : "post",
						data : {
							
							"pid" : pid
						},success: function(){
							
							
						}
						
					}) 
					
					
					$.ajax({
			 
						url : "/cart/addCart",
						data : {
				
							"pid" :pid,
							"cstock" : 1
				
						},success:function(data){
				
						if(data == "cartChkTrue"){
							alert("장바구니에 이미 제품이 있습니다.");
						}
				
						if(data =="cartAddSuccess"){
								
								var con = confirm("장바구니에 담았습니다. 장바구니 목록 페이지로 가시겠습니까?");
								if(con ==true){
									location.href="/view/mypage/myCart";
								}else{
									
									location.reload();
								}
							}
				
							if(data =="cartAddFail"){
								alert("장바구니에 담기 실패 하였습다.");
							}
				
						}
			
					})
				}
		
		
		
	}
}

</script>