<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
	
</style>

<script src="/resources/js/moment.js"></script>

<div class="page">
	<div class="container">
		
		<div class="page-contents d-flex flex-column justify-content-center ">
			
			<%-- <%=request.getRealPath("/") %> --%>
			
			<div class="product-list-body">
				<div class="row">
				<div class="col-2">
					<div class="category-list list-group" id="category-list">
						<a type="#" class="list-group-item list-group-item-action" onclick="productAll()">
								전체
						</a>
					</div>
				</div>
				<div class="col-10">
					 <div class="product-list " id="product-list">
					 	<div class="container">
							<div class="row product-list-row">
      	

      
							</div>
						</div>  
					</div>  
				</div>
				</div>
				
			</div>
		</div> 
	</div> 
</div>  
 


<script>

$(document).ready(function(){
	
	
	getCategoryList();
	getProductList();
	
	
	
})

function getProductList(){
	

}


function getCategoryList(){
	//카테고리 불러오기
	var jsonData = JSON.parse('${cList}');
					
	var parentCategoryArray = new Array;
	var parentCategoryObj = new Object;
					
	var categoryArray = new Array;
	var categoryObj = new Object;
						
	for(var i = 0 ; i < jsonData.length ; i++){
							
		if(jsonData[i].ccoderef ==""){
			parentCategoryObj = new Object;
							
			parentCategoryObj.ccode = jsonData[i].ccode;
			parentCategoryObj.cname = jsonData[i].cname;
			parentCategoryArray.push(parentCategoryObj);
		}else{
			categoryObj = new Object;
			categoryObj.ccode = jsonData[i].ccode;
			categoryObj.cname = jsonData[i].cname;
			categoryObj.ccoderef = jsonData[i].ccoderef;
			categoryArray.push(categoryObj);
			}
		}
					 
		var parentCategoryList =$("#category-list"); 
						
						
	for(var i = 0 ; i <parentCategoryArray.length; i++){
		
		
		var html = "<a href='#' data-toggle='collapse' aria-expanded='true' aria-controls='category"+parentCategoryArray[i].ccode+"' ";
			html += "data-target='#category"+parentCategoryArray[i].ccode+"' "
			html += "class='list-group-item list-group-item parent-category' "
			html += "id='"+parentCategoryArray[i].ccode+"'>"
			html += parentCategoryArray[i].cname
			html +="</a>";
							
			parentCategoryList.append(html);
								
								
		var html2 ="<ul id='category"+parentCategoryArray[i].ccode+"' class='collapse category-ul list-group'>"
			html2 +="<li id='"+parentCategoryArray[i].ccode+"' class='list-group-item pl-5' onclick='getProductList("+parentCategoryArray[i].ccode+")'>전체</li>"
		
		
		for(var j = 0 ; j <categoryArray.length ; j++){
			
			if(parentCategoryArray[i].ccode == categoryArray[j].ccoderef){
										
				html2 +="<li  id='"+categoryArray[j].ccode+"' class='list-group-item pl-5' onclick='getProductList("+categoryArray[j].ccode+")' >"+categoryArray[j].cname+"</li>";
						
					}
									
			}
			html2 +="</ul>"
			parentCategoryList.append(html2);
							
		}
	
}



					
function productAll(){
						
	location.reload();
}

					 

$(document).on('show.bs.collapse',".category-ul",function(){
	
	$(this).prev().css("background-color","#45d4d429");
	$(this).prev().css("font-weight","bold");
	$(this).prev().css("font-size","larger");
})

$(document).on('hide.bs.collapse',".category-ul",function(){
	
	$(this).prev().css("background-color","unset");
	$(this).prev().css("font-weight","unset");
	$(this).prev().css("font-size","unset");
})
					 
			
//
$("#parentCategory").on("change", function(){
	
	var selectCcode =$(this).val();
	
	 if(selectCcode == ""){
		
		$(".categoryName-btn").css("display","inline-block");
		
	}else{
	
	$(".categoryName-btn").each(function(){
		
		
		if($(this).attr("name") != selectCcode ){
			
			$(this).css("display","none");
		}else{
			
			$(this).css("display","inline-block");
		}
	})
	
	}
	
})

</script>

