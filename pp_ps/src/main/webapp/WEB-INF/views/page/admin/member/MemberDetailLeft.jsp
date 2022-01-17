<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style>
	.memeberLeftMenu-li-parent-title{
		border-bottom : 1px solid #cccccc7d;
		font-weight : bold;
		padding: 0.5rem;
	}
	
	.memeberLeftMenu-li_span{
		display: flex;
		justify-content: space-between;
		align-items: center;
	}
	

	.memeberLeftMenu-li_span {
   		 padding: 0.5rem 0.5rem .5rem 1rem;
	}
	
	.memeberLeftMenu-li_a:hover > span{
		background-color: #dee2e6;
		font-weight: bold;
	}
	.memeberLeftMenu-li_span.mark{
		background-color: #dee2e6;
		font-weight: bold;
		color :red;
	}
</style>
    
     
    
<div class="memeberLeftMenu col-2 border-right py-3">
	<ul class="memeberLeftMenu-ul">
		<li class="memeberLeftMenu-li-parent-title memeberLeftMenu-li mb-2">
			<span>회원님의 정보</span>
			
		</li>
		<li class="memberLeftMenu-li-title memeberLeftMenu-li mb-2 ">
			<a href="/user/${unum }" class="memeberLeftMenu-li_a">
				<span class="memeberLeftMenu-li_span " id="userInfoList">
					<span class="memeberLeftMenu-li_span-text"> 회원 기본 정보</span>
					<i class="fas fa-chevron-right"></i>
				</span>
			</a>
		</li>
		<li class="memeberLeftMenu-li-parent-title memeberLeftMenu-li mb-2">
			<span>회원님의 쇼핑</span>
			
		</li>
		<li class="memberLeftMenu-li-title memeberLeftMenu-li">
			<a href="#" class="memeberLeftMenu-li_a">
				<span class="memeberLeftMenu-li_span" id="shopingList">
					<span class="memeberLeftMenu-li_span-text" >구매 내역</span>
					<i class="fas fa-chevron-right"></i>
				</span>
			</a>
		</li>
		<li class="memeberLeftMenu-li-parent-title memeberLeftMenu-li mb-2">
		
			<span>회원님의 리뷰</span>
		</li>
		<li class="memberLeftMenu-li-title memeberLeftMenu-li">
			<a href="#" class="memeberLeftMenu-li_a">
				<span class="memeberLeftMenu-li_span" id="reviewList">
					<span class="memeberLeftMenu-li_span-text">리뷰 내역</span>
					<i class="fas fa-chevron-right"></i>
				</span>
			</a>
		</li>
		
		<li class="memeberLeftMenu-li-parent-title memeberLeftMenu-li mb-2">
			
			<span>회원님의 문의</span>
		</li>
		<li class="memberLeftMenu-li-title memeberLeftMenu-li">
			<a href="#" class="memeberLeftMenu-li_a">
				<span class="memeberLeftMenu-li_span" id="QnAList">
					<span class="memeberLeftMenu-li_span-text">문의 내역</span>
					<i class="fas fa-chevron-right"></i>
				</span>
			</a>
		</li>
		
	</ul>		
</div>

<script>
$(document).ready(function(){
	
	$(".memeberLeftMenu-li_span").each(function(){
		
		if( $(this).attr("id")	== "${mark}"){
		
			$(this).addClass("mark");
		}
	})
	
	
	
})

</script>


