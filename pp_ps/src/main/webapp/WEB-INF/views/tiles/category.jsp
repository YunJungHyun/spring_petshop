<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="ps-category-group">
	<div class="row">
		<div class="ps-dropdown">
			<a href="#" class="ps-a-002">카테고리</a>
			<ul class="ps-ul-002" id="ps-category-list-001">
			</ul>
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
			
			var parentCategory = $("#ps-category-list-001");
			
			for(var i = 0 ; i < cateArr.length; i++){
				var html = "<li class='ps-li-002 ps-li ps-dropdown-sub'>"
					html += "<a href='/category/"+cateArr[i].ccode+"'>"+cateArr[i].cname+"</a>"
					html += "<ul class='ps-ul-003' >"
					
					for(var j = 0 ; j <cateSubArr.length; j++){
				
						if(cateSubArr[j].ccoderef == cateArr[i].ccode ){ 
							html += "<li class='ps-li-002 ps-li'>"
							html += "<a href='/category/"+cateSubArr[j].ccoderef+cateSubArr[j].ccode+"'>"+cateSubArr[j].cname+"</a>"
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

$(document).on("mouseenter",".ps-dropdown-sub",function(){
	
	$(this).children("ul").stop().slideToggle(100);
	$(this).children("ul").addClass("show");
})
$(document).on("mouseleave",".ps-dropdown-sub",function(){
	
	if($(this).children("ul").hasClass("show")){
		
		$(this).children("ul").stop().slideToggle(50);
	}

})

</script>