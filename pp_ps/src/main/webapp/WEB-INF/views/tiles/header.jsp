<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<header class="main-header">
	<div class="row">
		<div class="col-4"></div>
		<div class="col-4">
			<a class="main-header_logo" href="/"><i class="fas fa-paw"></i>&nbsp;PetShop</a>
		</div>
		<div class="col-4">
			<div class="main-header_dropdown">
				<a href="#" class="main-header_icon"><i class="fas fa-user"></i></a>
				<ul class="main-header_dropdown-ul">
					<c:if test="${userInfo == null || userInfo.ulevel == 1 }">
						<li class="main-header_dropdown-li">
							<a href="#" class="main-header_dropdown-li_a"	onclick="goPage('mypage/myOrder')">주문 내역</a>
						</li>
						<li class="main-header_dropdown-li">
							<a href="#" class="main-header_dropdown-li_a" onclick="goPage('mypage/myCart')">장바구니</a>
						</li>
						<li class="main-header_dropdown-li">
							<a href="#" class="main-header_dropdown-li_a" onclick="goPage('mypage/myWish')">관심 상품</a></li>
						<li class="main-header_dropdown-li">
							<a href="#" class="main-header_dropdown-li_a" onclick="goPage('mypage/myInfo')">내 정보</a></li>

					</c:if>
					<c:if test="${userInfo == null}"> 
						<li class="main-header_dropdown-li">
							<a class="main-header_dropdown-li_a" href="/view/login">로그인</a></li>
						<li class="main-header_dropdown-li">
							<a class="main-header_dropdown-li_a" href="/view/signUpSort">회원가입</a>
						</li>
					</c:if>

					<c:if test="${userInfo != null && userInfo.ulevel == 2}">
						<li class="main-header_dropdown-li">
							<a class="main-header_dropdown-li_a" href="/adminView/Management">관리자페이지</a>
						</li>
					</c:if>
					<c:if test="${userInfo != null}">
						<li class="main-header_dropdown-li">
							<a class="main-header_dropdown-li_a" href="/join/logout">로그아웃</a>
						</li>
					</c:if>
				</ul>
			</div>
		</div>
	</div>
</header>

<script>


$(".main-header_dropdown").hover(function(){
	 
	$(this).children("ul").stop().slideToggle(100);
	
})
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

