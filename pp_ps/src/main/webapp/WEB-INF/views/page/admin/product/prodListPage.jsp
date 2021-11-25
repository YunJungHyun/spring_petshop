<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
	.category-list{
	
		
	}
	a{
		color :#000;
	}
	a:hover{
	 	text-decoration: none;
	 	color :#000; 
	 	font-weight: bold; 
	}
	
	.list-group-item:hover{
		
		cursor: pointer;
		font-weight: bold; 
	}
	
	.card-deck .card {
    
     margin-right: 0px; 
 
     margin-left: 0px; 
}
</style>

<div class="page">
	<div class="container">
		<div class="page-emptied-admin"></div>
		<div class="page-contents d-flex flex-column justify-content-center ">
			<div class="prod-list-header d-flex flex-row justify-content-between">
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
			<hr>
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
						<c:forEach begin ="0" end="${fn:length(pList)/4 }" step="1" varStatus="status">
							<div class="card-deck mb-3 text-center" id="card-deck-${status.count }">
    							
							</div>
						</c:forEach>
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
	
	var plistJson =JSON.parse('${pList}');
	var onelineCnt = 1;
	var forCnt=1;
	
	var plistArr = new Array;
	var pListObj = new Object;
	
	for(var i = 0 ; i < plistJson.length ;i++){
		
		
		var pListObj = new Object;
		pListObj.pid = plistJson[i].pid;
		pListObj.pname = plistJson[i].pname;
		pListObj.pprice = plistJson[i].pprice;
		pListObj.pcnt = plistJson[i].pcnt;
		pListObj.pccode = plistJson[i].pccode;
		plistArr.push(pListObj);
		
	}
	//7
	for(var i = 0 ; i <plistArr.length; i++){
		
		var html ="<div class='card shadow-sm' style='max-width:25%'>"
			html +="<div class='card-header'>"
			html +="<h4 class='my-0 font-weight-normal'>"+plistArr[i].pccode+"</h4>"
			html +="</div>"
			html +="</div>"
			
			if(forCnt <= 4){
		
				$("#card-deck-"+onelineCnt).append(html);
				forCnt++;
			}else{
				
				onelineCnt++;
				forCnt = 2;
				$("#card-deck-"+onelineCnt).append(html);
			}
	}
	
	
})


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
							html += "class='list-group-item list-group-item parent-Category' "
							html += "id='"+parentCategoryArray[i].ccode+"'>"
							html += parentCategoryArray[i].cname
							html +="</a>";
						
							parentCategoryList.append(html);
							
							
							var html2 ="<ul id='category"+parentCategoryArray[i].ccode+"' class='collapse list-group'>"
								html2 +="<li id='"+parentCategoryArray[i].ccode+"' class='list-group-item pl-5' onclick='selectCategory("+parentCategoryArray[i].ccode+")'>전체</li>"
							for(var j = 0 ; j <categoryArray.length ; j++){
								if(parentCategoryArray[i].ccode == categoryArray[j].ccoderef){
									
									html2 +="<li  id='"+categoryArray[j].ccode+"' class='list-group-item pl-5' onclick='selectCategory("+categoryArray[j].ccode+")' >"+categoryArray[j].cname+"</li>";
								}
								
							}
							html2 +="</ul>"
							parentCategoryList.append(html2);
						
					}
					
function productAll(){
						
	location.reload();
					}

function selectCategory(code){
	
	$(".card-deck").children().remove();
	var sortNum = code%10;
	var plistJson =JSON.parse('${pList}');
	var onelineCnt = 1;
	var forCnt=1;
	
	var plistArr = new Array;
	var pListObj = new Object;
	
	for(var i = 0 ; i < plistJson.length ;i++){
		
		if(sortNum == 0 ){
			
			if(code == plistJson[i].pccoderef){
				var pListObj = new Object;
				pListObj.pid = plistJson[i].pid;
				pListObj.pccode = plistJson[i].pccode;
				plistArr.push(pListObj);
			
			}
		}else{
			
			if(code == plistJson[i].pccode){
				var pListObj = new Object;
				pListObj.pid = plistJson[i].pid;
				pListObj.pccode = plistJson[i].pccode;
				plistArr.push(pListObj);
			}
		}
		
		
	}
	//7
	for(var i = 0 ; i <plistArr.length; i++){
		
		var html ="<div class='card shadow-sm' style='max-width:25%'>"
			html +="<div class='card-header'>"
			html +="<h4 class='my-0 font-weight-normal'>"+plistArr[i].pccode+"</h4>"
			html +="</div>"
			html +="</div>"
			
			if(forCnt <= 4){
		
				$("#card-deck-"+onelineCnt).append(html);
				forCnt++;
			}else{
				
				onelineCnt++;
				forCnt = 2;
				$("#card-deck-"+onelineCnt).append(html);
			}
	}
}
					 
			
$("#category-insert-modal").on('show.bs.modal', function (e) {
	
	$.ajax({
		
		url : "/admin/category/getCategoryList",
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
		
		url: "/admin/category/categoryInsert",
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

