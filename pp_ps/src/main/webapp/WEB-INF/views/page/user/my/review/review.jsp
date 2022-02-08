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
    display: flex;
	margin-bottom: .25rem;
}

.orderid-span{
	font-weight: bold;
}
.content-span.add-sale{
	text-decoration: line-through;
}

.sale-percent{

	color:red;
}
.star{
  display:inline-block;
  width: 15px; 
  height: 30px;
  cursor: pointer; 
}
.star_left{
  background: url(/resources/icon/star-empty.png) no-repeat 0 0; 
  background-size: 30px; 
  margin-right: -3px; 
}
.star_right{
  background: url(/resources/icon/star-empty.png) no-repeat -15px 0; 
  background-size: 30px; 
  margin-left: -3px;
} 
.star.on{
  background-image: url(/resources/icon/star.png);
}

.sale-price-box{
	 display: flex;
	 flex-direction: column;
}

.arrow-icon_img{
	width : 1rem;
}

</style>

<%@ include file="/WEB-INF/views/page/user/my/myPageHeader.jsp"%>

<div class="d-flex">
	<%@ include file="/WEB-INF/views/page/user/my/myPageLeftMenu.jsp"%>
	<div class="myPageBody col-10">
	
		<div class="myPageBody_title-group">
			<span class="myPageBody_title-group_span">나의 구매후기 - 리뷰 작성하기</span>
		</div>
		<div class="myPageBody">
		<c:if test="${fn:length(crList) ==0 }">
			<div class="empty-info">구매 후기를 작성 할 수 있는 주문 목록이 없습니다.</div>
		</c:if>
		<c:forEach items="${crList }" var="list" varStatus="status">
			
			<c:set var="sale_price" value="${list.pprice - (list.pprice * list.psale)}"/>
			<c:set var="sale_price_round" value="${sale_price + (10-(sale_price%10))%10}"/>
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
						<li class="list-content-box_li ">
							<span class="label-span">주문 번호 : &nbsp; </span>
							<span class="content-span orderid-span">${list.orderid }</span>
						</li> 
						<li class="list-content-box_li">
							
							
							<span class="label-span">제품 가격 : &nbsp;</span>
							<c:if test="${list.psale == 0 }">
							<span class="content-span"><fmt:formatNumber value="${list.pprice }" pattern="###,###,###"/> 원</span>
							</c:if>
							<c:if test="${list.psale > 0 }">
										
								<div class="sale-price-box">
									<span class="content-span add-sale"><fmt:formatNumber value="${list.pprice }" pattern="###,###,###"/>원</span>
									<span>
										<span class="arrow-icon"><img class="arrow-icon_img" src="/resources/icon/reply.png"></span>
										<span class="content-span sale-percent"><fmt:formatNumber value="${list.psale }" type="percent"/> 할인</span>
										<span class="content-span "><fmt:formatNumber value="${sale_price_round }" pattern="###,###,###"/>원</span>
									</span>
								</div>
							</c:if>
						</li>
						
						<li class="list-content-box_li">
							<span class="label-span">구매 갯수 :  &nbsp;</span>
							<span class="content-span">${list.cstock }개</span>
						</li>
						
						<li class="list-content-box_li">
							<span class="label-span">구매 가격 :  &nbsp;</span>
							<span class="content-span"><fmt:formatNumber value="${sale_price_round * list.cstock } " pattern="###,###,###"/>원</span>
						</li>
						
					</ul> 
						 
					<div class="list-active-box">
						<button class="btn btn-outline-primary" type="button" data-toggle="collapse" data-target="#review-writer-${status.count }">구매 후기 작성</button>
					</div>
				</div>
			</div>
			<div id="review-writer-${status.count}" class="collapse border col-12 mb-3 p-3">
					<form id="review-form-${status.count}">
						<input type="hidden" name="pid" id="pid" value="${list.pid }">
						<input type="hidden" name="orderid" id="orderid" value="${list.orderid }">
						<div class="review-writer-oneline">
							<span>작성자 : </span>
							<span>
								${userInfo.username }</span>
						</div>
						<div class="review-writer-oneline">
							<span>평점 : </span>
							<span class="star-box" id="star-box-${status.count }">
								<span class="star star_left"></span>
								<span class="star star_right"></span>

								<span class="star star_left"></span>
								<span class="star star_right"></span>

								<span class="star star_left"></span>
								<span class="star star_right"></span>

								<span class="star star_left"></span>
								<span class="star star_right"></span>

								<span class="star star_left"></span>
								<span class="star star_right"></span>
							</span>
						</div>
						<div class="review-writer-oneline">
							<label>사용 후기</label>
							<textarea class="form-control" rows="8" name="revContent" id="revContent"></textarea>
						</div>
						<div class="review-writer-oneline text-right mt-3">
							<button type="button" class="btn btn-success" name="review-insert-btn" id="review-insert-btn-${status.count }">저장</button>
							<button type="button" class="btn btn-danger">취소</button>
						</div>
					</form>
				</div>
		</c:forEach>
		</div>
	</div>
</div>

<script>
$(".star").on('click',function(){
	
		var thisParentId = $(this).parent().attr("id");
		
	   var idx = $(this).index();
	   //console.log(idx);
	   $("#"+thisParentId).children().removeClass("on");
	     for(var i=0; i<=idx; i++){
	    	 $("#"+thisParentId).children().eq(i).addClass("on");
	   }
	 });


$("button[name='review-insert-btn']").on("click",function(){
	
	var cnt = 0;
	var rateContant = 0.5;
	
	var status = $(this).attr("id").split("-")[3];	
	var formData =$("#review-form-"+status).serialize();
	
	
	$("#star-box-"+status).children().each(function(){
		
		if($(this).hasClass("on")){
			
			cnt++;
		}
	})
	
	
	var rating = rateContant * cnt;

	formData += '&rating='+rating;
	
	$.ajax({
		
		
		url:"/review/reviewInsert",
		data : formData,
		type:"POST",
		success:function(data){
			
			if(data>=1){
				
				alert("리뷰가 작성 되었습니다.");
				location.reload();
			}
			
		}
		
	})
})


</script>