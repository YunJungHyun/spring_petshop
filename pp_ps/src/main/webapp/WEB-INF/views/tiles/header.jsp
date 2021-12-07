<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<style>


</style>
<nav class="site-header sticky-top d-flex flex-column ">
	<div class="container ps-nav-top pt-3 pb-2 d-flex justify-content-between">
    	<div class="nav-left d-flex ">
    		<div class="brand-logo mx-2 align-self-center">
    			<a class="" href="/">
    	 			<i class="fas fa-paw fa-2x"></i> 
    	 			&nbsp; 
    				<span class="logo-title">PetSHOP</span>
    				<span class="logo-title">${userInfo.state }</span> 
    			</a> 
    		</div>
    		
		</div>
    	
    	<div class="nav-right d-flex">
    		<div class="ps-nav p-2 dropdown-container" >
  				<a href="#" class="ps-nav-a-1 d-flex flex-column" onclick="navDropdown('myDropdown')">
    				<i class="far fa-user fa-2x"></i>
					<span class="ps-nav-text">MY</span>
    			</a>
    			<div id="myDropdown" class="dropdown-content ps-nav-dropdown-content ">
	    			<a href="#">최근 본 상품</a>
					<a href="#">찜목록</a>
					<a href="#">주문 취소</a>
					<div class="dropdown-divider"></div>
					<a href="/view/user/signUpPage">회원가입</a>
					<a href="/view/user/signUpSort">로그인</a>
    			</div>
			
    		</div> 
    		<span class="ps-vl-1 mx-2"></span> 
    		<div class="ps-nav p-2 ">
    			<a href="#"  class="ps-nav-a-1 d-flex flex-column">
    				<i class="fas fa-shopping-basket fa-2x"></i>
    				<span class="ps-nav-text">장바구니</span>
    			</a>
    		</div>
      	
 	 	</div>
	</div>
	
	<div class="ps-nav-lower py-3 w-100 ">
    
    	<div class="container">
    		<div class="ps-nav-lower-left d-flex ">
    			<div class="mx-3 dropdown-container">
    				<a href="#" onclick="navDropdown('categoryDropdown')">
    					<i class="fas fa-bars"></i>
    					&nbsp;
    					<span class="lg-menu-title">카테고리</span>   
    				</a> 
    			
					<div id="categoryDropdown" class="dropdown-content my-2 " >
						<div class="category-children-content"></div>
						<div class="category-parent-content"></div>
					
					</div>
					
    			</div>
    		
    			<div class=" mx-3">
    				<a class=" " href="#">
    					<span class="lg-menu-title">신규 상품</span>
    				</a> 
    			</div>
    			<div class=" mx-3">
    				<a class=" " href="#">
    					<span class="lg-menu-title">랭킹</span>
    				</a> 
    			</div>
    			<div class=" mx-3">
    				<a class=" " href="#">
    					<span class="lg-menu-title">강아지</span>
    				</a> 
    			</div>
    			<div class=" mx-3">
    				<a class=" " href="#">
    					<span class="lg-menu-title">고양이</span> 
    				</a> 
    			</div>
    			<div class=" mx-3">
    				<a class=" " href="#">
    					<span class="lg-menu-title">생활용품</span>
    				</a> 
    			</div>
    		 	
			</div>
		</div>	
	</div>
</nav>

<script>


	function navDropdown(sort){
		
		
		if($("#"+sort).hasClass("show")){
			
			//$("#"+sort).toggle("hide");
			$("#"+sort).slideToggle("fast");
			$("#"+sort).removeClass("show");
			
		}else{
			
			$("#"+sort).slideToggle("fast");
			$("#"+sort).addClass("show");
		}
		
	}
	
	  $('.dropdown-container').focusout(function(e) {
		
		  
		if($(this).children(".dropdown-content").hasClass("show")){
			$(this).children(".dropdown-content").slideToggle("fast");
			$(this).children(".dropdown-content").removeClass("show");
		}
		
	});  

	
	 $(document).on("mousedown",".dropdown-content a ",function(){
		 
		 var href_str=$(this).attr("href");
		 
		 location.href = href_str;
	 })
	


</script>



<script>
$(document).ready(function(){
	
	
	navGetCategoryList();
	
	//자식카테고리
	$("a[name='parentCategory']").hover(function(){
		 
		$(".category-children-content").css("display","block");
		$(".category-children-content").children().remove();
		
		var jsonData = JSON.parse('${cList}');
		var categoryArray = new Array;
		var categoryObj = new Object;
		var ccoderef = $(this).attr("id");
		
		for(var i = 0 ; i <jsonData.length ; i++){
			
			if(jsonData[i].ccoderef != ""){
				
				if(ccoderef == jsonData[i].ccoderef){
				categoryObj = new Object;
	 			 
				categoryObj.ccoderef = jsonData[i].ccoderef;
				categoryObj.ccode = jsonData[i].ccode;
				categoryObj.cname = jsonData[i].cname;
	 			
				categoryArray.push(categoryObj);
				}
			}
			
			
		}
		
		
		for(var i = 0 ; i < categoryArray.length ;i++){
			
			
			var categoryMenu = "<a id='"+categoryArray[i].ccode+"' href='/view/product?ccoderef="+categoryArray[i].ccoderef+"&ccode="+categoryArray[i].ccode+"' >"+categoryArray[i].cname+"</a>"
			
			$(".category-children-content").append(categoryMenu);
		}
			
		
	})

})




function navGetCategoryList(){
	
	var jsonData = JSON.parse('${cList}');
	var parentCategoryArray = new Array;
	var parentCategoryObj = new Object;
	
	for(var i = 0 ; i <jsonData.length ; i++){
		
		if(jsonData[i].ccoderef == ""){
			
			
			parentCategoryObj = new Object;
 			 
 			parentCategoryObj.ccode = jsonData[i].ccode;
 			parentCategoryObj.cname = jsonData[i].cname;
 			
 			parentCategoryArray.push(parentCategoryObj);
		}
		
		
	}
	
	

	var categoryMenu = $(".category-parent-content");
	
	
	for(var i = 0 ; i < parentCategoryArray.length ;i++){
		
		
		var categoryMenu_children = "<a name='parentCategory' id='"+parentCategoryArray[i].ccode+"' href='/view/product?ccoderef="+parentCategoryArray[i].ccode+"&ccode=all' >"+parentCategoryArray[i].cname+"</a>"
		
		categoryMenu.append(categoryMenu_children); 
	}
	
	
}
</script>

