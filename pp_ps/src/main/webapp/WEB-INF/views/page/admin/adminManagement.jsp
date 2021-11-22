<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="container">
<div class="d-md-flex flex-md-equal w-100 my-md-3 pl-md-3">
  <div class="mr-md-3 pt-3 px-3 pt-md-5 px-md-5 text-center overflow-hidden admin-ui-box" id="prodListPage"> 
    <div class="my-3 py-3">
      <h2 class="display-5">제품 목록</h2>
      <p class="lead">제품 등록, 제품 수정, 제품 삭제</p>
    </div>
    <div class="bg-light shadow-sm mx-auto admin-ui-menu my-2" style="width: 80%; height: 300px; border-radius: 21px 21px 0 0;">
    	<img src="/resources/img/dog_food_01.png" class="w-100">
    </div>
  </div>
  <div class="mr-md-3 pt-3 px-3 pt-md-5 px-md-5 text-center overflow-hidden admin-ui-box" id="QnAListPage"> 
    <div class="my-3 p-3">
      <h2 class="display-5">Q & A</h2>
      <p class="lead">고객 질의 응답</p>
    </div> 
    <div class="bg-light shadow-sm mx-auto admin-ui-menu my-2" style="width: 80%; height: 300px; border-radius: 21px 21px 0 0;">
    	<img src="/resources/img/QnA_01.png" class="w-100">
    </div>
  </div>
</div>


<div class="d-md-flex flex-md-equal w-100 my-md-3 pl-md-3">
  <div class="mr-md-3 pt-3 px-3 pt-md-5 px-md-5 text-center  overflow-hidden admin-ui-box" id="userListPage"> 
    <div class="my-3 py-3">
      <h2 class="display-5">회원관리</h2>
      <p class="lead">회원 정보 조회, 회원 수정 , 강제 탈퇴</p>
    </div>
    <div class="bg-light shadow-sm mx-auto admin-ui-menu my-2" style="width: 80%; height: 300px; border-radius: 21px 21px 0 0;">
    
    		<img src="/resources/img/client_01.png" class="w-100">
    </div>
  </div>
  <div class="mr-md-3 pt-3 px-3 pt-md-5 px-md-5 text-center overflow-hidden admin-ui-box" id="notiseListPage">
    <div class="my-3 p-3">
      <h2 class="display-5">공지사항</h2>
      <p class="lead">Pet Shop Notice </p>
    </div> 
    <div class="bg-light shadow-sm mx-auto admin-ui-menu my-2" style="width: 80%; height: 300px; border-radius: 21px 21px 0 0;">
    		<img src="/resources/img/postit-g9f347f86b_640.png" class="w-100">
    
    </div>
  </div>
</div> 
</div>
 <script>
 
 $(".admin-ui-box").click(function(){
	 
	 var page =$(this).attr("id");
	 
	 location.href="/view/admin/go/"+page;
	 
 })
 
 </script>