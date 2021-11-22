<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
	<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<style>
	
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

