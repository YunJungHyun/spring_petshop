<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<style>

.memeberLeftMenu{

	
}
.memeberLeftMenu-ul{
	
	list-style:none; 
	padding :unset;
}
.memeberLeftMenu-li-parent-title{
	border-bottom : 1px solid #cccccc7d;
	font-weight : bold;
}

.memeberLeftMenu-li-title >a{
	
	color : #717171;
}

.memeberLeftMenu-li-title:hover{
	
	
	font-weight: bold;
	background-color: #cccccc4a;
	
}
.memeberLeftMenu-li-title.mark >a{

	color:red;
	font-weight: bold;
	background-color: #cccccc4a;
}

.memeberLeftMenu-li-title:hover .memeberLeftMenu-li-icon{

	color:#7fe7d5;
}


.memeberLeftMenu-li-icon{
	color :#71717161;
}

#canReviewCnt.badge,#reviewCnt.badge {
	
	line-height: normal;
	vertical-align: middle;
	background-color: #7fe7d5;
	padding-left: 0.5rem;
    padding-right: 0.5rem;
	
	
}
</style>
<div class="memeberLeftMenu col-2 px-0 py-3 mr-3 border-right">
 
	<ul class="memeberLeftMenu-ul">
		<li class="memeberLeftMenu-li-parent-title mb-2 py-2 px-3">회원님의 정보</li>
		<li class="memeberLeftMenu-li-title mb-2 py-2 px-3" id="userInfo">
			<a href="/user/${unum }">
				<span class="d-flex justify-content-between">
					<span>회원님의 기본 정보</span>
					<span class="memeberLeftMenu-li-icon">
						<i class="fas fa-chevron-right"></i>
					</span>
				</span>
			</a>
		</li>
		<!-- <li class="memeberLeftMenu-li-parent-title mb-2 py-2 px-3">회원님의 쇼핑</li>
		<li class="memeberLeftMenu-li-title mb-2 py-2 px-3" id="shopingList">
			<a href="#">
				<span class="d-flex justify-content-between">
					<span>구매 내역</span>
					<span class="memeberLeftMenu-li-icon">
						<i class="fas fa-chevron-right"></i>
					</span>
				</span>
			</a>
		</li>
		
 
		<li class="memeberLeftMenu-li-parent-title mb-2 py-2 px-3">회원님의 리뷰</li>
		<li class="memeberLeftMenu-li-title mb-2 py-2 px-3" id="reviewList" >
			<a href="#">
				<span class="d-flex justify-content-between">
					<span>리뷰 내역</span>
					<span id="canReviewCnt"class="badge"></span>
					<span class="memeberLeftMenu-li-icon">
						<i class="fas fa-chevron-right"></i>
					</span>
				</span>
			</a>		
		</li>

		
		<li class="memeberLeftMenu-li-parent-title mb-2 py-2 px-3">회원님의 문의</li>
		<li class="memeberLeftMenu-li-title mb-2 py-2 px-3" id="QnAList">
			<a href="#">
				<span class="d-flex justify-content-between">
					<span>문의 내역 </span>
					<span class="badge"></span>
					<span class="memeberLeftMenu-li-icon">
						<i class="fas fa-chevron-right"></i>
					</span>
				</span>
			</a>		
		</li> -->
		
	</ul> 
</div>

<script>
$(document).ready(function(){
	$(".memeberLeftMenu-li-title").each(function(){
		
		
		if($(this).attr("id") == "${mark}"){
			
			$(this).addClass("mark");
		}
	})
	
	/* $.ajax({
		
		url : "/review/canReviewCnt",
		type:"POST",
		success:function(data){
			
			//console.log(data);
			$("#canReviewCnt").text(data);
		}
		
	})
	
	$.ajax({
		
		url : "/review/reviewCnt",
		type:"POST",
		success:function(data){
			
			//console.log(data);
			$("#reviewCnt").text(data);
		}
		
	}) */
})

</script>
