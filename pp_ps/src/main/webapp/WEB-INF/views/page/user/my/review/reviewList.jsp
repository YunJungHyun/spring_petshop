<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="/WEB-INF/views/page/user/my/myPageHeader.jsp"%>

<style>
.myPageBody-list-oneLine{
	border-bottom : 1px solid #dee2e6;
	padding : 1rem;
	display: flex;
}

.product-img{
	width : 7rem;
}

.list-img-box {
    display: flex;
    align-items: center;
}
.list-content-box{
	padding : .5rem 1rem ;
	display: flex;
    justify-content: space-between;
    width: 100%;
}

.list-content-box_ul{
	     font-size: .75rem;
	        width: 80%;
}
.list-content-box_li{
    display: flex;
	margin-bottom:.25rem;
}
.pname-span{
	font-size: 1rem;
	font-weight: bold;
}
.revContent-span{
	padding: 0.5rem 1rem;
    background-color: #7fe7d552;

    border-radius: 5px;
    min-width: 35rem;
}

.list-active-box {
    align-self: center;
}
.star-box{ 
	font-size: .75rem;
}

.star{
  display:inline-block;
  width: 10px; 
  height: 20px;
  
}
.star_left{
  background: url(/resources/icon/star-empty.png) no-repeat 0 0; 
  background-size: 20px; 
  margin-right: -2px; 
}
.star_right{
  background: url(/resources/icon/star-empty.png) no-repeat -10px 0; 
  background-size: 20px; 
  margin-left: -2px;
  margin-right: 0.25rem;
} 
.star.on{
  background-image: url(/resources/icon/star.png);
}
</style>
<div class="d-flex">
	<%@ include file="/WEB-INF/views/page/user/my/myPageLeftMenu.jsp"%>
	<div class="myPageBody col-xs-10 ">
	<div class="myPageBody_title-group">
			<span class="myPageBody_title-group_span">나의 구매후기 - 리뷰 목록</span>
		</div>
		<div class="myPageBody">
			<c:if test="${fn:length(rList) ==0 }">
				<div class="empty-info">작성한 구매 후기가 없습니다.</div>
			</c:if>
			
			<c:forEach items="${rList }" var="list" varStatus="status">
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
						<li class="list-content-box_li">
							<span class="content-span pname-span">${list.pname }</span>
						</li>
						<li class="list-content-box_li">
							<span class="content-span">주문번호 : &nbsp;</span>
							<span class="content-span">${list.orderid }</span>
						</li>
						
						<li class="list-content-box_li">
							
							<span class="content-span ">작성 날짜 : &nbsp;</span>
							<span class="content-span ">${list.revDate }</span>
						</li>
						<li class="list-content-box_li">
							<span class="star-box" id="star-box-${list.rating }">
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
							
						</li>
						<li class="list-content-box_li">
							<span class="content-span revContent-span">${list.revContent }</span>
						</li>
					</ul> 
						 
					<div class="list-active-box">
						<button class="btn btn-outline-danger" type="button" onclick="reviewDelete('${list.orderid}','${list.pid }')">구매 후기 삭제</button>
					</div>
				</div>
			</div>
				
			</c:forEach>
		</div>
	</div> 
</div>

<script>
function reviewDelete(orderid,pid){
	
	var con = confirm("해당 리뷰를 삭제 하시겠습니까?");
	if(con==true){
		
		$.ajax({
			
			
			url : "/review/delete",
			type : "POST",
			data : {
				
				"orderid" : orderid,
				"pid" : pid
			},success : function(data){
				
				if(data >=1){
					
					location.reload()
				}else{
					
					alert("리뷰 삭제 실패하였습니다.");
					location.reload();
				}
				
			}
			
		})
		
	}
}

$(document).ready(function(){
	
	$(".star-box").each(function(){
		
		var rating = $(this).attr("id").split("-")[2];
		var ratingEx = rating * 2;
		
		for(var i = 0 ; i < ratingEx ; i++ ){
			
			$(this).children().eq(i).addClass("on");
		}
	})
})

</script>