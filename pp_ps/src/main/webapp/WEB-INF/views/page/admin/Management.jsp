<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style>
.page-container{
	display:flex;
	justify-content: space-around;
}

.page-content {
	text-align: center;
	border: 1px solid;
	border-radius: 8px;
}
.page-content_group{
	height: 20rem;
    display: flex;
    flex-direction: column;
    justify-content: space-between;
}
.page-content_group:hover {
	cursor: pointer;
}
.page-content_group_title {
	display: block;
	padding: 1rem;
	font-weight: bold;
	font-size: 1.25rem;
}
.page-content_group_box {
	padding: 2rem 1rem;
} 
</style>
<div class="page pt-5">
	<div class="page-container">
		<div class="page-content col-2">
			<div class="page-content_group" id="Product">
				<span class="page-content_group_title">제품 관리</span>
				<div class="page-content_group_box">
					<img src="/resources/icon/prod.png">
				</div>
			</div>
		</div>
		<div class="page-content col-2">
			<div class="page-content_group" id="Order">
				<span class="page-content_group_title">주문 관리</span>
				<div class="page-content_group_box">
					<img src="/resources/icon/order.png">
				</div> 
			</div>
		</div> 
		<div class="page-content col-2">
			<div class="page-content_group" id="Member">
				<span class="page-content_group_title">회원 관리</span>
				<div class="page-content_group_box">
					<img src="/resources/icon/user.png">
				</div>
			</div>
		</div>
		<div class="page-content col-2">
			<div class="page-content_group"  id="Review">
				<span class="page-content_group_title">제품 후기 관리</span> 
				<div class="page-content_group_box">
					<img src="/resources/icon/reviews.png">
				</div>
			</div>
		</div>  
		<div class="page-content col-2">
				<div class="page-content_group"  id="QnA">
				<span class="page-content_group_title">Q&A</span> 
				<div class="page-content_group_box">
					<img src="/resources/icon/qna.png">
				</div>
			</div>
		</div>
	</div>
</div>
<script> 
	$(document).on("click",".page-content_group", function(){
		
		
		var page = $(this).attr("id");
		location.href="/adminView/"+page;
	})
</script>