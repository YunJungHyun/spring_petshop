<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<nav class="site-header sticky-top py-3 ">
	<div class="container site-header-nav d-flex justify-content-between">
    	
    	<div class="nav-left d-flex ">
    		<div class="brand-logo mx-2">
    			<a class="py-1" href="/">
    	 			<i class="fas fa-paw fa-2x"></i> 
    	 			&nbsp; 
    				<span class="logo-title">PetSHOP</span>
    				<span class="logo-title">${userInfo.state }</span> 
    			</a> 
    		</div>
    		
		</div>
    	
    	<div class="nav-right d-flex">
    	
    		<c:if test="${userInfo.state != 'super' }">
    		<div class="nav-ui-btn d-flex flex-column mx-2 dropdown" >
    			<a class="dropdown-toggle nav-menu-btn" id="myPageMenu"  data-toggle="dropdown", aria-haspopup="true" aria-expanded="false">
    				<div class="nav-ui-icon">
    					<i class="far fa-user fa-2x"></i>
    				</div> 
    				<div class="nav-ui-icon-title">
    					<span class="nav-ui-icon-title-text">MY</span>
    				</div> 
    			</a> 
    			<div class="dropdown-menu dropdown-menu-right category-dropdown-menu" aria-labelledby="myPageMenu">
					<a class="dropdown-item" href="#">최근 본 상품</a>
					<a class="dropdown-item" href="#">찜 목록</a>
					<a class="dropdown-item" href="#">주문 취소</a> 
					
					<c:if test="${userInfo.userid == null }">
						<div class="dropdown-divider"></div>   
						<a class="dropdown-item" href="/view/user/signUpSort" >회원가입</a>
						<a class="dropdown-item" href="/view/user/joinInPage">로그인</a>
					</c:if>
					<c:if test="${userInfo.userid != null }">
						<div class="dropdown-divider"></div>   
						<a class="dropdown-item" href="#">내 정보</a>
						<a class="dropdown-item logout_btn" href="/join/logout" >로그아웃</a>
					</c:if>
					
					
				</div> 
			
    		</div> 
    			
    		 
    		<span class="py-2"></span> 
    		<div class="nav-ui-btn d-flex flex-column mx-2">
    			<div class="nav-ui-icon ">
    				<i class="fas fa-shopping-basket fa-2x"></i>
    			</div>
    			<div class="nav-ui-icon-title">
    				<span class="nav-ui-icon-title-text">장바구니</span>	
    			</div>
    		</div>
    		</c:if>
    		
    		<c:if test="${userInfo.state == 'super' }">
    			<div class="nav-ui-btn d-flex flex-column mx-2 dropdown" >
    			<a class="dropdown-toggle nav-menu-btn"  id="adminMenu" data-toggle="dropdown", aria-haspopup="true" aria-expanded="false">
    				<div class="nav-ui-icon">
    					<i class="far fa-user fa-2x"></i>
    				</div> 
    				<div class="nav-ui-icon-title">
    					<span class="nav-ui-icon-title-text">ADMIN</span>
    				</div> 
    			</a> 
    			<div class="dropdown-menu dropdown-menu-right category-dropdown-menu" aria-labelledby="adminMenu">
					<a class="dropdown-item" href="#">공지사항</a>
					<a class="dropdown-item" href="#">문의</a>
					<a class="dropdown-item" href="#">제품 등록</a> 
					
					
					<div class="dropdown-divider"></div>   
						
						<a class="dropdown-item logout_btn" href="/join/logout" >로그아웃</a>
				
					
					
				</div> 
			
    		</div> 
    		</c:if>
 	 	</div>
	</div>
</nav>

<c:if test="${page != 'admin' }">
<nav class="site-header-lg-menu  py-2 ">
	<div class="container site-header-nav d-flex justify-content-between">
    	
    	<div class="site-header-lg-menu-left d-flex ">
    		<div class="site-header-lg-menu-btn category-btn mx-3 dropdown">
    			<a class="py-1 dropdown-toggle "  href="#" id="category-dropdown" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
    				<i class="fas fa-bars"></i>
    				&nbsp;
    				<span class="lg-menu-title">카테고리</span>   
    			</a> 
    			
				<div class="dropdown-menu category-dropdown-menu" aria-labelledby="category-dropdown">
					<a class="dropdown-item" href="/view/user/join.do">Action</a>
					<a class="dropdown-item" href="#">Another action</a>
					<a class="dropdown-item" href="#">Something else here</a>
				</div>
    		</div>
    		
    		<div class="site-header-lg-menu-btn mx-3">
    			<a class="py-1 " href="#">
    				<span class="lg-menu-title">신규 상품</span>
    			</a> 
    		</div>
    		<div class="site-header-lg-menu-btn mx-3">
    			<a class="py-1 " href="#">
    				<span class="lg-menu-title">랭킹</span>
    			</a> 
    		</div>
    		<div class="site-header-lg-menu-btn mx-3">
    			<a class="py-1 " href="#">
    				<span class="lg-menu-title">강아지</span>
    			</a> 
    		</div>
    		<div class="site-header-lg-menu-btn mx-3">
    			<a class="py-1 " href="#">
    				<span class="lg-menu-title">고양이</span> 
    			</a> 
    		</div>
    		<div class="site-header-lg-menu-btn mx-3">
    			<a class="py-1 " href="#">
    				<span class="lg-menu-title">생활용품</span>
    			</a> 
    		</div>
    		 
		</div>
		
		<div class="nav-right shop-search-form d-flex">
			<div class="input-group shop-search-group">
				<input type="text" class="form-control shop-search-form-control" placeholder="상품 검색" aria-label="Input group example" aria-describedby="btnGroupAddon">
				<div class="input-group-prepend shop-search-group-text-box">
					<div class="input-group-text shop-search-group-text" id="btnGroupAddon"><i class="fas fa-search"></i></div>
				</div>
 			 </div>
 	 	</div> 
    	
	</div>
</nav>
</c:if>

<script>
$(document).ready(function(){
	
	
	
	
	
})

</script>

