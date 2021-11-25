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
	
	var pList_str = JSON.stringify(${pList});
	var pList_json = JSON.parse(pList_str);
	var pList_Array = new Array;
	var onelineCnt = 1;
	var forCnt=1; 
	
	for(var i = 0 ; i <pList_json.length ;i++){
		
			var pListObj = new Object;
			//대표이미지
			var pSlideImg_json = JSON.parse(pList_json[i].pslideimg);
			
			
			var imgDirJSON_str = JSON.stringify(pSlideImg_json.imgDir); 
			var imgDirJSON = JSON.parse(imgDirJSON_str);
			
			//var imgDirJSON_len = Object.keys(imgDirJSON).length;

				
			//대표이미지
			var imgDirOneJSON = imgDirJSON.slideImg_1
				
			var path = "/resources/imgUpload/product/";
			var s_path = "slide/s/";
			var yearDir = imgDirOneJSON.year+"/";
			var monthDir = imgDirOneJSON.month+"/";
			var dateDir = imgDirOneJSON.date+"/";
			var productDir = imgDirOneJSON.product+"/";
			var s_fileName = imgDirOneJSON.s_fileName;
		
			
			pListObj.pimgDir =path+yearDir+monthDir+dateDir+productDir+s_path+s_fileName;
			pListObj.pregdate = pList_json[i].pregdate
			pListObj.pid = pList_json[i].pid;
			pListObj.pname = pList_json[i].pname;
			pListObj.pprice = pList_json[i].pprice;
			pListObj.pcnt = pList_json[i].pcnt;
			pListObj.pccode = pList_json[i].pccode;
			pListObj.pnum = pList_json[i].pnum;
			
			
			
			pList_Array.push(pListObj);
		
	}
	
	
	for(var i = 0 ; i <pList_Array.length; i++){
		
		var html ="<div class='product-card card shadow-sm mx-1' style='max-width:25%'>"
			
			html +="<img class='py-1 px-1' src='"+pList_Array[i].pimgDir+"'/>"
			
			html +="<div class='product-card-body py-3 px-2 card-body'>"
			html +="<ul class='list-unstyled product-card-ul mb-2'>"
			html +="<li class='product-card-li pn'><p class='mb-1'>"+pList_Array[i].pname+"</p></li>";
			html +="<li class='product-card-li'><p class='mb-1'>가격 : "+pList_Array[i].pprice+"</p></li>";
			html +="<li class='product-card-li'><p class='mb-1'>남은 수량 : "+pList_Array[i].pcnt+"</p></li>";
			html +="<li class='product-card-li'><p class='mb-1'>등록일: "+pList_Array[i].pregdate+"</p></li>";
			html +="</ul>"
			html +="<div class='product-btn-group'>"
			html +="<button type='button' class='btn btn-outline-primary mx-1'>재입고신청</button>"
			html +="<button type='button' class='btn btn-outline-info mx-1' onclick='goPUpdatePage("+pList_Array[i].pnum+")'>제품 수정</button>"
			html +="<button type='button' class='btn btn-outline-danger mx-1'><i class='far fa-trash-alt'></i></button>"
			html +="</div>"
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
									html2 +="<li id='"+parentCategoryArray[i].ccode+"' class='list-group-item pl-5' onclick='selectCategory("+parentCategoryArray[i].ccode+")'>전체</li>"
		for(var j = 0 ; j <categoryArray.length ; j++){
			if(parentCategoryArray[i].ccode == categoryArray[j].ccoderef){
										
										html2 +="<li  id='"+categoryArray[j].ccode+"' class='list-group-item pl-5' onclick='selectCategory("+categoryArray[j].ccode+")' >"+categoryArray[j].cname+"</li>";
									}
									
								}
								html2 +="</ul>"
								parentCategoryList.append(html2);
							
						}
	 
})

function goPUpdatePage(pnum){
	
	location.href="/view/admin/go/productUpdatePage?pnum="+pnum;
}

					
function productAll(){
						
	location.reload();
					}

function selectCategory(code){
	
	$(".card-deck").children().remove();
	var sortNum = code%10;
	var pList_str = JSON.stringify(${pList});
	var pList_json = JSON.parse(pList_str);
	var pList_Array = new Array;
	var onelineCnt = 1;
	var forCnt=1; 
	
	for(var i = 0 ; i <pList_json.length ;i++){
		
			var pListObj = new Object;
			//대표이미지
			var pSlideImg_json = JSON.parse(pList_json[i].pslideimg);
				
			var imgDirJSON_str = JSON.stringify(pSlideImg_json.imgDir); 
			var imgDirJSON = JSON.parse(imgDirJSON_str);
			
			//var imgDirJSON_len = Object.keys(imgDirJSON).length;

			//대표이미지
			var imgDirOneJSON = imgDirJSON.slideImg_1
				
			var path = "/resources/imgUpload/product/";
			var s_path = "slide/s/";
			var yearDir = imgDirOneJSON.year+"/";
			var monthDir = imgDirOneJSON.month+"/";
			var dateDir = imgDirOneJSON.date+"/";
			var productDir = imgDirOneJSON.product+"/";
			var s_fileName = imgDirOneJSON.s_fileName;
				
			
			pListObj.pimgDir =path+yearDir+monthDir+dateDir+productDir+s_path+s_fileName;
			pListObj.pregdate = pList_json[i].pregdate;
			pListObj.pid = pList_json[i].pid;
			pListObj.pname = pList_json[i].pname;
			pListObj.pprice = pList_json[i].pprice;
			pListObj.pcnt = pList_json[i].pcnt;
			pListObj.pccode = pList_json[i].pccode;
			
			if(sortNum == 0){
				
				if(code == pList_json[i].pccoderef){
					
					pList_Array.push(pListObj);
				}
			}else{
				
				if(code == pList_json[i].pccode){
					
					pList_Array.push(pListObj);
				}
			}
			
	}
	
	
	for(var i = 0 ; i <pList_Array.length; i++){
		
		var html ="<div class='product-card card shadow-sm mx-1' style='max-width:25%'>"
			
			html +="<img class='py-1 px-1' src='"+pList_Array[i].pimgDir+"'/>"
			
			html +="<div class='product-card-body py-3 px-2 card-body'>"
			html +="<ul class='list-unstyled product-card-ul mb-2'>"
			html +="<li class='product-card-li pn'><p class='mb-1'>"+pList_Array[i].pname+"</p></li>";
			html +="<li class='product-card-li'><p class='mb-1'>가격 : "+pList_Array[i].pprice+"</p></li>";
			html +="<li class='product-card-li'><p class='mb-1'>남은 수량 : "+pList_Array[i].pcnt+"</p></li>";
			html +="<li class='product-card-li'><p class='mb-1'>등록일 : "+pList_Array[i].pregdate+"</p></li>";
			html +="</ul>"
			html +="<div class='product-btn-group'>"
			html +="<button type='button' class='btn btn-outline-primary mx-1'>재입고신청</button>"
			html +="<button type='button' class='btn btn-outline-info mx-1'>제품 수정</button>"
			html +="<button type='button' class='btn btn-outline-danger mx-1'><i class='far fa-trash-alt'></i></button>"
			html +="</div>"
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

