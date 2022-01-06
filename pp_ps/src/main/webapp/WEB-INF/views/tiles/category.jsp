<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<style>

/* 카테고리   */
.main-menu {
	padding-top: 1rem;
	padding-bottom:.5rem;
}

.main-menu_dropdown {
	margin-right: 1rem;
}

.main-menu_dropdown_a {
	font-weight: bold;
	font-size: 1.5rem;
}

.main-menu_dropdown_ul {
	text-align: left;
	height: auto;
	width: 200px;
	margin: 0 auto;
	position: absolute;
	z-index: 100;
	display: none;
	background-color: #fff;
	border-radius: 3px;
	box-shadow: 0px 9px 15px 2px rgb(0 0 0/ 10%);
}

.menu_dropdown_li_a {
	display: block;
	padding: .5rem;
}

.main-menu_group_ul {
	list-style: none;
	margin: 0;
	padding: 0;
}

.main-menu_group_li {
	margin: 0 0 0 0;
	padding: 0 0 0 0;
	border: 0;
	float: left;
	font-size: 1.25rem;
	font-weight: bold;
	margin-right: 1rem;
	margin-left: 1rem;
	text-align: center;
	padding-top: 0.3rem;
}

.main-menu_group_search {
	height: 50px;
	width: 500px;
	border: 3px solid #70e1ce;
	background-color: #fff;
	border-radius: 8px;
}

.main-menu_group_search_input {
	font-size: 16px;
	padding: 10px;
	border: 0px;
	outline: none;
	float: left;
	width: 444px;
	border-radius: unset;
	height: 100%;
	border-top-left-radius: 5px;
	border-bottom-left-radius: 5px;
}

.main-menu_group_search_input:focus-visible+.main-menu_group_search_button
	{
	outline: 0;
}

.main-menu_group_search_button {
	width: 50px;
	height: 100%;
	border: 0px;
	background-color: #70e1ce;
	outline: none;
	float: right;
	color: #fff;
	border-top-right-radius: 5px;
	border-bottom-right-radius: 5px;
}

.mmg-1 {
	display: flex;
	align-items: flex-end;
}

.mmg-2 {
	padding-bottom: .5rem;
}
</style>

<div class="main-menu">
	<div class="row justify-content-between">
		<div class="main-menu_group mmg-1">
			<div class="main-menu_dropdown">
				<a href="#" class="main-menu_dropdown_a" >카테고리</a>
				<ul class="main-menu_dropdown_ul" id="main-menu_dropdown_ul">
				
				</ul>
			</div>
		
			<ul class="main-menu_group_ul">
				<li class="main-menu_group_li">
					<a href="#">랭킹</a>
				</li>
				<li class="main-menu_group_li">
					<a  href="#">신상품</a>
				</li>
				<li class="main-menu_group_li">
					<a href="#">브랜드</a>
				</li>
			</ul>
		</div>
		<div class="main-menu_group mmg-2">
			<div class="main-menu_group_search">
				<input type="text" class="main-menu_group_search_input" placeholder="제품을 검색해보세요!"/> 
				<button type="button" class="main-menu_group_search_button"><i class="fas fa-search"></i></button>
			</div>
		</div>
	</div>
</div>
<c:if test="${breadcrumb !='none' }">
	<nav aria-label="breadcrumb"> 
		<ol class="breadcrumb mb-0">
			<li class="breadcrumb-item" aria-current="page">
				<a href="/">홈</a>
			</li>
			<c:forEach items="${breadcrumb }" var="bc">
				<li class="breadcrumb-item" aria-current="page">
					<a href="${bc.pageHref }">${bc.pageName }</a>
				</li>
			</c:forEach>
		</ol>
		  
	</nav>
</c:if>

<script>

$(".main-menu_dropdown").hover(function(){
	 
	$(this).children("ul").stop().slideToggle(100);
	
})
$(document).ready(function(){
	getCategoryList();
})

function getCategoryList(){
	$.ajax({
		
		url : "/category/getCategoryList",
		type:"POST",
		dataType : "json",
		success : function(data){
			var cateArr = new Array();
			var cateObj = new Object();
			
			var cateSubArr = new Array();
			var cateSubObj = new Object();
			
			for(var i = 0 ; i < data.length ; i++){
				
				if(data[i].level == 1){
					
					cateObj = new Object();
					cateObj.ccode = data[i].ccode;
					cateObj.cname = data[i].cname;
					cateArr.push(cateObj);
				}else if(data[i].level == 2){
					
					//console.log(data[i].cname);
					cateSubObj = new Object();
					cateSubObj.ccode = data[i].ccode;
					cateSubObj.cname = data[i].cname;
					cateSubObj.ccoderef = data[i].ccoderef;
					//console.log(data[i].ccoderef);
					cateSubArr.push(cateSubObj);
					
				}
			}
			
			var parentCategory = $("#main-menu_dropdown_ul");
			
			for(var i = 0 ; i < cateArr.length; i++){
				var html = "<li class='main-menu_dropdown_li main-menu_dropdown_li-sub-dropdown'>"
					html += "<a class='menu_dropdown_li_a' href='/category/"+cateArr[i].ccode+"'>"+cateArr[i].cname+"</a>"
					html += "<ul class='ps-ul-003' >"
					
					for(var j = 0 ; j <cateSubArr.length; j++){
				
						if(cateSubArr[j].ccoderef == cateArr[i].ccode ){ 
							html += "<li class='main-menu_dropdown_li'>"
								html += "<a class='menu_dropdown_li_a' href='/category/"+cateSubArr[j].ccoderef+cateSubArr[j].ccode+"'>"+cateSubArr[j].cname+"</a>"
							html += "</li>";
						}
					}
					
					html += "</ul>";
					html += "</li>";
				parentCategory.append(html);
			}
		}
		 
	})  
} 

$(document).on("mouseenter",".main-menu_dropdown_li-sub-dropdown",function(){
	
	$(this).children("ul").stop().slideToggle(100);
	$(this).children("ul").addClass("show");
})
$(document).on("mouseleave",".main-menu_dropdown_li-sub-dropdown",function(){
	
	if($(this).children("ul").hasClass("show")){
		
		$(this).children("ul").stop().slideToggle(50);
	}

})

</script>