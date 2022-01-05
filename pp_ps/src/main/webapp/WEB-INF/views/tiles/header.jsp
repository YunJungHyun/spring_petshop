<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
 
<div class="row">
	<div class="col-4"></div> 
	<div class="col-4">
		<a class="ps-a-logo" href="/"><i class="fas fa-paw"></i>&nbsp;PetShop</a>
	</div>
	
	<div class="col-4">		
		<div class="ps-dropdown ps-dropdown-001">
			<a href="#" class="ps-a-001"><i class="fas fa-user"></i></a>
			<ul class="ps-ul-001">
				<c:if test="${userInfo == null || userInfo.ulevel == 1 }">
					<li class="ps-li-001 ps-li">
						<a href="#" onclick="goPage('mypage/myOrder')">주문 내역</a>
					</li>
					<li class="ps-li-001 ps-li">
						<a href="#" onclick="goPage('mypage/myCart')">장바구니</a>
					</li>
					<li class="ps-li-001 ps-li">
						<a href="#" onclick="goPage('mypage/myWish')">관심 상품</a>
					</li>
					
				</c:if> 
				<c:if test="${userInfo == null}"> 
					<li class="ps-li-001 ps-li">
						<a href="/view/login">로그인</a>  
					</li>
					<li  class="ps-li-001 ps-li"> 
						<a href="/view/signUpSort">회원가입</a>
					</li>
				</c:if>
			
				<c:if test="${userInfo != null && userInfo.ulevel == 2}">
					<li class="ps-li-001 ps-li">
						<a href="/adminView/Management">관리자 페이지</a>
					</li>
				</c:if>
				<c:if test="${userInfo != null}">
					<li class="ps-li-001 ps-li">
						<a href="/join/logout">로그아웃</a> 
					</li>
				</c:if>
			</ul>
		</div>
	</div> 


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

