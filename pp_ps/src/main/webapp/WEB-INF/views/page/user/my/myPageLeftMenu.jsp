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
	
	color:#000000;
	font-weight: bold;
	background-color: #cccccc4a;
	
}

.myPageLeftMenu-li-title:hover .myPageLeftMenu-li-icon{

	color:#7fe7d5;
}


.myPageLeftMenu-li-icon{
	color :#71717161;
}
</style>
<div class="myPageLeftMenu col-2 px-0 py-3 mr-3">
 
	<ul class="myPageLeftMenu-ul">
		<li class="myPageLeftMenu-li-parent-title mb-2 py-2 px-3">나의 쇼핑</li>
		<li class="myPageLeftMenu-li-title mb-2 py-2 px-3">
			<a href="#">
				<span class="d-flex justify-content-between">
					<span>주문 내역</span>
					<span class="myPageLeftMenu-li-icon">
						<i class="fas fa-chevron-right"></i>
					</span>
				</span>
			</a>
		</li>
		<li class="myPageLeftMenu-li-title mb-2 py-2 px-3">
			<a href="#">
				
				<span class="d-flex justify-content-between">
					<span>주문 취소</span>
					<span class="myPageLeftMenu-li-icon">
						<i class="fas fa-chevron-right"></i>
					</span>
				</span>
			</a>		
		</li>
 
		<li class="myPageLeftMenu-li-parent-title mb-2 py-2 px-3">나의 구매 후기</li>
		<li class="myPageLeftMenu-li-title mb-2 py-2 px-3">
			<a href="#">
				<span class="d-flex justify-content-between">
					<span>리뷰 작성하기</span>
					<span class="myPageLeftMenu-li-icon">
						<i class="fas fa-chevron-right"></i>
					</span>
				</span>
			</a>		
		</li>
		<li class="myPageLeftMenu-li-title mb-2 py-2 px-3">
			<a href="#">
				<span class="d-flex justify-content-between">
					<span>작성한 리뷰</span>
					<span class="myPageLeftMenu-li-icon">
						<i class="fas fa-chevron-right"></i>
					</span>
				</span>
			</a>		
		</li>
	</ul> 
</div>