<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div class="page py-5">
	<div class="ps-container">
		<div class="row justify-content-between ">
			<div class=" admin-content-box mb-3">
				<div class="admin-content-item" id="Product">
					<div class="admin-item-title">제품 관리</div>
					<div class="admin-item-img">
						<img src="/resources/icon/prod.png">
					</div>
				</div>
			</div>
			<div class=" admin-content-box mb-3">
				<div class="admin-content-item" id="Order">
					<div class="admin-item-title">주문 관리</div>
					<div class="admin-item-img">
						<img src="/resources/icon/order.png">
					</div> 
				</div>
			</div> 
			<div class=" admin-content-box mb-3">
				<div class="admin-content-item" id="Member">
					<div class="admin-item-title">회원 관리</div>
					<div class="admin-item-img">
						<img src="/resources/icon/user.png">
					</div>
				</div>
			</div>
			<div class=" admin-content-box mb-3">
				<div class="admin-content-item"  id="Review">
					<div class="admin-item-title">제품 후기 관리</div> 
					<div class="admin-item-img">
						<img src="/resources/icon/reviews.png">
					</div>
				</div>
			</div> 
			<div class=" admin-content-box mb-3">
				<div class="admin-content-item"  id="QnA">
					<div class="admin-item-title">Q&A</div> 
					<div class="admin-item-img">
						<img src="/resources/icon/qna.png">
					</div>
				</div>
			</div>
			<div class=" admin-content-box mb-3" >
				<div class="admin-content-item" id="Notice">
					<div class="admin-item-title">공지사항</div> 
					<div class="admin-item-img">
						<img src="/resources/icon/notice.png"> 
					</div>
				</div>
			</div> 
		</div>
	</div>
</div>

<script> 
	$(document).on("click",".admin-content-item", function(){
		
		
		var page = $(this).attr("id");
		location.href="/adminView/"+page;
	})
</script>