<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div class="pt-5"></div>
<div class="page">
	
		<div class="row justify-content-around">
			<div class="ps-group-009 col-2">
				<div class="ps-group-item-001" id="Product">
					<span class="ps-title-007">제품 관리</span>
					<div class="ps-img-box-003">
						<img src="/resources/icon/prod.png">
					</div>
				</div>
			</div>
			<div class="ps-group-009 col-2">
				<div class="ps-group-item-001" id="Order">
					<span class="ps-title-007">주문 관리</span>
					<div class="ps-img-box-003">
						<img src="/resources/icon/order.png">
					</div> 
				</div>
			</div> 
			<div class="ps-group-009 col-2">
				<div class="ps-group-item-001" id="Member">
					<span class="ps-title-007">회원 관리</span>
					<div class="ps-img-box-003">
						<img src="/resources/icon/user.png">
					</div>
				</div>
			</div>
			<div class="ps-group-009 col-2">
				<div class="ps-group-item-001"  id="Review">
					<span class="ps-title-007">제품 후기 관리</span> 
					<div class="ps-img-box-003">
						<img src="/resources/icon/reviews.png">
					</div>
				</div>
			</div>  
			<div class="ps-group-009 col-2">
				<div class="ps-group-item-001"  id="QnA">
					<span class="ps-title-007">Q&A</span> 
					<div class="ps-img-box-003">
						<img src="/resources/icon/qna.png">
					</div>
				</div>
			</div>
			
		</div>
	</div>

<script> 
	$(document).on("click",".ps-group-item-001", function(){
		
		
		var page = $(this).attr("id");
		location.href="/adminView/"+page;
	})
</script>