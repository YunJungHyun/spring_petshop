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
			<div class="prod-list-header d-flex flex-row justify-content-between my-3">
				<div class="btn-toolbar" role="toolbar" aria-label="Toolbar with button groups">
					<div class="btn-group mr-2" role="group" aria-label="First group">
						<button type="button" class="btn btn-secondary" onClick="location.href='/view/admin/go/productInsertPage'">제품 등록</button>
						
					</div>
					<div class="btn-group mr-2" role="group" aria-label="Second group">
						<button type="button" class="btn btn-secondary" data-target="#category-insert-modal" data-toggle="modal">카테고리 등록</button>
					</div>
				</div>
				<div class="nav-right admin-shop-search-form  d-flex justify-content-end">
					<div class="input-group shop-search-group">
						<input type="text" class="form-control shop-search-form-control" placeholder="상품 검색" aria-label="Input group example" aria-describedby="btnGroupAddon">
						<div class="input-group-prepend shop-search-group-text-box">
							<div class="input-group-text shop-search-group-text" id="btnGroupAddon"><i class="fas fa-search"></i></div>
						</div>
 			 		</div>
 	 			</div>
			</div>
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
 

<!-- Modal -->
<div class="modal fade " id="category-insert-modal" tabindex="-1" role="dialog" aria-labelledby="categoryInsertModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-md" role="document">
	<div class="modal-content">
		<div class="modal-header">
		<h5 class="modal-title" id="categoryInsertModalLabel">카테고리 등록 </h5>
		<button type="button" class="close" data-dismiss="modal" aria-label="Close">
			<span aria-hidden="true">&times;</span>
		</button>
		</div>
		<div class="modal-body">  
			<form class=" p-3" id="category-insert-form" >
				<div class="form-group">
		 			<div class="row">
		 				<div class="col-sm-3 text-center">
		 					<label class="mt-2" for="ctype">분류</label>
		 				</div>
		 				<div class="col-sm-9">
		 					<select class="custom-select" id="parentCategory">
								
								
 							</select>
 						</div>
		 			</div>
		 		</div>
				<div class="form-group">
		 			<div class="row">
		 				<div class="col-sm-3 text-center">
		 					<label class="mt-2" for="cname">이름</label>
		 				</div>
		 				<div class="col-sm-9">
		 					<input type="text" class="form-control" id="cname"  placeholder="카테고리 이름을 입력하세요." value="">
		 				</div>
		 			</div>
		 				  
		 		</div>
				
			</form>
			
			<div class="categoryList" id="categoryList">
				
			
			</div>
		</div>
		<div class="modal-footer">
			<button type="button" class="btn btn-primary" id="category-insert-btn">저장하기</button>
			<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
		</div>
	</div>
	</div>
</div>




<script>

$(document).ready(function(){
	
	getProductList("allList");
	AdminGetCategoryList();
	
})

function productArrayInput(json){
	var productObject = new Object;
	
	var pimg_JSON = JSON.parse(json.pimg);
	
	productObject.pid = json.pid;
	productObject.pname = json.pname;
	productObject.pprice = json.pprice;
	productObject.pcnt = json.pcnt;
	
	productObject.path = pimg_JSON.img.path;
	productObject.fileName = pimg_JSON.img.fileName;
	
	return productObject;
}

function getProductList(ccode){
	
	var pList = JSON.stringify(${pList});
	var pList_JSON = JSON.parse(pList);
	
	
	var productArray = new Array;
	var productObject = new Object;
	//console.log(cardRowCnt);
		
	
	if(ccode=="allList"){
		
		
		for(var i = 0 ; i < pList_JSON.length ;i++){
			
			
			
			productObject = productArrayInput(pList_JSON[i]);
			productArray.push(productObject);
			
		}
		
	}else{
		$(".product-list-row").children().remove();
		
		var ccodeSort = ccode % 10;
		
		if( ccodeSort == 0){
			
			for(var i = 0 ; i < pList_JSON.length ;i++){
				
				if(pList_JSON[i].pccoderef == ccode){
					productObject = productArrayInput(pList_JSON[i]);
					productArray.push(productObject);
			
				}
				
				
			}
		
		}else{
			
			for(var i = 0 ; i < pList_JSON.length ;i++){
				
				if(pList_JSON[i].pccode == ccode){
					productObject = productArrayInput(pList_JSON[i]);
					productArray.push(productObject);
			
				}
				
				
				
			}
			
		}
		
	}
	
	
	for(var i = 0 ; i <productArray.length ; i++){
	
		
		var html ="<div class='col-lg-3 col-md-4 col-sm-6 col-6'>";
				html+=" <div class='card mb-4 shadow-sm'>"
      			html+="<img class='product-img' src='"+productArray[i].path+"/s/s_"+productArray[i].fileName+"'/>"
	     		html+="<div class='card-body'>";
	        	html+="<p>"+productArray[i].pname+"</p>";
	        	html+="<p> 가격 : "+productArray[i].pprice+"</p>";
	        	html+="<p> 남은 수량 : "+productArray[i].pcnt+"</p>";
	        	html+="<div class='d-flex justify-content-between align-items-center'>"
	         	html+="<div class='btn-group' id='product-btn-group-"+i+"'>"
	         	
	         	html+="</div>"
	          	html+="<small class='text-muted'>9 mins</small>"
	            html+="</div>";
	            html+="</div>";
	            html+="</div>";
	            html+="</div>";
	               
	      
		$(".product-list-row").append(html);
		var btn1 = $("<button>",{"type":"button","class":"btn btn-sm btn-outline-success","text":"재입고 신청"});
		var btn2 = $("<button>",{"type":"button","class":"btn btn-sm btn-outline-primary","text":"제품 수정","onclick":"location.href='/view/admin/go/productUpdatePage?pid="+productArray[i].pid+"'"});
		
		$("#product-btn-group-"+i).append(btn1);
		$("#product-btn-group-"+i).append(btn2);
	 }
	
 }


function AdminGetCategoryList(){
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
					 
			
$("#category-insert-modal").on('show.bs.modal', function (e) {
	
	$.ajax({
		
		url : "/category/admin/getCategoryList",
		type: "POST",
		success : function(data){
			
			var html = "<option value=''>선택하세요.</option>";
			
			var categoryListHtml = ""
			
			for(var i = 0 ; i < data.length ; i++){
				
				if(data[i].ccoderef == null){
				html += "<option value='"+data[i].ccode+"'>"+data[i].cname+"</option>";
				
				
				}else{
					
					categoryListHtml += "<button type='button' class='categoryName-btn' name='"+data[i].ccoderef+"'>"+data[i].cname+"</button>";
					
				}
			
			}
			 
			$("#parentCategory").append(html); 
			$("#categoryList").append(categoryListHtml);
		}
	})
})

$("#category-insert-modal").on('hidden.bs.modal', function (e) {
	$("#categoryList").children().remove();
	$("#parentCategory").children().remove();
	$("#cname").val("");
	
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
//카테고리 insert
$("#category-insert-btn").on("click",function(){
	/* 유효성검사 시작*/
	if($("#parentCategory").val() ==""){
		
		alert("분류를 선택해주세요.");
		return false;
	}
	if($("#cname").val() ==""){
		$("#cname").focus();
		alert("카테고리 이름을 입력해주세요");
		return false;
	}
	/* 유효성검사 끝*/

	var cname = $("#cname").val();
	var parentCategory = $("#parentCategory").val();
	
	var categoryData = new Object();
	
	categoryData.cname = cname;
	categoryData.parentCategory = parentCategory;
	
	//console.log(categoryData);
	
	$.ajax({
		
		url: "/category/admin/categoryInsert",
		data : categoryData,
		method: "POST",
		success: function(data){
		
			if(data == "chkFalse"){
				
				
				alert("이미 등록된 카테고리 입니다.");
				
				
			}else if(data == "categoryInsertSuccess"){
				
				alert("카테고리 등록되었습니다.");
				location.reload();
			}else if(data == "categoryInsertFail"){
				
				alert("카테고리 등록 실패하였습니다.");
			}
			
		}
		
	})
	
	
	
})


</script>

