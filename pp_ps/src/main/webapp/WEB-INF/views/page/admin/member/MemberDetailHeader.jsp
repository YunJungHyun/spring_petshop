<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
.userName-box {
	padding: 2rem;
    border: 1px solid #dee2e6;
    border-radius: 10px;
	background-color: #dee2e6;
}
.userName-span{
	font-weight: bold;
	font-size: 1.5rem;
}


.memberPageBody_title-group{


	border-bottom : 1px solid #dee2e6;
	padding: .5rem 0px;
	margin-bottom: 1rem;
}
.memberPageBody_title-group_span{

	font-size: 1.25rem;
	font-weight: bold;
	
}

</style>
<div class="page-content userName-content my-3"> 
	<div class="userName-box">
		<span class="userName-span">${uvo.username}</span>
		<span class="userName-span-text">님의 정보 입니다.</span>
	</div>
</div>