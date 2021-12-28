<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<style>
.myPageHeader {
	border: 1px solid #cccccc7d;
	padding: 1.5rem 3rem;
	border-radius: 4px;
}

.my-icon-img-box {
	padding: 1.5rem;
	border-radius: 50%;
	overflow: hidden;
	align-self: center;
	color: white;
	background-color: #7fe7d5ab;
	width: 85px;
	text-align: center;
}

.my-sub-title {
	text-align: center;
	font-weight: bold;
	padding: 1rem 1rem 0rem 1rem;
}

.myPage-go {
    width: fit-content;
    margin: 0px auto;
}
.myPage-go:hover{
	cursor:pointer;
}
.myPage-go:hover .my-icon-img-box{ 
	background-color: #7fe7d5;

}
</style>
<div class="myPageHeader my-3 col-12">
	<div class="row">
		<div class="col-3 ">
		
			<div class="d-flex flex-column myPage-go">
				<div class="my-icon-img-box">
					<i class="far fa-user fa-2x"></i>
				</div>
				<span class="my-sub-title">내 정보 </span>
			</div>
		</div>
		<div class="col-3 ">
			<div class="d-flex flex-column myPage-go">
				<div class="my-icon-img-box">
					<i class="far fa-heart fa-2x"></i>
				</div>
				<span class="my-sub-title">관심 상품 </span>
			</div>
		</div>
		<div class="col-3 ">
			<div class="d-flex flex-column myPage-go">
				<div class="my-icon-img-box">
					<i class="fas fa-shopping-cart fa-2x"></i>
				</div>
				<span class="my-sub-title">주문 내역 </span>
			</div>
		</div>
		<div class="col-3 ">
			<div class="d-flex flex-column myPage-go">
				<div class="my-icon-img-box">
					<i class="fas fa-shopping-basket fa-2x"></i>
				</div>
				<span class="my-sub-title">장바구니 </span>
			</div>
		</div>

	</div>
</div>