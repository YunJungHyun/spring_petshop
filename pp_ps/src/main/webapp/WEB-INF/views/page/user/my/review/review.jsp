<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style>
.myPageBody *{
	
	font-weight: bold;
}

.list-ul{
	
	list-style: none;
	padding : 0px;
	
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
</style>

<%@ include file="/WEB-INF/views/page/user/my/myPageHeader.jsp"%>

<div class="d-flex">
	<%@ include file="/WEB-INF/views/page/user/my/myPageLeftMenu.jsp"%>
	<div class="myPageBody col-10 p-3">
		<c:forEach items="${crList }" var="list" varStatus="status">
			<div class="col-12 px-0 border mb-3 d-flex">
				<div class="col-4 p-3 text-center border-right">
					<img id="img-${status.count}"src="">
					<script>
							
							var pimgStr = JSON.stringify(${list.pimg});
							var pimgJSON = JSON.parse(pimgStr);
							var path =pimgJSON.img.path;
							var fileName = pimgJSON.img.fileName;
							
							$("#img-${status.count}").attr("src" ,"/resources"+path+"/s/s_"+fileName);
					</script>
				</div>
				<div class="col-8 p-3">
					<ul class="list-ul">
						<li>주문 번호 : ${list.orderid }</li>
						<li>${list.pname }</li>
						<li>
							<span>구매 날짜 :</span>
							<span>${list.orderDate}</span>
						</li> 
						<li>
							<span>작성 날짜 :</span>
							<span>${list.revDate}</span>
						</li>
						<li>
							<span>제품 가격 :</span>
							<span>${list.pprice }</span>
						</li>
						<li>
							<span>구매 갯수:</span>
							<span>${list.cstock }</span>
							
							</li>
						<li class="float-right">
							<button type="button" class="btn btn-primary" data-toggle="collapse" data-target="#review-writer-${status.count}" aria-expanded="false" aria-controls="review-writer-${status.count}">구매 후기 작성</button>
						</li>
					</ul>
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