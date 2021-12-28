<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>


<div class="row flex-nowrap justify-content-between align-items-center">
	<div class="col-4 pt-1 px-4">
		
	</div>
	<div class="col-4 text-center">
	
		<a class="ps-logo" href="/"><i class="fas fa-paw"></i>&nbsp;PetShop</a>
	</div>
	<c:if test="${userInfo == null }">
	<div class="col-4 d-flex justify-content-end align-items-center">		
		<div class="ps-dropdown">
			<a href="#" class="my-menu-btn"><i class="fas fa-user"></i></a>
			<ul class="ps-dropdown-content my-menu-content list-group">
				<li class="dropdown-li p-2 my-2">
					<a href="#" onclick="goPage('order')">주문 내역</a>
				</li>
				<li class="dropdown-li p-2 my-2">
					<a href="#" onclick="goPage('cart')">장바구니</a>
				</li>
				<li class="dropdown-li p-2 my-2">
					<a href="#" onclick="goPage('like')">관심 상품</a>
				</li>
				<li class="dropdown-li p-2 my-2">
					<a href="/view/login">로그인</a> 
				</li>
				
				<li  class="dropdown-li p-2 my-2"> 
					<a href="/view/signUpSort">회원가입</a>
				</li>
			</ul>
		</div>
	</div> 
	</c:if>
	<c:if test="${userInfo != null && userInfo.ulevel == 1}">
	<div class="col-4 d-flex justify-content-end align-items-center">		
		<div class="ps-dropdown">
			<a href="#" class="my-menu-btn"><i class="fas fa-user"></i></a>
			<ul class="ps-dropdown-content my-menu-content list-group">
				<li class="dropdown-li p-2 my-2">
					<a href="#" onclick="goPage('mypage/order')">주문 내역</a>
				</li>
				<li class="dropdown-li p-2 my-2">
					<a href="#" onclick="goPage('cart')">장바구니</a>
				</li>
				<li class="dropdown-li p-2 my-2">
					<a href="#" onclick="goPage('like')">관심 상품</a>
				</li>
				<li class="dropdown-li p-2 my-2">
					<a href="/join/logout">로그아웃</a> 
				</li>
				
			
			</ul>
		</div>
	</div> 
	</c:if>
	<c:if test="${userInfo != null && userInfo.ulevel == 2}">
	<div class="col-4 d-flex justify-content-end align-items-center">		
		<div class="ps-dropdown">
			<a href="#" class="my-menu-btn"><i class="fas fa-user"></i></a>
			<ul class="ps-dropdown-content my-menu-content list-group">
				<li class="dropdown-li p-2 my-2">
					<a href="/adminView/Management">관리자 페이지</a>
				</li>
				
				<li class="dropdown-li p-2 my-2">
					<a href="/join/logout">로그아웃</a> 
				</li>
				 
			
			</ul>
		</div>
	</div> 
	</c:if>
</div> 

<script>

	function goPage(sort){
		
		
		var userInfo = '${userInfo}';
		
		if(userInfo ==""){
			
			alert("로그인 후 이용가능합니다.");
			location.href="/view/login?go=login";
		}else{
			
			location.href="/view/"+sort;
		}
		
	}
</script>

