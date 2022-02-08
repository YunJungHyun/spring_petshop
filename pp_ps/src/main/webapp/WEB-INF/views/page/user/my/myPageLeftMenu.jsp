<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<style>

.myPageLeftMenu{

	
}
.myPageLeftMenu-ul{
	
	list-style:none; 
	padding :unset;
}
.myPageLeftMenu-li-parent-title{
	border-bottom : 1px solid #cccccc7d;
	font-weight : bold;
}

.myPageLeftMenu-li-title >a{
	
	color : #717171;
}

.myPageLeftMenu-li-title:hover{
	
	
	font-weight: bold;
	background-color: #cccccc4a;
	
}
.myPageLeftMenu-li-title.mark >a{

	color:red;
	font-weight: bold;
	background-color: #cccccc4a;
}

.myPageLeftMenu-li-title:hover .myPageLeftMenu-li-icon{

	color:#7fe7d5;
}


.myPageLeftMenu-li-icon{
	color :#71717161;
}

.MyInfoCnt {
	
	line-height: normal;
	vertical-align: middle;
	background-color: #d6f7f2;
	padding-left: 0.5rem;  
    padding-right: 0.5rem;
	
	
}
</style>
<div class="myPageLeftMenu col-2 px-0 py-3 mr-3 border-right" >
 
	<ul class="myPageLeftMenu-ul">
		<li class="myPageLeftMenu-li-parent-title mb-2 py-2 px-3">내 정보</li>
		<li class="myPageLeftMenu-li-title mb-2 py-2 px-3" id="myInfo">
			<a href="/view/mypage/myInfo">
				<span class="d-flex justify-content-between">
					<span>나의 기본 정보</span>
					<span class="myPageLeftMenu-li-icon">
						<i class="fas fa-chevron-right"></i>
					</span>
				</span>
			</a>
		</li>
		<li class="myPageLeftMenu-li-parent-title mb-2 py-2 px-3">나의 쇼핑</li>
		<li class="myPageLeftMenu-li-title mb-2 py-2 px-3" id="myWish">
			<a href="/view/mypage/myWish">
				
				<span class="d-flex justify-content-between">
					<span>관심</span>
					<span> 
						<span id="likeCnt" class="MyInfoCnt badge"></span>
						<span class="myPageLeftMenu-li-icon">
							<i class="fas fa-chevron-right"></i>
						</span>
					</span>
				</span>
			</a>		
		</li>
		<li class="myPageLeftMenu-li-title mb-2 py-2 px-3" id="myOrder">
			<a href="/view/mypage/myOrder">
				<span class="d-flex justify-content-between">
					<span>주문 내역</span>
					<span>
						<span id="orderCnt" class="MyInfoCnt badge"></span>
						<span class="myPageLeftMenu-li-icon">
							<i class="fas fa-chevron-right"></i>
						</span>
					</span>
				</span>
			</a>
		</li>
		
 
		<li class="myPageLeftMenu-li-parent-title mb-2 py-2 px-3">나의 구매 후기</li>
		<li class="myPageLeftMenu-li-title mb-2 py-2 px-3" id="myReviewWriter" >
			<a href="/view/mypage/myReviewWriter">
				<span class="d-flex justify-content-between">
					<span>리뷰 작성하기</span>
					<span>
						<span id="canReviewCnt"class="MyInfoCnt badge"></span>
						<span class="myPageLeftMenu-li-icon">
						<i class="fas fa-chevron-right"></i>
						</span>
					</span>
				</span> 
			</a>		
		</li>
		<li class="myPageLeftMenu-li-title mb-2 py-2 px-3" id="myReviewList">
			<a href="/view/mypage/myReviewList">
				<span class="d-flex justify-content-between">
					<span>작성한 리뷰</span>
					<span>
						<span id="reviewCnt"class="MyInfoCnt badge"></span>
						<span class="myPageLeftMenu-li-icon">
							<i class="fas fa-chevron-right"></i>
						</span>
					</span>
				</span>
			</a>		
		</li>
		
		<li class="myPageLeftMenu-li-parent-title mb-2 py-2 px-3">나의 Q&A</li>
		<li class="myPageLeftMenu-li-title mb-2 py-2 px-3" id="myQnA">
			<a href="/view/mypage/myQnA">
				<span class="d-flex justify-content-between">
					<span>Q&A </span>
					<span>
						<span id="qnaCnt" class="MyInfoCnt badge"></span>
						<span class="myPageLeftMenu-li-icon">
							<i class="fas fa-chevron-right"></i>
						</span>
					</span>
				</span>
			</a>		
		</li>
		
	</ul> 
</div>

<script>
$(document).ready(function(){
	$(".myPageLeftMenu-li-title").each(function(){
		
		
		if($(this).attr("id") == "${mark}"){
			
			$(this).addClass("mark");
		}
	})
	
	$.ajax({
		
		url : "/view/leftMenuInfo",
		type:"POST",
		success:function(data){
			
			$("#reviewCnt").text(data.reviewCnt);
			$("#canReviewCnt").text(data.canReviewCnt);
			$("#orderCnt").text(data.orderCnt);
			$("#qnaCnt").text(data.qnaCnt);
			$("#likeCnt").text(data.likeCnt);
		}
		
	})
	
	
})

</script>
