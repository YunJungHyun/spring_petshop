<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
.page-container{

	background-color: #7fe7d552;
	height :30rem;
	border-radius: 10px;
	    display: flex;
    justify-content: center;
    align-items: center;
}
.page-content{
	
	background-color:#fff;
	border-radius:5px;
	width:20rem;
	height:20rem;
	text-align: center;
	    display: flex;
    flex-direction: column;
    justify-content: space-between;
}
.page-content_group{
	padding :3rem 0px;
}
.text-span{

	font-size: 1.25rem;
	font-weight: bold;
}
.next-link-span{
	
}
</style>
    
<div class="page my-3">

	<div class="page-container">
		<div class="page-content">
			<div class="page-content_group">
				 <span class="text-span">주문 완료 되었습니다.</span>
			 </div>
			 <div class="page-content_group">
			 	<span class="next-link-span">
					<a href="/view/mypage/myOrder" class="btn btn-outline-primary">주문 내역 보기</a>
				</span>
			 	<span class="next-link-span">
					<a href="/" class="btn btn-primary">쇼핑 계속하기</a>
				</span>
			 </div>
		</div>
	</div>
</div>